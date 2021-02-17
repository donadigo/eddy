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

public class Eddy.DetailedView : Gtk.Box {
    private Package? current_package;

    private Gtk.Label name_label;
    private Gtk.Label version_label;
    private Gtk.Label description_label;
    private Gtk.Label date_installed_label;
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

        date_installed_label = new Gtk.Label (_("Unknown"));
        date_installed_label.halign = Gtk.Align.START;
        set_widget_visible (date_installed_label, false);

        homepage_button = new Gtk.LinkButton.with_label ("", _("Homepage"));
        homepage_button.no_show_all = true;

        var header_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
        header_box.add (name_label);
        header_box.pack_end (homepage_button, false, false);

        add (header_box);
        add (version_label);
        add (date_installed_label);
        add (description_label);
    }

    public void set_package (Package package) {
        current_package = package;

        name_label.set_markup ("<span size='xx-large'><b>%s</b></span>".printf (package.name));

        //  TRANSLATORS:
        //  this string is formatted as: "version: `package-version` • `package-installed-size`"
        version_label.set_markup ("<span size='x-large'>" + _("version %s • %s").printf (package.version, format_size (package.installed_size)) + "</span>");

        if (package.installed_timestamp != -1) {
            var date = new DateTime.from_unix_local (package.installed_timestamp);
            if (date != null) {
                string formatted = date.format ("%F");
                date_installed_label.set_markup (_("<b>Previously installed on %s</b>").printf (formatted));
                set_widget_visible (date_installed_label, true);
            } else {
                set_widget_visible (date_installed_label, false);
            }
        } else {
            set_widget_visible (date_installed_label, false);
        }

        homepage_button.uri = package.homepage;
        description_label.label = package.description.strip ();

        homepage_button.visible = package.homepage.strip () != "";
    }

    public Package? get_package () {
        return current_package;
    }
}
