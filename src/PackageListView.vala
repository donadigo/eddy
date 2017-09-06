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

public class Eddy.PackageListView : Gtk.Box {
    public signal void install_all ();
    public signal void perform_default_action (Package package);
    public signal void reinstall (Package package);

    public signal void added (Package package);
    public signal void show_package_details (Package package);
    public signal void removed (Package package);

    public bool working { get; set; }
    public string status {
        set {
            status_label.label = value;
            set_widget_visible (status_label, value != "");
        }
    }

    private Gtk.ListBox list_box;
    private Gtk.Label installed_size_label;

    private Gtk.Label status_label;
    private Gtk.Button install_button;

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        spacing = 6;

        installed_size_label = new Gtk.Label ("");

        install_button = new Gtk.Button.with_label (_("Install"));
        install_button.clicked.connect (() => install_all ());
        install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

        status_label = new Gtk.Label (null);

        var button_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        button_box.margin = 12;
        button_box.add (installed_size_label);
        button_box.pack_end (install_button, false, false);
        button_box.pack_end (status_label, false, false);

        var button_row = new Gtk.ListBoxRow ();
        button_row.add (button_box);
        button_row.selectable = false;
        button_row.activatable = false;

        list_box = new Gtk.ListBox ();
        list_box.expand = true;
        list_box.set_sort_func (sort_func);
        list_box.row_activated.connect (on_row_activated);
        list_box.add (button_row);

        var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        main_box.add (list_box);

        var scrolled = new Gtk.ScrolledWindow (null, null);
        scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
        scrolled.add (main_box);

        notify["working"].connect (update);
        add (scrolled);
    }

    public void add_package (Package package) {
        var row = new PackageRow (package);
        row.action_clicked.connect (() => perform_default_action (row.package));
        row.reinstall.connect (() => reinstall (row.package));
        row.removed.connect (on_row_removed);
        //  row.update_same_packages.connect (on_update_same_packages);
        list_box.insert (row, 1);

        update ();
        added (package);
        show_all ();
    }

    public bool has_filename (string filename) {
        foreach (PackageRow row in get_package_rows ()) {
            if (row.package.filename == filename) {
                return true;
            }
        }

        return false;
    }

    public Gee.ArrayList<PackageRow> get_package_rows () {
        var rows = new Gee.ArrayList<PackageRow> ();
        foreach (var child in list_box.get_children ()) {
            if (child is PackageRow) {
                rows.add ((PackageRow)child);
            }
        }

        return rows;
    }

    //  private Gee.ArrayList<PackageRow> get_package_rows_by_name (string name) {
    //     var rows = new Gee.ArrayList<PackageRow> ();
    //     foreach (var child in list_box.get_children ()) {
    //         var row = child as PackageRow;
    //         if (row == null) {
    //             continue;
    //         }

    //         if (row.package.name == name) {
    //             rows.add (row);
    //         }
    //     }   

    //     return rows;
    //  }

    public void update () {
        var rows = get_package_rows ();

        bool has_installed = false;
        uint64 total_package_installed_size = 0;
        foreach (var row in rows) {
            var package = row.package;
            total_package_installed_size += package.installed_size;
            if (!has_installed && package.is_installed) {
                has_installed = true;
            }
        }

        set_widget_visible (install_button, !has_installed);
        foreach (var row in rows) {
            if (!row.package.has_task) {
                row.show_action_button = has_installed;
            }
        }

        installed_size_label.label = _("Total installed size: %s".printf (format_size (total_package_installed_size)));
        install_button.sensitive = !working && rows.size > 0;
    }

    private int sort_func (Gtk.ListBoxRow row1, Gtk.ListBoxRow row2) {
        var package_row1 = row1 as PackageRow;
        if (package_row1 == null) {
            return 0;
        }

        var package_row2 = row2 as PackageRow;
        if (package_row2 == null) {
            return 0;
        }

        var package1 = package_row1.package;
        var package2 = package_row2.package;

        if (package1.has_task && !package2.has_task) {
            return -1;
        } else if (!package1.has_task && package2.has_task) {
            return 1;
        }

        if (package1.is_installed && !package2.is_installed) {
            return 1;
        } else if (!package1.is_installed && package2.is_installed) {
            return -1;
        }

        if (package1.can_update && !package2.can_update) {
            return 1;
        } else if (!package1.can_update && package2.can_update) {
            return -1;
        }

        if (package1.can_downgrade && !package2.can_downgrade) {
            return 1;
        } else if (!package1.can_downgrade && package2.can_downgrade) {
            return -1;
        }

        return package1.name.collate (package2.name);
    }

    private void on_row_removed (PackageRow row) {
        row.destroy ();
        update ();
        removed (row.package);
    }

    // TODO: this has an issue with update_same_packages () signal recursion 
    // The user could have added two same packages with different versions
    // so we probably need to update those also
    //  private void on_update_same_packages (PackageRow row) {
    //     var rows = get_package_rows_by_name (row.package.name);
    //     foreach (var _row in rows) {
    //         // Do not update an already changed one
    //         if (row == _row) {
    //             continue;
    //         }

    //         _row.package.update_installed_state.begin ();
    //     }
    //  }

    private void on_row_activated (Gtk.ListBoxRow row) {
        show_package_details (((PackageRow)row).package);
    }
}
