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
    public class ProgressView : Gtk.Box {
        private class SingleProgressView : Gtk.Grid {
            private DebianPackage package;

            private Gtk.ProgressBar progress_bar;

            public SingleProgressView (DebianPackage package) {
                this.package = package;
                orientation = Gtk.Orientation.HORIZONTAL;

                var image = new Gtk.Image.from_icon_name ("application-x-deb", Gtk.IconSize.DND);
                image.pixel_size = 160;

                var info_grid = new Gtk.Grid ();
                info_grid.orientation = Gtk.Orientation.VERTICAL;
                info_grid.hexpand = true;
                info_grid.halign = Gtk.Align.START;
                info_grid.valign = Gtk.Align.CENTER;

                var label = new Gtk.Label (_("Installing <b>%s</b>…").printf (package.name));
                label.halign = Gtk.Align.START;
                label.ellipsize = Pango.EllipsizeMode.END;
                label.use_markup = true;

                var path_label = new Gtk.Label (package.filename);
                path_label.halign = Gtk.Align.START;
                path_label.ellipsize = Pango.EllipsizeMode.MIDDLE;

                progress_bar = new Gtk.ProgressBar ();
                progress_bar.hexpand = true;

                info_grid.add (label);
                info_grid.add (path_label);
                info_grid.add (progress_bar);

                attach (image, 0, 0, 1, 1);
                attach (info_grid, 1, 0, 1, 1);
            }
        }

        private List<DebianPackage> queue;
        private DebianPackage? current_package = null;

        private Gtk.Stack stack;

        construct {
            queue = new List<DebianPackage> ();
            margin = 24;
            halign = Gtk.Align.CENTER;
            valign = Gtk.Align.CENTER;

            stack = new Gtk.Stack ();

            var main_grid = new Gtk.Grid ();
            main_grid.row_spacing = 12;
            main_grid.orientation = Gtk.Orientation.VERTICAL;

            main_grid.add (stack);

            add (main_grid);
        }

        public void set_queue (List<DebianPackage> packages) {
            foreach (DebianPackage package in packages) {
                queue.append (package);
            }
        }

        public void clear_queue () {
            queue.remove_all (queue.data);
        }

        public void set_current_package (DebianPackage? package) {
            current_package = package;

            var single = new SingleProgressView (package);
            stack.add (single);

            stack.visible_child = single;
        }
    }
}