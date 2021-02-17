/*-
 * Copyright 2021 Adam Bieńkowski <donadigos159@gmail.com>
 *
 * This program is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see http://www.gnu.org/licenses/.
 */

public class Eddy.MessageDialog : Gtk.Dialog {
    public string primary_text { get; construct set; }
    public string secondary_text { get; construct set; }
    public string image_icon_name { get; construct set; }

    public MessageDialog (string primary_text, string secondary_text, string image_icon_name) {
        Object (resizable: false, deletable: false, skip_taskbar_hint: true, primary_text: primary_text, secondary_text: secondary_text, image_icon_name: image_icon_name);
    }

    construct {
        var image = new Gtk.Image.from_icon_name (image_icon_name, Gtk.IconSize.DIALOG);
        image.valign = Gtk.Align.START;

        var primary_label = new Gtk.Label (primary_text);
        primary_label.get_style_context ().add_class ("primary");
        primary_label.max_width_chars = 50;
        primary_label.wrap = true;
        primary_label.xalign = 0;

        var secondary_label = new Gtk.Label (secondary_text);
        secondary_label.use_markup = true;
        secondary_label.selectable = true;
        secondary_label.max_width_chars = 50;
        secondary_label.wrap = true;
        secondary_label.xalign = 0;

        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;
        grid.row_spacing = 6;
        grid.margin_left = grid.margin_right = 12;
        grid.attach (image, 0, 0, 1, 2);
        grid.attach (primary_label, 1, 0, 1, 1);
        grid.attach (secondary_label, 1, 1, 1, 1);

        get_content_area ().add (grid);

        var action_area = get_action_area ();
        action_area.margin_right = 6;
        action_area.margin_bottom = 6;
        action_area.margin_top = 14;
    }
}