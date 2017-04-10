/***
  Copyright (C) 2015-2016 Adam Bieńkowski <donadigos159gmail.com>
  This program is free software: you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License version 3, as
  published by the Free Software Foundation.
  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranties of
  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License for more details.
  You should have received a copy of the GNU General Public License along
  with this program.  If not, see <http://www.gnu.org/licenses>
***/

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
            string? next_tid = null;
            foreach (var package in packages) {
                string tid = yield package.prepare_transaction ();
                if (tid == null) {
                    // Handle this
                    continue;
                }

                var transaction = AptProxy.get_transaction (tid);
                if (transaction == null) {
                    // This also
                    return;
                }

                package.install.begin (transaction, next_tid);
                next_tid = tid;
            }
        }

        private void open_uris (string[] uris) {
            foreach (string uri in uris) {
                string path = Uri.unescape_string (uri.replace ("file://", "").replace ("file:/", ""));
                var file = File.new_for_path (path);
                var file_info = file.query_info ("*", FileQueryInfoFlags.NONE);
                if (!(file_info.get_content_type () in Constants.SUPPORTED_MIMETYPES)) {
                    show_content_type_error ();
                    return;
                }

                string filename = file.get_path ();
                if (list_view.contains_filename (filename)) {
                    return;
                }

                var package = new DebianPackage (filename);
                package.populate_data.begin ((obj, res) => {
                    package.populate_data.end (res);
                    if (!package.valid) {
                        show_package_not_valid_error ();
                        return;
                    }

                    list_view.add_package (package);
                    stack.visible_child_name = Constants.LIST_VIEW_ID;
                });
            }
        }

        private void show_content_type_error () {

        }

        private void show_package_not_valid_error () {

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
                if (response == -3) {
                    string[] uris = {};
                    foreach (unowned string uri in chooser.get_uris ()) {
                        uris += uri;
                    }

                    open_uris (uris);
                }
            });

            chooser.run ();
            chooser.destroy ();
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