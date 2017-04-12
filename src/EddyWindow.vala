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
    public class EddyWindow : Gtk.Window {
        private Gtk.Stack stack;
        private Gtk.Button open_button;
        private Gtk.Button back_button;

        private PackageListView list_view;
        private DetailedView detailed_view;
        private ProgressView progress_view;

        private Gtk.HeaderBar header_bar;

        construct {
            stack = new Gtk.Stack ();
            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;

            list_view = new PackageListView ();
            list_view.show_package_details.connect (on_show_package_details);
            list_view.install.connect ((packages) => install.begin (packages));

            detailed_view = new DetailedView ();
            progress_view = new ProgressView ();

            open_button = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);
            open_button.tooltip_text = _("Open…");
            open_button.clicked.connect (show_open_dialog);
            open_button.visible = false;

            back_button = new Gtk.Button.from_icon_name ("go-previous-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
            back_button.no_show_all = true;
            back_button.tooltip_text = _("Go back");
            back_button.clicked.connect (on_back_button_clicked);

            set_default_size (650, 550);
            set_size_request (700, 600);

            header_bar = new Gtk.HeaderBar ();
            header_bar.set_title (Constants.APP_NAME);
            header_bar.show_close_button = true;
            header_bar.pack_start (back_button);
            header_bar.pack_start (open_button);
            set_titlebar (header_bar);

            var welcome_view = new Granite.Widgets.Welcome (_("Install some apps"), _("Drag and drop .deb files or open them to begin installation."));
            int open_index = welcome_view.append ("document-open", _("Open"), _("Browse to open a single file"));
            welcome_view.activated.connect ((index) => {
                if (index != open_index) {
                    return;
                }

                show_open_dialog ();
            });

            stack.add_named (welcome_view, Constants.WELCOME_VIEW_ID);
            stack.add_named (list_view, Constants.LIST_VIEW_ID);
            stack.add_named (detailed_view, Constants.DETAILED_VIEW_ID);
            stack.add_named (progress_view, Constants.PROGRESS_VIEW_ID);

            add (stack);

            Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
            Gtk.drag_dest_set (this, Gtk.DestDefaults.MOTION | Gtk.DestDefaults.DROP, Constants.DRAG_TARGETS, Gdk.DragAction.COPY);

            destroy.connect (Gtk.main_quit);
            drag_data_received.connect (on_drag_data_received);
        }

        private async void install (Gee.ArrayList<DebianPackage> packages) {
            list_view.installing = true;
            var results = yield DebianPackageInstaller.install_packages (packages);
            list_view.installing = false;

            var errors = new Gee.HashMap<string, TransactionError> ();
            foreach (var result in results) {
                var error = result.error;
                if (error != null) {
                    errors[result.package.name] = error;
                }
            }

            uint size = errors.size;
            if (size > 0) {
                var builder = new StringBuilder ();

                uint i = 1;
                errors.@foreach ((entry) => {
                    string description = entry.value.get_text ();
                    builder.append ("%s: %s".printf (entry.key, description));
                    if (i < size) {
                        builder.append_c ('\n');
                    }

                    i++;
                    return true;
                });

                string title;
                if (size == results.size) {
                    title = _("Installation failed");
                } else {
                    title = _("Installation partially failed");
                }

                var dialog = new MessageDialog (title, builder.str, "dialog-error");
                dialog.add_button (_("Close"), 0);
                dialog.show_all ();
                dialog.run ();
                dialog.destroy ();
            }
        }

        private void open_uris (string[] uris) {
            string[] errors = {};
            foreach (string uri in uris) {
                var file = File.new_for_uri (uri);
                try {
                    var file_info = file.query_info (FileAttribute.STANDARD_CONTENT_TYPE, FileQueryInfoFlags.NONE);
                    if (!(file_info.get_content_type () in Constants.SUPPORTED_MIMETYPES)) {
                        errors += _("%s is not a debian package").printf (file.get_basename ());
                        continue;
                    }
                } catch (Error e) {
                    warning (e.message);
                    continue;                
                }

                string filename = file.get_path ();
                if (list_view.contains_filename (filename)) {
                    continue;
                }

                var package = new DebianPackage (filename);
                package.populate_data.begin ((obj, res) => {
                    if (!package.valid) {
                        errors += _("%s is not valid").printf (file.get_basename ());
                        return;
                    }

                    list_view.add_package (package);
                    stack.visible_child_name = Constants.LIST_VIEW_ID;
                });
            }

            if (errors.length > 0) {
                var builder = new StringBuilder ();
                foreach (string error in errors) {
                    builder.append (error);
                    builder.append_c ('\n');
                }

                var dialog = new MessageDialog (_("Some packages could not be added"), builder.str, "dialog-warning");
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

            var chooser = new Gtk.FileChooserDialog ("Select your favorite file",
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

        private void on_back_button_clicked () {
            back_button.visible = false;
            open_button.sensitive = true;     
            stack.visible_child_name = Constants.LIST_VIEW_ID;       
        }

        private void on_show_package_details (DebianPackage package) {
            detailed_view.set_package (package);

            back_button.visible = true;
            open_button.sensitive = false;
            stack.visible_child_name = Constants.DETAILED_VIEW_ID;
        }

        private void on_drag_data_received (Gdk.DragContext drag_context, int x, int y,
                                            Gtk.SelectionData data, uint info, uint time) {
            open_uris (data.get_uris ());
            Gtk.drag_finish (drag_context, true, false, time);
        }
    }
}