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
        private File file;

        public string name;
        public string version;
        public uint installed_size;
        public string homepage;
        public string description;

        public bool valid = true;

        public DebianPackage (File _file) {
            file = _file;

            string[] argv = { Constants.DPKG_DEB_BINARY, "--showformat=${Package}\\n${Version}\\n${Installed-Size}\\n${Homepage}\\n${Description}", "-W", get_file_path () };

            try {
                string output;
                int exit_status;
                bool success = Process.spawn_sync (null,
                                    argv,
                                    null,
                                    SpawnFlags.STDERR_TO_DEV_NULL,
                                    null,
                                    out output,
                                    null,
                                    out exit_status);

                valid = success && exit_status == 0;
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
                description = tokens[4];
            } catch (Error e) {
                warning ("%s\n", e.message);
                valid = false;
            }
        }

        public string get_file_path () {
            return file.get_path ();
        }
    }
}