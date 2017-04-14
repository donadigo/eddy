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
        private static App? instance = null;

        construct {
            application_id = "net.launchpad.eddy";
            program_name = Constants.APP_NAME;
            app_years = "2015-2017";
            exec_name = Constants.EXEC_NAME;
            app_launcher = Constants.DESKTOP_NAME;

            build_version = Constants.VERSION;
            app_icon = "eddy";
            main_url = "https://github.com/donadigo/eddy";
            bug_url = "https://github.com/donadigo/eddy/issues";
            help_url = "https://github.com/donadigo/eddy";
            translate_url = "https://github.com/donadigo/eddy";
            about_authors = {"Adam Bieńkowski <donadigos159gmail.com>", null};
            about_translators = _("translator-credits");
    
            about_license_type = Gtk.License.GPL_3_0;
        }

        public static App get_default () {
            if (instance == null) {
                instance = new App ();
            }

            return instance;
        }

        public static int main (string[] args) {
            Gtk.init (ref args);
            return App.get_default ().run (args);
        }

        public override void activate () {
            if (!FileUtils.test (Constants.DPKG_DEB_BINARY, FileTest.IS_EXECUTABLE)) {
                show_dependencies_error ();
            } else if (AptProxy.get_service () == null) {
                show_apt_service_error ();
            } else {
                var window = new EddyWindow ();
                add_window (window);
                window.show_all ();
            }

            Gtk.main ();
        }

        private void show_dependencies_error () {

        }

        private void show_apt_service_error () {

        }
    }
}