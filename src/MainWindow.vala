/*-
 * Copyright 2021 Adam Bieńkowski <donadigos159@gmail.com>
 *
 * This program is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see http://www.gnu.org/licenses/.
 */

public static void set_widget_visible (Gtk.Widget widget, bool visible) {
    widget.no_show_all = !visible;
    widget.visible = visible;
}

public class Eddy.MainWindow : Gtk.Window {
    private const string WELCOME_VIEW_ID = "welcome-view";
    private const string LIST_VIEW_ID = "list-view";
    private const string DETAILED_VIEW_ID = "detailed-view";
    private const string SPINNER_VIEW_ID = "spinner-view";
    private const string BRAND_STYLESHEET = """
        @define-color color_primary #e6334d;
        @define-color accent_color @color_primary;

        .title, .titlebutton, .image-button {
            color: #f2f2f2;
            text-shadow: 0 1px #b52136;
        }

        /* elementary OS 5 backwards compatibility */
        @define-color colorPrimary @color_primary;
        @define-color textColorPrimary #f2f2f2;
        @define-color textColorPrimaryShadow #7b1b29;

    """;

#if HAVE_UNITY
    private static Unity.LauncherEntry unity_entry;
#endif

    private Gtk.Stack stack;
    private Gtk.Grid spinner_grid;

    private Gtk.Revealer open_button_revealer;
    private Gtk.Button open_button;

    private Gtk.Button back_button;

    private Granite.Widgets.Welcome welcome_view;
    private PackageListView list_view;
    private DetailedView detailed_view;

    private Gtk.HeaderBar header_bar;
    private Gtk.Image warn_image;

    private int open_index = -1;
    private int log_index = -1;
    private int open_dowloads_index = -1;

    private string main_extension;
    private PackageUri[] download_uris;

    private Cancellable? install_cancellable;

    // TODO: since Unity is no longer developed, this API will probably go away and
    // be ported into something more abstract like GLib.Application
#if HAVE_UNITY
    static construct {
        unity_entry = Unity.LauncherEntry.get_for_desktop_id (Constants.DESKTOP_NAME);
    }
#endif

    construct {
        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
        stack.get_style_context ().add_class (Gtk.STYLE_CLASS_VIEW);

        list_view = new PackageListView ();
        list_view.install_all.connect ((packages) => on_install_all.begin ());
        list_view.perform_default_action.connect ((package) => on_perform_default_action.begin (package));
        list_view.reinstall.connect ((package) => on_reinstall.begin (package));
        list_view.show_package_details.connect (on_show_package_details);
        list_view.added.connect (on_package_added);
        list_view.removed.connect (on_package_removed);
        list_view.update_lock_status.connect (on_update_lock_status);

        detailed_view = new DetailedView ();

        var spinner = new Gtk.Spinner ();
        spinner.start ();

        spinner_grid = new Gtk.Grid ();
        spinner_grid.halign = Gtk.Align.CENTER;
        spinner_grid.valign = Gtk.Align.CENTER;
        spinner_grid.add (spinner);

        open_button = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);
        open_button.tooltip_text = _("Open…");
        open_button.clicked.connect (show_open_dialog);

        open_button_revealer = new Gtk.Revealer ();
        open_button_revealer.transition_type = Gtk.RevealerTransitionType.CROSSFADE;
        open_button_revealer.add (open_button);

        back_button = new Gtk.Button.from_icon_name ("go-previous-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
        back_button.tooltip_text = _("Go back");
        back_button.clicked.connect (on_back_button_clicked);
        set_widget_visible (back_button, false);

        warn_image = new Gtk.Image.from_icon_name ("dialog-warning", Gtk.IconSize.LARGE_TOOLBAR);
        warn_image.tooltip_text = _("Other applications may interrupt tasks currently performed by Eddy");
        set_widget_visible (warn_image, false);

        set_size_request (700, 600);

        header_bar = new Gtk.HeaderBar ();
        header_bar.set_title (Constants.APP_NAME);
        header_bar.show_close_button = true;
        header_bar.has_subtitle = false;
        header_bar.pack_start (back_button);
        header_bar.pack_start (open_button_revealer);
        header_bar.pack_end (warn_image);
        set_titlebar (header_bar);

        debug ("Resolving extension for supported mime types");
        var helper = MimeTypeHelper.get_default ();
        main_extension = helper.resolve_extension_for_mime_types (Application.supported_mimetypes);

        welcome_view = new Granite.Widgets.Welcome (_("Install some apps"), _("Drag and drop .%s files or open them to begin installation.").printf (main_extension));
        welcome_view.margin_start = welcome_view.margin_end = 6;
        open_index = welcome_view.append ("document-open", _("Open"), _("Browse to open a single file"));

        welcome_view.activated.connect (on_welcome_view_activated);

        populate_installed_apps.begin ();

        stack.add_named (welcome_view, WELCOME_VIEW_ID);
        stack.add_named (spinner_grid, SPINNER_VIEW_ID);
        stack.add_named (list_view, LIST_VIEW_ID);
        stack.add_named (detailed_view, DETAILED_VIEW_ID);

        add (stack);

        var provider = new Gtk.CssProvider ();
        try {
            provider.load_from_data (BRAND_STYLESHEET, -1);
            Gtk.StyleContext.add_provider_for_screen (get_screen (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        } catch (Error e) {
            warning ("Could not create CSS Provider: %s", e.message);
        }

        Gtk.drag_dest_set (this, Gtk.DestDefaults.MOTION | Gtk.DestDefaults.DROP, Constants.DRAG_TARGETS, Gdk.DragAction.COPY);

        var settings = AppSettings.get_default ();

        int x = settings.window_x;
        int y = settings.window_y;

        if (x != -1 && y != -1) {
            move (x, y);
        }

        resize (settings.window_width, settings.window_height);
        if (settings.window_maximized) {
            maximize ();
        }

        set_keep_above (settings.always_on_top);

        drag_data_received.connect (on_drag_data_received);

        Unix.signal_add (Posix.Signal.INT, signal_source_func, Priority.HIGH);
        Unix.signal_add (Posix.Signal.TERM, signal_source_func, Priority.HIGH);
    }

    public override bool delete_event (Gdk.EventAny event) {
        return request_quit ();
    }

    private bool signal_source_func () {
        if (!request_quit ()) {
            destroy ();
        }

        return true;
    }

    private bool request_quit () {
        var packges = new Gee.ArrayList<Package> ();

        var rows = list_view.get_package_rows ();
        foreach (var row in rows) {
            var package = row.package;
            if (package.has_task) {
                packges.add (package);
            }
        }

        uint size = packges.size;
        if (size > 0) {
            string operations_str = ngettext (_("There is %u operation unfinished").printf (size), _("There are %u operations unfinished").printf (size), size);
            var dialog = new Granite.MessageDialog.with_image_from_icon_name (_("There Are Ongoing Operations"),
                _("%s. Quitting will cancel all remaining transactions.").printf (operations_str),
                "dialog-warning",
                Gtk.ButtonsType.NONE);
            dialog.add_button (_("Do Not Quit"), 0);

            var button = new Gtk.Button.with_label (_("Quit Anyway"));
            button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            dialog.add_action_widget (button, 1);

            dialog.show_all ();
            int res = dialog.run ();
            switch (res) {
                case 0:
                    dialog.destroy ();
                    return true;
                case 1:
                    if (install_cancellable != null) {
                        install_cancellable.cancel ();
                    } else {
                        foreach (var package in packges) {
                            package.cancel ();
                        }
                    }

                    dialog.destroy ();
                    break;
            }
        }

        int x, y, width, height;
        get_position (out x, out y);
        get_size (out width, out height);

        var settings = AppSettings.get_default ();
        settings.window_x = x;
        settings.window_y = y;
        settings.window_width = width;
        settings.window_height = height;
        settings.window_maximized = is_maximized;

        var window = get_window ();
        if (window != null) {
            settings.always_on_top = Gdk.WindowState.ABOVE in window.get_state ();
        }

        return false;
    }

    private void install_all_progress_callback (Pk.Progress progress, Pk.ProgressType type) {
        switch (type) {
            case Pk.ProgressType.STATUS:
                var status = progress.get_status ();
#if HAVE_UNITY
                unity_entry.progress_visible = status != Pk.Status.FINISHED;
#endif

                unowned string title = Package.status_to_title (status);
                list_view.status = title;
                break;
#if HAVE_UNITY
            case Pk.ProgressType.PERCENTAGE:
                double percentage = ((double)progress.get_percentage ()) / 100;
                unity_entry.progress = percentage;
                break;
#endif
            default:
                break;
        }
    }

    private void operation_progress_callback (Pk.Progress progress, Pk.ProgressType type) {
#if HAVE_UNITY
        switch (type) {
            case Pk.ProgressType.STATUS:
                unity_entry.progress_visible = progress.get_status () != Pk.Status.FINISHED;
                break;
            case Pk.ProgressType.PERCENTAGE:
                double percentage = ((double)progress.get_percentage ()) / 100;
                unity_entry.progress = percentage;
                break;
        }
#endif
    }

    private void process_result (TransactionResult result) {
        if (result.cancelled || result.is_empty ()) {
            return;
        }

        bool install = result.role == Pk.Role.INSTALL_FILES;

        if (result.error != null) {
            string title;
            if (install) {
                title = _("Installation Failed");
            } else {
                title = _("Uninstallation Failed");
            }

            var dialog = new Granite.MessageDialog.with_image_from_icon_name (title, result.error.message, "dialog-error");
            dialog.show_all ();
            dialog.run ();
            dialog.destroy ();
        } else {
            var app = get_application ();
            if (app == null) {
                return;
            }

            int64 timestamp = -1;
            if (install) {
                timestamp = LogManager.get_default ().log_events (result);
            }

            foreach (Package package in result.packages) {
                package.installed_timestamp = timestamp;
            }

            var win = get_window ();
            if (win != null && (win.get_state () & Gdk.WindowState.FOCUSED) != 0) {
                return;
            }

            string title;
            string body;
            if (result.packages.size == 1) {
                if (install) {
                    title = _("Installation succeeded");
                    body = _("%s has been successfully installed").printf (result.packages[0].name);
                } else {
                    title = _("Uninstallation succeeded");
                    body = _("%s has been successfully uninstalled").printf (result.packages[0].name);
                }
            } else if (install) {
                title = _("Installation succeeded");
                body = _("All packages have been successfully installed");
            } else {
                title = _("Uninstallation succeeded");
                body = _("All packages have been successfully uninstalled");
            }

            var notification = new Notification (title);
            notification.set_body (body);
            notification.set_icon (new ThemedIcon ("com.github.donadigo.eddy"));
            app.send_notification ("installed", notification);
        }
    }

    private void add_open_downloads_entry () {
        open_dowloads_index = welcome_view.append ("folder-download", _("Load from Downloads"), _("Load .%s files from your Downloads folder").printf (main_extension));
        welcome_view.show_all ();
    }

    private async void populate_installed_apps () {
        int size = yield LogManager.get_default ().fetch ();
        if (size > 0) {
            log_index = welcome_view.append ("text-x-changelog", _("View Previously Installed Apps"), _("Browse history of installed applications"));
        }

        populate_download_folder_uris ();
    }

    private void populate_download_folder_uris () {
        string downloads_path = Environment.get_user_special_dir (UserDirectory.DOWNLOAD);
        var loader = new FolderLoader (downloads_path);

        ulong signal_id = 0U;
        signal_id = loader.notify["uris-loaded"].connect (() => {
            if (loader.uris_loaded > 0) {
                add_open_downloads_entry ();
                loader.disconnect (signal_id);
            }
        });

        loader.load.begin ((obj, res) => {
            download_uris = loader.load.end (res);
        });
    }

    public async void open_uris (PackageUri[] uris, bool validate = true) {
        if (stack.visible_child_name != LIST_VIEW_ID) {
            stack.visible_child_name = SPINNER_VIEW_ID;
        }

        string[] errors = {};
        int done = 0;
        foreach (unowned PackageUri puri in uris) {
            var file = File.new_for_uri (puri.uri);
            if (validate) {
                try {
                    var info = file.query_info (FileAttribute.STANDARD_CONTENT_TYPE, FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
                    if (!(info.get_content_type () in Application.supported_mimetypes)) {
                        errors += _("<b>%s</b> is not a package").printf (file.get_basename ());
                        done++;
                        if (done == uris.length) {
                            Idle.add (open_uris.callback);
                            break;
                        } else {
                            continue;
                        }
                    }
                } catch (Error e) {
                    errors += "<b>%s</b>: %s".printf (file.get_basename (), e.message);
                    done++;
                    if (done == uris.length) {
                        Idle.add (open_uris.callback);
                        break;
                    } else {
                        continue;
                    }
                }
            }

            string filename = file.get_path ();
            if (list_view.has_filename (filename)) {
                done++;
                if (done == uris.length) {
                    Idle.add (open_uris.callback);
                    break;
                } else {
                    continue;
                }
            }

            var package = new Package (filename);
            package.installed_timestamp = puri.installed_timestamp;
            package.populate.begin ((obj, res) => {
                try {
                    bool success = package.populate.end (res);
                    if (success) {
                        list_view.add_package (package);
                    } else {
                        errors += _("<b>%s</b> is not a valid package").printf (file.get_basename ());
                    }
                } catch (Error e) {
                    errors += "<b>%s</b>: %s".printf (file.get_basename (), e.message);
                }

                done++;
                if (done == uris.length) {
                    Idle.add (open_uris.callback);
                }
            });
        }

        yield;

        if (errors.length > 0) {
            if (list_view.get_package_rows ().size == 0) {
                stack.visible_child_name = WELCOME_VIEW_ID;
            }

            var builder = new StringBuilder ();
            foreach (string error in errors) {
                builder.append (error);
                builder.append_c ('\n');
            }

            var dialog = new Granite.MessageDialog.with_image_from_icon_name (_("Some Packages Could Not Be Added"), builder.str, "dialog-warning");
            dialog.title = Constants.APP_NAME;
            dialog.show_all ();
            dialog.run ();
            dialog.destroy ();
        }
    }

    private void show_open_dialog () {
        var filter = new Gtk.FileFilter ();
        filter.set_filter_name (_("Packages"));
        foreach (string mime_type in Application.supported_mimetypes) {
            filter.add_mime_type (mime_type);
        }

        var all_filter = new Gtk.FileFilter ();
        all_filter.set_filter_name (_("All Files"));
        all_filter.add_pattern ("*");

        var chooser = new Gtk.FileChooserDialog ("Select packages to install",
                        this,
                        Gtk.FileChooserAction.OPEN,
                        _("Cancel"),
                        Gtk.ResponseType.CANCEL,
                        _("Open"),
                        Gtk.ResponseType.ACCEPT);
        chooser.add_filter (filter);
        chooser.add_filter (all_filter);

        chooser.response.connect (on_chooser_response);
        chooser.run ();
    }

    private void on_chooser_response (Gtk.Dialog chooser, int response) {
        var log_manager = LogManager.get_default ();
        if (response == Gtk.ResponseType.ACCEPT) {
            PackageUri[] puris = {};
            foreach (unowned string uri in ((Gtk.FileChooserDialog)chooser).get_uris ()) {
                var puri = new PackageUri (uri, -1);
                log_manager.fill_out_external_uri (puri);
                puris += puri;
            }

            chooser.destroy ();
            open_uris.begin (puris);
        } else {
            chooser.destroy ();
        }
    }

    private async void on_install_all () {
        list_view.working = true;
        var packages = new Gee.ArrayList<Package> ();
        foreach (var row in list_view.get_package_rows ()) {
            packages.add (row.package);
        }

        install_cancellable = new Cancellable ();

        TransactionResult result;
        if (packages.size > 1) {
            result = yield Package.install_packages (packages, install_cancellable, install_all_progress_callback);
        } else {
            result = yield packages[0].install (null, operation_progress_callback);
        }

        list_view.status = "";
        install_cancellable = null;
        list_view.working = false;

        process_result (result);
    }

    private async void on_reinstall (Package package) {
        list_view.working = true;
        var result = yield package.install (null, operation_progress_callback);
        list_view.working = false;

        process_result (result);
    }

    private async void on_perform_default_action (Package package) {
        list_view.working = true;
        var result = yield package.perform_default_action (null, operation_progress_callback);
        list_view.working = false;

        process_result (result);
    }

    private void on_update_lock_status (bool locked) {
        if (warn_image.visible != locked) {
            set_widget_visible (warn_image, locked);
        }
    }

    private void on_package_added (Package package) {
        string name = stack.visible_child_name;
        if (name != LIST_VIEW_ID && name != DETAILED_VIEW_ID) {
            open_button_revealer.reveal_child = true;
            stack.visible_child_name = LIST_VIEW_ID;
        }
    }

    private void on_package_removed (Package package) {
        if (list_view.get_package_rows ().size == 0 && stack.visible_child_name != WELCOME_VIEW_ID) {
            open_button_revealer.reveal_child = false;
            stack.visible_child_name = WELCOME_VIEW_ID;
        }
    }

    private void on_back_button_clicked () {
        set_widget_visible (back_button, false);

        open_button.sensitive = true;
        stack.visible_child_name = LIST_VIEW_ID;
    }

    private void on_show_package_details (Package package) {
        detailed_view.set_package (package);

        set_widget_visible (back_button, true);

        open_button.sensitive = false;

        // Do not select any of the labels in the detailed view
        set_focus (null);

        stack.visible_child_name = DETAILED_VIEW_ID;
    }

    private void on_welcome_view_activated (int index) {
        if (index == open_index) {
            list_view.set_mode (PackageViewMode.NORMAL);
            show_open_dialog ();
        } else if (index == log_index) {
            list_view.set_mode (PackageViewMode.HISTORY);
            var log_manager = LogManager.get_default ();
            open_uris.begin (log_manager.get_installed_uris ().to_array (), false);
        } else if (index == open_dowloads_index) {
            list_view.set_mode (PackageViewMode.NORMAL);
            open_uris.begin (download_uris, false);
        }
    }

    private void on_drag_data_received (Gdk.DragContext drag_context, int x, int y,
                                        Gtk.SelectionData data, uint info, uint time) {
        var log_manager = LogManager.get_default ();
        PackageUri[] puris = {};
        foreach (string uri in data.get_uris ()) {
            var puri = new PackageUri (uri, -1);
            log_manager.fill_out_external_uri (puri);
            puris += puri;
        }

        open_uris.begin (puris);
        Gtk.drag_finish (drag_context, true, false, time);
    }
}
