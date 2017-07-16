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
    
    public FolderLoader (string path) {
        Object (path: path);
    }

    public async string[] load () {
        return yield load_internal (path);
    }

    private async string[] load_internal (string path) {
        var file = File.new_for_path (path);

        string[] uris = {};
        try {
            var enumerator = yield file.enumerate_children_async ("%s,%s".printf (FileAttribute.STANDARD_NAME, FileAttribute.STANDARD_CONTENT_TYPE), FileQueryInfoFlags.NOFOLLOW_SYMLINKS);

            FileInfo? info = null;
            while ((info = enumerator.next_file (null)) != null) {
                if (info.get_file_type () == FileType.DIRECTORY) {
                    var subdir = file.resolve_relative_path (info.get_name ());
                    string[] suburis = yield load_internal (subdir.get_path ());
                    foreach (string uri in suburis) {
                        uris += uri;
                        uris_loaded++;
                    }
                } else if (info.get_content_type () in Application.supported_mimetypes) {
                    try {
                        var subfile = file.resolve_relative_path (info.get_name ());
                        string? uri = Filename.to_uri (subfile.get_path (), null);
                        if (uri != null) {
                            uris += uri;
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

        return uris;
    }
}