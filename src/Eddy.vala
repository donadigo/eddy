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
    public class App : Granite.Application {
        private static App? instance = null;

        construct {
            application_id = "net.launchpad.eddy";
            program_name = Constants.APP_NAME;
            app_years = "2015-2016";
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
            if (check_dependencies ()) {
                var window = new EddyWindow ();
                window.show_all ();                
            } else {
                show_dependencies_error ();
            }

            Gtk.main ();
        }

        private void show_dependencies_error () {

        }

        private bool check_dependencies () {
            return FileUtils.test (Constants.DPKG_DEB_BINARY, FileTest.IS_EXECUTABLE);
        }
    }
}