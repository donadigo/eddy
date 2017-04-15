/*-
 * Copyright (c) 2017 Adam Bieńkowski
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by: Adam Bieńkowski <donadigos159@gmail.com>
 */

namespace Eddy {
    public static void set_widget_visible (Gtk.Widget widget, bool visible) {
        widget.no_show_all = !visible;
        widget.visible = visible;
    }

    public class EddyWindow : Gtk.Window {
        private const string WELCOME_VIEW_ID = "welcome-view";
        private const string LIST_VIEW_ID = "list-view";
        private const string DETAILED_VIEW_ID = "detailed-view";

        private DebianPackageManager installer;

        private Gtk.Stack stack;

        private Gtk.Revealer open_button_revealer;
        private Gtk.Button open_button;

        private Gtk.Button back_button;

        private PackageListView list_view;
        private DetailedView detailed_view;

        private Gtk.HeaderBar header_bar;

        private int open_index;
        private int open_dowloads_index;

        construct {
            installer = new DebianPackageManager ();

            stack = new Gtk.Stack ();
            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;

            list_view = new PackageListView ();
            list_view.perform_default_action.connect ((package) => on_perform_default_action.begin (package));
            list_view.show_package_details.connect (on_show_package_details);
            list_view.install_all.connect ((packages) => install_all.begin ());
            list_view.added.connect (on_package_added);
            list_view.removed.connect (on_package_removed);

            detailed_view = new DetailedView ();

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

            set_default_size (650, 550);
            set_size_request (700, 600);

            header_bar = new Gtk.HeaderBar ();
            header_bar.set_title (Constants.APP_NAME);
            header_bar.show_close_button = true;
            header_bar.pack_start (back_button);
            header_bar.pack_start (open_button_revealer);
            set_titlebar (header_bar);

            var welcome_view = new Granite.Widgets.Welcome (_("Install some apps"), _("Drag and drop .deb files or open them to begin installation."));
            open_index = welcome_view.append ("document-open", _("Open"), _("Browse to open a single file"));
            open_dowloads_index = welcome_view.append ("folder-download", _("Load from Downloads"), _("Load debian files from your Downloads folder"));
            welcome_view.activated.connect (on_welcome_view_activated);

            stack.add_named (welcome_view, WELCOME_VIEW_ID);
            stack.add_named (list_view, LIST_VIEW_ID);
            stack.add_named (detailed_view, DETAILED_VIEW_ID);

            add (stack);

            Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
            Gtk.drag_dest_set (this, Gtk.DestDefaults.MOTION | Gtk.DestDefaults.DROP, Constants.DRAG_TARGETS, Gdk.DragAction.COPY);

            destroy.connect (Gtk.main_quit);
            drag_data_received.connect (on_drag_data_received);
        }

        private async void install_all () {
            list_view.working = true;
            var results = yield installer.install ();
            list_view.working = false;

            process_results (results);
        }

        private void process_results (Gee.ArrayList<TransactionResult> results) {
            if (results.size == 0) {
                return;
            }

            var errors = new Gee.HashMap<string, TransactionError> ();
            foreach (var result in results) {
                var error = result.error;
                if (error != null) {
                    errors[result.package.name] = error;
                }
            }

            var first = results[0];
            bool install = first.action_is_install;

            uint errors_size = errors.size;
            if (errors_size > 0) {
                var builder = new StringBuilder ();

                uint i = 1;
                errors.@foreach ((entry) => {
                    string description = entry.value.get_text ();
                    builder.append ("%s: %s".printf (entry.key, description));
                    if (i < errors_size) {
                        builder.append_c ('\n');
                    }

                    i++;
                    return true;
                });

                string title;
                if (install) {
                    if (errors_size == results.size) {
                        title = _("Installation Failed");
                    } else {
                        title = _("Installation Partially Failed");
                    }
                } else if (errors_size == results.size) {
                    title = _("Uninstallation Failed");
                } else {
                    title = _("Uninstallation Partially Failed");
                }                    

                var dialog = new MessageDialog (title, builder.str, "dialog-error");
                dialog.add_button (_("Close"), 0);
                dialog.show_all ();
                dialog.run ();
                dialog.destroy ();
            } else {
                var app = get_application ();
                if (app == null) {
                    return;
                }

                var win = get_window ();
                if (win != null && (win.get_state () & Gdk.WindowState.FOCUSED) != 0) {
                    return;
                }

                string title;
                string body;
                if (results.size == 1) {
                    if (install) {
                        title = _("Installation succeeded");
                        body = _("%s has been successfully installed").printf (first.package.name);
                    } else {
                        title = _("Uninstallation succeeded");
                        body = _("%s has been successfully uninstalled").printf (first.package.name);
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

                notification.set_icon (new ThemedIcon ("eddy"));
                app.send_notification ("installed", notification);
            }
        }

        private string[] open_folder (string path) {
            var file = File.new_for_path (path);
            var enumerator = file.enumerate_children ("%s,%s".printf (FileAttribute.STANDARD_NAME, FileAttribute.STANDARD_CONTENT_TYPE), FileQueryInfoFlags.NOFOLLOW_SYMLINKS);

            string[] uris = {};
            FileInfo? info = null;
            while ((info = enumerator.next_file (null)) != null) {
                if (info.get_file_type () == FileType.DIRECTORY) {
                    var subdir = file.resolve_relative_path (info.get_name ());
                    string[] suburis = open_folder (subdir.get_path ());
                    foreach (string uri in suburis) {
                        uris += uri;
                    }
                } else if (info.get_content_type () in Constants.SUPPORTED_MIMETYPES) {          
                    try {
                        var subfile = file.resolve_relative_path (info.get_name ());
                        string? uri = Filename.to_uri (subfile.get_path (), null);
                        if (uri != null) {
                            uris += uri;
                        }
                    } catch (ConvertError e) {
                        warning (e.message);
                    }
                }
            }

            return uris;
        }

        private void open_uris (string[] uris, bool validate = true) {
            string[] errors = {};
            foreach (string uri in uris) {
                var file = File.new_for_uri (uri);
                if (validate) {
                    try {
                        var info = file.query_info (FileAttribute.STANDARD_CONTENT_TYPE, FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
                        if (!(info.get_content_type () in Constants.SUPPORTED_MIMETYPES)) {
                            errors += _("%s is not a debian package").printf (file.get_basename ());
                            continue;
                        }
                    } catch (Error e) {
                        warning (e.message);
                        continue;                
                    }
                }

                string filename = file.get_path ();
                if (list_view.contains_filename (filename)) {
                    continue;
                }

                var package = new DebianPackage (filename);
                package.populate_data.begin ((obj, res) => {
                    if (validate && !package.valid) {
                        errors += _("%s is not valid").printf (file.get_basename ());
                        return;
                    }

                    list_view.add_package (package);
                });
            }

            if (errors.length > 0) {
                var builder = new StringBuilder ();
                foreach (string error in errors) {
                    builder.append (error);
                    builder.append_c ('\n');
                }

                var dialog = new MessageDialog (_("Some Packages Could Not Be Added"), builder.str, "dialog-warning");
                dialog.add_button (_("Close"), 0);
                dialog.show_all ();
                dialog.run ();
                dialog.destroy ();
            }
        }

        private void show_open_dialog () {
            var debian_filter = new Gtk.FileFilter ();
            debian_filter.set_filter_name (_("Debian Packages"));
            foreach (string mime_type in Constants.SUPPORTED_MIMETYPES) {
                debian_filter.add_mime_type (mime_type);
            }

            var all_filter = new Gtk.FileFilter ();
            all_filter.set_filter_name (_("All Files"));
            all_filter.add_pattern ("*");

            var chooser = new Gtk.FileChooserDialog ("Select debian packages to install",
                            this,
                            Gtk.FileChooserAction.OPEN,
                            _("Cancel"),
                            Gtk.ResponseType.CANCEL,
                            _("Open"),
                            Gtk.ResponseType.ACCEPT);
            chooser.add_filter (debian_filter);
            chooser.add_filter (all_filter);

            chooser.response.connect ((response) => {
                if (response == Gtk.ResponseType.ACCEPT) {
                    string[] uris = {};
                    foreach (unowned string uri in chooser.get_uris ()) {
                        uris += uri;
                    }

                    chooser.destroy ();
                    open_uris (uris);
                } else {
                    chooser.destroy ();
                }
            });

            chooser.run ();
        }

        private async void on_perform_default_action (DebianPackage package) {
            list_view.working = true;
            var results = yield DebianPackageManager.perform_default_action (package);
            list_view.working = false;
            
            process_results (results);
        }

        private void on_package_added (DebianPackage package) {
            if (stack.visible_child_name != LIST_VIEW_ID) {
                open_button_revealer.reveal_child = true;
                stack.visible_child_name = LIST_VIEW_ID;
            }

            installer.add_package (package);
        }

        private void on_package_removed (DebianPackage package) {
            if (list_view.get_package_rows ().size == 0 && stack.visible_child_name != WELCOME_VIEW_ID) {
                open_button_revealer.reveal_child = false;
                stack.visible_child_name = WELCOME_VIEW_ID;
            }

            installer.remove_package (package);
        }

        private void on_back_button_clicked () {
            set_widget_visible (back_button, false);

            open_button.sensitive = true;     
            stack.visible_child_name = LIST_VIEW_ID;       
        }

        private void on_show_package_details (DebianPackage package) {
            detailed_view.set_package (package);

            set_widget_visible (back_button, true);

            open_button.sensitive = false;
            stack.visible_child_name = DETAILED_VIEW_ID;
        }

        private void on_welcome_view_activated (int index) {
            if (index == open_index) {
                show_open_dialog ();
            } else if (index == open_dowloads_index) {
                string path = Environment.get_user_special_dir (UserDirectory.DOWNLOAD);
                string[] uris = open_folder (path);
                open_uris (uris, false);
            }
        }

        private void on_drag_data_received (Gdk.DragContext drag_context, int x, int y,
                                            Gtk.SelectionData data, uint info, uint time) {
            open_uris (data.get_uris ());
            Gtk.drag_finish (drag_context, true, false, time);
        }
    }
}