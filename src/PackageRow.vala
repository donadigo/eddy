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
    public class PackageRow : Gtk.ListBoxRow {
        public signal void changed ();
        public DebianPackage package { get; construct; }

        private Gtk.CheckButton select_switch;

        construct {
            select_switch = new Gtk.CheckButton ();
            select_switch.active = true;
            select_switch.notify["active"].connect (on_select_switch_changed);

            var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
            main_box.margin = 12;

            var package_image = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);

            var summary_label = new Gtk.Label ("<b>%s</b>".printf (package.summary));
            summary_label.use_markup = true;
            summary_label.halign = Gtk.Align.START;

            var name_label = new Gtk.Label (package.name);
            name_label.halign = Gtk.Align.START;

            var vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
            vertical_box.add (summary_label);
            vertical_box.add (name_label);

            main_box.add (package_image);
            main_box.add (vertical_box);
            main_box.pack_end (select_switch, false, false);

            add (main_box);            
        }

        public PackageRow (DebianPackage package) {
            Object (package: package);
        }

        public void set_selected (bool selected) {
            select_switch.active = selected;
        }

        public bool get_selected () {
            return select_switch.get_active ();
        }

        private void on_select_switch_changed () {
            changed ();
        }
    }
}