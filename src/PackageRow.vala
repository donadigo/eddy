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
    public class PackageRow : Gtk.ListBoxRow {
        public signal void changed ();
        public signal void removed ();
        public DebianPackage package { get; construct; }
        public bool can_remove { 
            set {
                remove_button.no_show_all = !value;
                remove_button.visible = value;
            }

            get {
                return remove_button.visible;
            }
        }

        private Gtk.Box main_box;
        private Gtk.Stack stack;
        private Gtk.Grid button_containter;
        private Gtk.Button remove_button;
        private Gtk.Grid label_container;
        private Gtk.Label status_label;

        construct {
            main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
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

            remove_button = new Gtk.Button.from_icon_name ("list-remove-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            remove_button.opacity = 0;
            remove_button.show_all ();
            remove_button.clicked.connect (() => removed ());
            remove_button.enter_notify_event.connect (() => {
                remove_button.opacity = 1;
                return false;
            });

            button_containter = new Gtk.Grid ();
            button_containter.halign = Gtk.Align.CENTER;
            button_containter.valign = Gtk.Align.CENTER;
            button_containter.add (remove_button);

            status_label = new Gtk.Label (_("Unknown"));

            label_container = new Gtk.Grid ();
            label_container.halign = Gtk.Align.CENTER;
            label_container.valign = Gtk.Align.CENTER;            
            label_container.add (status_label);

            stack = new Gtk.Stack ();
            stack.add (button_containter);
            stack.add (label_container);
            stack.visible_child = button_containter;

            main_box.add (package_image);
            main_box.add (vertical_box);
            main_box.pack_end (stack, false, false);

            var event_box = new Gtk.EventBox ();
            event_box.add (main_box);
            event_box.enter_notify_event.connect (() => {
                remove_button.opacity = 1;
                return false;
            });

            event_box.leave_notify_event.connect (() => {
                remove_button.opacity = 0;
                return false;
            });

            draw.connect (on_event_box_draw);
            package.finished.connect (() => update_status_label (true));
            package.notify["install-status"].connect (() => update_status_label (false));
            package.notify["install-progress"].connect (update_progress);
            
            add (event_box);
        }

        public PackageRow (DebianPackage package) {
            Object (package: package);
        }

        private void update_status_label (bool finished) {
            stack.visible_child = label_container;

            unowned string? title;
            if (finished) {
                title = package.get_exit_state_title ();
            } else {
                title = package.get_status_title ();
            }

            bool visible = title != null;

            status_label.visible = visible;
            status_label.no_show_all = !visible;
            status_label.label = title;
        }

        private void update_progress () {
            queue_draw ();
        }

        private bool on_event_box_draw (Gtk.Widget widget, Cairo.Context context) {
            uint install_progress = package.install_progress;
            if (install_progress > 0) {
                int width = get_allocated_width ();
                int height = get_allocated_height ();
                context.set_source_rgba (Constants.BRAND_COLOR.red, Constants.BRAND_COLOR.green, Constants.BRAND_COLOR.blue, 0.7);
                context.rectangle (0, 0, width * install_progress / 100, height);
                context.fill ();
                get_style_context ().set_state (Gtk.StateFlags.NORMAL);
            }

            return base.draw (context);
        }
    }
}