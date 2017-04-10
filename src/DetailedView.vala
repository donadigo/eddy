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
    public class DetailedView : Gtk.Box {
        private DebianPackage? current_package;

        private Gtk.Label name_label;
        private Gtk.Label version_label;
        private Gtk.Label installed_size_label;
        private Gtk.Label description_label;
        private Gtk.LinkButton homepage_button;

        construct {
            orientation = Gtk.Orientation.VERTICAL;
            margin = 24;

            name_label = new Gtk.Label (_("Unknown"));
            version_label = new Gtk.Label (_("Unknown"));
            version_label.halign = Gtk.Align.START;

            installed_size_label = new Gtk.Label (_("Unknown"));
            installed_size_label.halign = Gtk.Align.START;

            description_label = new Gtk.Label (_("Unknown"));
            description_label.wrap_mode = Pango.WrapMode.CHAR;
            description_label.wrap = true;
            description_label.selectable = true;
            description_label.halign = Gtk.Align.START;
            description_label.margin_top = 12;

            homepage_button = new Gtk.LinkButton.with_label ("", _("Homepage"));
            homepage_button.no_show_all = true;

            var header_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
            header_box.add (name_label);
            header_box.pack_end (homepage_button, false, false);

            add (header_box);
            add (version_label);
            add (installed_size_label);
            add (description_label);
        }

        public void set_package (DebianPackage package) {
            current_package = package;

            name_label.label = _("Package name: %s".printf (package.name));
            version_label.label = _("Version: %s".printf (package.version));
            installed_size_label.label = _("Installed size: %s".printf (format_size (package.installed_size)));
            homepage_button.uri = package.homepage;
            description_label.label = package.description.strip ();

            homepage_button.visible = package.homepage.strip () != "";
        }

        public DebianPackage? get_package () {
            return current_package;
        }
    }
}