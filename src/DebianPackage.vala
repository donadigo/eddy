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
    public class DebianPackage : Object {
        public signal void finished (string state);

        public string filename { public get; construct; }
        public string name { public get; private set; }
        public string summary { public get; private set; }
        public string version { public get; private set; }
        public uint installed_size { public get; private set; }
        public string homepage { public get; private set; }
        public string description { public get; private set; }

        public bool valid { public get; private set; default = true; }

        public DebianPackage (string filename) {
            Object (filename: filename);
        }

        public bool equal (DebianPackage package) {
            return package.filename == filename;
        }

        public async string? prepare_transaction () {
            try {
                var service = AptProxy.get_service ();
                if (service == null) {
                    return null;
                }

                string transaction_path = yield service.install_file (filename, true);
                return transaction_path;
            } catch (IOError e) {
                warning (e.message);
            }

            return null;
        }

        public async void install (AptTransaction transaction, string? next_tid) {
            transaction.property_changed.connect (handle_property_change);
            transaction.finished.connect ((state) => {
                Idle.add (install.callback);
            });

            if (next_tid != null) {
                transaction.run_after (next_tid);
            } else {
                transaction.run ();   
            }

            yield;
        }

        public async void populate_data () {
            string[] argv = { Constants.DPKG_DEB_BINARY, "--showformat=${Package}\\n${Version}\\n${Installed-Size}\\n${Homepage}\\n${Description}", "-W", filename };

            try {
                var subprocess = new Subprocess.newv (argv, SubprocessFlags.STDOUT_PIPE);
                string output;
                valid = yield subprocess.communicate_utf8_async (null, null, out output, null);
                if (!valid) {
                    return;
                }

                string[] tokens = output.split ("\n", 5);
                if (tokens.length < 5) {
                    valid = false;
                    return;
                }

                name = tokens[0];
                version = tokens[1];
                installed_size = 1024 * int.parse (tokens[2]);
                homepage = tokens[3];
                
                int i = 0;
                string desc = tokens[4];

                string buffer = "";
                string[] lines = desc.split ("\n");
                for (i = 0; i < lines.length; i++) {
                    string line = lines[i];
                    if (i == 0) {
                        summary = line;
                        continue;
                    }

                    if (line == " .") {
                        if (buffer.length > 0) {
                            buffer += line.substring (0, line.length - 1);
                        }
                    
                        buffer += "\n";
                        continue;
                    }

                    buffer += line.strip () + " ";
                }

                if (buffer.length > 0) {
                    description = buffer;
                } else {
                    description = _("Description not available.");    
                }
            } catch (Error e) {
                warning ("%s\n", e.message);
                valid = false;
            }            
        }

        private void handle_property_change (string key, Variant val) {
            switch (key) {
                case "Status":
                    break;
                case "Progress":
                    break;
            }
        }
    }
}