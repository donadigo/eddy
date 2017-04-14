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
    public class PackageListView : Gtk.Box {
        public signal void no_packages ();
        public signal void install ();

        public signal void added (DebianPackage package);
        public signal void show_package_details (DebianPackage package);
        public signal void removed (DebianPackage package);

        public bool installing { get; set; }

        private Gtk.ListBox list_box;
        private Gtk.Label installed_size_label;

        private Gtk.Button install_button;

        construct {
            orientation = Gtk.Orientation.VERTICAL;
            spacing = 6;

            installed_size_label = new Gtk.Label ("");

            install_button = new Gtk.Button.with_label (_("Install"));
            install_button.clicked.connect (() => install ());
            install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            var button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            button_box.margin = 12;
            button_box.add (installed_size_label);
            button_box.pack_end (install_button, false, false);

            var button_row = new Gtk.ListBoxRow ();
            button_row.add (button_box);
            button_row.selectable = false;
            button_row.activatable = false;

            list_box = new Gtk.ListBox ();
            list_box.expand = true;
            list_box.row_activated.connect (on_row_activated);
            list_box.add (button_row);

            var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
            main_box.add (list_box);

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scrolled.add (main_box);

            bind_property ("installing", install_button, "sensitive", BindingFlags.SYNC_CREATE | BindingFlags.INVERT_BOOLEAN);
            add (scrolled);
        }

        public void add_package (DebianPackage package) {
            var row = new PackageRow (package);
            row.changed.connect (update);
            row.removed.connect (on_row_removed);
            list_box.insert (row, 1);

            update ();
            added (package);
            show_all ();
        }

        public bool contains_filename (string filename) {
            foreach (PackageRow row in get_package_rows ()) {
                if (row.package.filename == filename) {
                    return true;
                }
            }

            return false;
        }

        private void update () {
            var rows = get_package_rows ();

            uint size = rows.size;
            if (size == 0) {
                no_packages ();
            }

            uint total_installed_size = 0;
            foreach (var row in rows) {
                total_installed_size += row.package.installed_size;
            }

            installed_size_label.label = _("Total installed size: %s".printf (format_size (total_installed_size)));
            install_button.sensitive = !installing && size > 0;
        }

        private Gee.ArrayList<PackageRow> get_package_rows () {
            var rows = new Gee.ArrayList<PackageRow> ();
            foreach (var child in list_box.get_children ()) {
                if (child is PackageRow) {
                    rows.add ((PackageRow)child);
                }
            }

            return rows;
        }

        private void on_row_removed (PackageRow row) {
            row.destroy ();
            update ();
            removed (row.package);
        }

        private void on_row_activated (Gtk.ListBoxRow row) {
            show_package_details (((PackageRow)row).package);
        }        
    }
}