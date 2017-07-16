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

public class Eddy.DetailedView : Gtk.Box {
    private Package? current_package;

    private Gtk.Label name_label;
    private Gtk.Label version_label;
    private Gtk.Label description_label;
    private Gtk.LinkButton homepage_button;

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        margin = 40;

        name_label = new Gtk.Label (_("Unknown"));

        version_label = new Gtk.Label (_("Unknown"));
        version_label.halign = Gtk.Align.START;

        description_label = new Gtk.Label (_("Unknown"));
        description_label.wrap_mode = Pango.WrapMode.WORD;
        description_label.wrap = true;
        description_label.selectable = true;
        description_label.halign = Gtk.Align.START;
        description_label.margin_top = 16;

        homepage_button = new Gtk.LinkButton.with_label ("", _("Homepage"));
        homepage_button.no_show_all = true;

        var header_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        header_box.add (name_label);
        header_box.pack_end (homepage_button, false, false);

        add (header_box);
        add (version_label);
        add (description_label);
    }

    public void set_package (Package package) {
        current_package = package;

        name_label.set_markup ("<span size='xx-large'><b>%s</b></span>".printf (package.name));
        version_label.set_markup (_("<span size='x-large'>version %s • %s</span>").printf (package.version, format_size (package.installed_size)));
        homepage_button.uri = package.homepage;
        description_label.label = package.description.strip ();

        homepage_button.visible = package.homepage.strip () != "";
    }

    public Package? get_package () {
        return current_package;
    }
}
