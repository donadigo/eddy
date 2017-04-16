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
    public class App : Granite.Application {
        construct {
            application_id = "com.github.donadigo.eddy";
            program_name = Constants.APP_NAME;
            app_years = "2015-2017";
            exec_name = Constants.EXEC_NAME;
            app_launcher = Constants.DESKTOP_NAME;

            build_version = Constants.VERSION;
            app_icon = "com.github.donadigo.eddy";
            main_url = "https://github.com/donadigo/eddy";
            bug_url = "https://github.com/donadigo/eddy/issues";
            help_url = "https://github.com/donadigo/eddy";
            translate_url = "https://github.com/donadigo/eddy";
            about_authors = {"Adam Bieńkowski <donadigos159gmail.com>", null};
            about_translators = _("translator-credits");
    
            about_license_type = Gtk.License.GPL_3_0;
        }

        public static int main (string[] args) {
            var app = new App ();
            return app.run (args);
        }

        public override void activate () {
            try {
                check_environment ();
            } catch (IOError e) {
                var dialog = new MessageDialog (_("Failed To Initialize"), e.message, "dialog-error");
                dialog.add_button (_("Close"), 0);
                dialog.show_all ();
                dialog.run ();
                dialog.destroy ();
                return;
            }

            var window = new EddyWindow ();
            add_window (window);
            window.show_all ();
        }

        private static void check_environment () throws IOError {
            if (Environment.find_program_in_path (Constants.DPKG_DEB_BINARY) == null) {
                throw new IOError.NOT_FOUND (_("Could not find dpkg-deb: dpkg may not be installed on the system").printf (Constants.DPKG_DEB_BINARY));
            } else if (AptProxy.get_service () == null) {
                throw new IOError.DBUS_ERROR (_("Could not connect to %s DBus service: apt may not be installed on the system").printf (AptProxy.APTD_DBUS_NAME));
            }
        }
    }
}