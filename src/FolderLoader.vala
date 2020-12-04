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

public class Eddy.FolderLoader : Object {
    public string path { get; construct; }
    public uint uris_loaded { get; private set; default = 0; }

    private const uint MAX_LOAD_ITERATION = 100;

    public FolderLoader (string path) {
        Object (path: path);
    }

    public async PackageUri[] load () {
        return yield load_internal (path, 0);
    }

    private async PackageUri[] load_internal (string path, int iteration) {
        if (iteration == MAX_LOAD_ITERATION) {
            return {};
        }

        var file = File.new_for_path (path);
        var log_manager = LogManager.get_default ();

        PackageUri[] puris = {};
        try {
            var enumerator = yield file.enumerate_children_async ("%s,%s".printf (FileAttribute.STANDARD_NAME, FileAttribute.STANDARD_CONTENT_TYPE), FileQueryInfoFlags.NOFOLLOW_SYMLINKS);

            FileInfo? info = null;
            while ((info = enumerator.next_file (null)) != null) {
                if (info.get_file_type () == FileType.DIRECTORY) {
                    var subdir = file.resolve_relative_path (info.get_name ());
                    PackageUri[] suburis = yield load_internal (subdir.get_path (), iteration + 1);
                    foreach (PackageUri uri in suburis) {
                        puris += uri;
                        uris_loaded++;
                    }
                } else if (info.get_content_type () in Application.supported_mimetypes) {
                    try {
                        var subfile = file.resolve_relative_path (info.get_name ());
                        string? uri = Filename.to_uri (subfile.get_path (), null);
                        if (uri != null) {
                            var puri = new PackageUri (uri, -1);
                            log_manager.fill_out_external_uri (puri);

                            puris += puri;
                            uris_loaded++;
                        }
                    } catch (ConvertError e) {
                        warning (e.message);
                    }
                }
            }
        } catch (Error e) {
            warning (e.message);
        }

        return puris;
    }
}