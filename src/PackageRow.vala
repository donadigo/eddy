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
        private const int PROGRESS_BAR_HEIGHT = 5;

        public signal void action_clicked ();
        public signal void reinstall ();
        public signal void removed ();
        // public signal void update_same_packages ();

        public Package package { get; construct; }
        public bool show_action_button {
            set {
                set_widget_visible (action_button, value);
            }
        }

        private Gtk.Box main_box;

        private Gtk.Button action_button;
        private Gtk.Button reinstall_button;

        private Gtk.Button remove_button;
        private Gtk.Label status_label;
        private Gtk.Image state_icon;

        private static Gtk.SizeGroup size_group;
        private static bool updating_same_packages;

        static construct {
            size_group = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
            updating_same_packages = false;
        }

        construct {
            main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
            main_box.margin = 12;

            var package_image = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
            package_image.valign = Gtk.Align.START;

            var summary_label = new Gtk.Label ("<b>%s</b>".printf (package.summary));
            summary_label.wrap = true;
            summary_label.wrap_mode = Pango.WrapMode.WORD_CHAR;
            summary_label.use_markup = true;
            summary_label.halign = Gtk.Align.START;

            var name_label = new Gtk.Label (package.name);
            name_label.wrap = true;
            name_label.wrap_mode = Pango.WrapMode.WORD_CHAR;
            name_label.halign = Gtk.Align.START;

            var vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
            vertical_box.add (summary_label);
            vertical_box.add (name_label);

            status_label = new Gtk.Label (null);
            state_icon = new Gtk.Image ();

            // Action button can be a button for installing or uninstalling
            action_button = new Gtk.Button ();
            action_button.clicked.connect (() => action_clicked ());
            action_button.valign = Gtk.Align.CENTER;
            action_button.halign = Gtk.Align.CENTER;
            size_group.add_widget (action_button);

            // Reinstall button can be a button for downgrading or updating.
            // Since we install local packages there is no difference
            // between those, it is just installing this package again
            // over the old one
            reinstall_button = new Gtk.Button ();
            reinstall_button.clicked.connect (() => reinstall ());
            reinstall_button.valign = Gtk.Align.CENTER;
            reinstall_button.halign = Gtk.Align.CENTER;
            size_group.add_widget (reinstall_button);

            remove_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            remove_button.tooltip_text = _("Remove from list");
            remove_button.valign = Gtk.Align.CENTER;
            remove_button.opacity = 0;
            remove_button.get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            remove_button.show_all ();
            remove_button.clicked.connect (() => removed ());
            remove_button.enter_notify_event.connect (() => {
                remove_button.opacity = 1;
                return false;
            });

            main_box.add (package_image);
            main_box.add (vertical_box);
            main_box.pack_end (status_label, false, false);
            main_box.pack_end (action_button, false, false);
            main_box.pack_end (reinstall_button, false, false);
            main_box.pack_end (state_icon, false, false);
            main_box.pack_end (remove_button, false, false);

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

            package.notify["status"].connect (update_status);
            package.notify["progress"].connect (update_progress);
            package.notify["exit-code"].connect (update_state_icon);
            package.notify["has-task"].connect (update_visibility);
            package.state_updated.connect (update_buttons);

            draw.connect (on_draw);
            update_visibility ();
            update_state_icon ();
            update_status ();
            update_buttons ();
            add (event_box);
        }

        public PackageRow (Package package) {
            Object (package: package);
        }

        private void update_status () {
            status_label.label = package.get_status_title ();
        }

        private void update_visibility () {
            bool running = package.has_task;
            set_widget_visible (remove_button, !running);
            set_widget_visible (action_button, !running);
            set_widget_visible (status_label, running);

            update_buttons ();
        }

        private void update_buttons () {
            if (package.is_installed) {
                action_button.label = _("Uninstall");
                action_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            } else {
                action_button.label = _("Install");
                action_button.get_style_context ().remove_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
            }

            if (package.can_update) {
                reinstall_button.label = _("Update");
                reinstall_button.get_style_context ().remove_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
                reinstall_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                set_widget_visible (reinstall_button, !package.has_task);
            } else if (package.can_downgrade) {
                reinstall_button.label = _("Downgrade");
                reinstall_button.get_style_context ().remove_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                reinstall_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
                set_widget_visible (reinstall_button, !package.has_task);
            } else {
                set_widget_visible (reinstall_button, false);
            }

            changed ();
            // update_same_packages ();
        }

        private void update_state_icon () {
            unowned string exit_state = package.get_exit_title ();
            unowned string? icon = package.get_exit_icon ();

            if (icon != null) {
                state_icon.set_from_icon_name (icon, Gtk.IconSize.SMALL_TOOLBAR);
                set_widget_visible (state_icon, true);
            } else {
                set_widget_visible (state_icon, false);
            }

            state_icon.tooltip_text = exit_state;
        }

        private void update_progress () {
            queue_draw ();

            // Unfortunately, animating the progress bar like this
            // makes it show false progress when it's size changes
            //
            // uint from = progress_bar.get_allocated_width ();
            // uint to = this.get_allocated_width () * progress / 100;
            // uint i = from;
            // Timeout.add (1, () => {
            //     progress_bar.set_size_request ((int)i, PROGRESS_BAR_HEIGHT);

            //     if (to > from) {
            //         i++;
            //         return i <= to;
            //     } else {
            //         i--;
            //         return i >= to;
            //     }
            // }); 
        }

        private bool on_draw (Cairo.Context context) {
            uint progress = package.progress;
            if (progress > 0) {
                int width = get_allocated_width ();
                int height = get_allocated_height ();
                context.set_source_rgba (Constants.BRAND_COLOR.red, Constants.BRAND_COLOR.green, Constants.BRAND_COLOR.blue, 0.7);
                context.rectangle (0, height - PROGRESS_BAR_HEIGHT, width * progress / 100, PROGRESS_BAR_HEIGHT);
                context.fill ();

                get_style_context ().set_state (Gtk.StateFlags.NORMAL);
            }

            return false;
        }
    }
}