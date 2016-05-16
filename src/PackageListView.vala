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
    public class PackageListView : Gtk.Box {
        public signal void show_package_details (DebianPackage package);
        public signal void install (List<DebianPackage> packages);

        private List<PackageRow> rows;

        private Gtk.ListBox list_box;
        private Gtk.Label installed_size_label;

        private Gtk.Button install_button;
        private Gtk.Button select_all_button;
        private Gtk.Button deselect_all_button;

        public PackageListView () {
            rows = new List<PackageRow> ();

            list_box = new Gtk.ListBox ();
            list_box.row_activated.connect (on_row_activated);
            installed_size_label = new Gtk.Label ("");

            orientation = Gtk.Orientation.VERTICAL;
            spacing = 6;

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scrolled.add (list_box);            

            var frame = new Gtk.Frame (null);
            frame.expand = true;
            frame.add (scrolled);

            add (frame);

            install_button = new Gtk.Button.with_label (_("Install"));
            install_button.clicked.connect (on_install_button_clicked);
            install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            select_all_button = new Gtk.Button.with_label (_("Select all"));
            select_all_button.clicked.connect (on_select_all_button_clicked);
            select_all_button.sensitive = false;

            deselect_all_button = new Gtk.Button.with_label (_("Deselect all"));
            deselect_all_button.clicked.connect (on_deselect_all_button_clicked);
            deselect_all_button.sensitive = false;

            var bottom_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            bottom_box.add (installed_size_label);
            bottom_box.pack_end (install_button, false, false);
            bottom_box.pack_end (select_all_button, false, false);
            bottom_box.pack_end (deselect_all_button, false, false);

            add (bottom_box);
        }

        public void add_package (DebianPackage package) {
            var row = new PackageRow (package);
            row.changed.connect (update);
            rows.append (row);
            list_box.insert (row, 0);

            update ();
            show_all ();
        }

        private void update () {
            update_packages_size ();

            int selected = 0;
            foreach (PackageRow row in rows) {
                if (row.get_selected ()) {
                    selected++;
                }
            }

            install_button.sensitive = selected > 0;
            select_all_button.sensitive = rows.length () > selected;
            deselect_all_button.sensitive = selected > 0;
        }

        private void update_packages_size () {
            uint total_installed_size = 0;
            foreach (PackageRow row in rows) {
                if (row.get_selected ()) {
                    total_installed_size += row.package.installed_size;
                }
            }

            installed_size_label.label = _("Total installed size: %s".printf (format_size (total_installed_size)));
        }

        private void on_install_button_clicked () {
            var packages = new List<DebianPackage> ();
            foreach (PackageRow row in rows) {
                if (row.get_selected ()) {
                    packages.append (row.package);
                }
            }

            install (packages);
        }

        private void on_select_all_button_clicked () {
            foreach (PackageRow row in rows) {
                row.set_selected (true);
            }
        }

        private void on_deselect_all_button_clicked () {
            foreach (PackageRow row in rows) {
                row.set_selected (false);
            }            
        }

        private void on_row_activated (Gtk.ListBoxRow row) {
            show_package_details (((PackageRow)row).package);
        }        
    }
}