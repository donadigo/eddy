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
        public static string[] supported_mimetypes = Constants.DEFAULT_SUPPORTED_MIMETYPES;
        private Pk.Control control;
        public bool initted { get; set; default = false; }

        private EddyWindow? window = null;

        construct {
            flags |= ApplicationFlags.HANDLES_OPEN;

            application_id = "com.github.donadigo.eddy";
            program_name = Constants.APP_NAME;
            app_years = "2016-2017";
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

            control = new Pk.Control ();
            control.get_properties_async.begin (null, (obj, res) => {
                try {
                    bool success = control.get_properties_async.end (res);
                    if (success) {
                        string[] mimes = strdupv (control.mime_types);
                        if (mimes.length > 0) {
                            supported_mimetypes = mimes;
                        }
                    }
                } catch (Error e) {
                    warning (e.message);
                }

                initted = true;
            });
        }

        public static int main (string[] args) {
            var app = new App ();
            return app.run (args);
        }

        public override void open (File[] files, string hint) {
            string[] uris = {};
            foreach (var file in files) {
                uris += file.get_uri ();
            }

            activate ();
            if (window != null) {
                window.open_uris.begin (uris);
            }
        }

        public override void activate () {
            if (window == null) {
                if (initted) {
                    // Already initted, show the window
                    init_window ();
                } else {
                    // Wait for Pk.Control to get all properties
                    var loop = new MainLoop ();

                    ulong signal_id = 0;
                    signal_id = notify["initted"].connect (() => {
                        init_window ();
                        disconnect (signal_id);
                        loop.quit ();
                    });

                    loop.run ();
                }
            } else {
                window.present ();
            }
        }

        private void init_window () {
            window = new EddyWindow ();
            add_window (window);
            window.show_all ();            
        }
    }
}