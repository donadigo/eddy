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

public class Eddy.MimeTypeHelper : Object {
    private const string MIME_TYPES_DB_FILE = "/etc/mime.types";
    private string db_contents = "";

    private static MimeTypeHelper? instance;
    public static unowned MimeTypeHelper get_default () {
        if (instance == null) {
            instance = new MimeTypeHelper ();
        }

        return instance;
    }

    construct {
        try {
            FileUtils.get_contents (MIME_TYPES_DB_FILE, out db_contents);
        } catch (Error e) {
            warning (e.message);
        }
    }

    private MimeTypeHelper () {

    }

    public string[] get_extensions_for_mime_type (string mime_type) {
        foreach (string line in db_contents.split ("\n")) {
            if (line.has_prefix ("#")) {
                continue;
            }

            string[] tokens = line.split ("\t");
            if (tokens.length <= 1 || tokens[0] != mime_type) {
                continue;
            }

            string[] extensions = {};
            for (int i = 1; i < tokens.length; i++) {
                string token = tokens[i];
                if (token.strip () == "") {
                    continue;
                }

                foreach (string extension in token.split (" ")) {
                    extensions += extension;
                }
            }

            return extensions;
        }

        return {};
    }

    public string resolve_extension_for_mime_types (string[] mime_types) {
        string[] extensions = {};
        foreach (string mime_type in mime_types) {
            foreach (string extension in get_extensions_for_mime_type (mime_type)) {
                extensions += extension;
            }
        }

        if (extensions.length > 0) {
            return extensions[0];
        }

        debug ("No extensions found. Using default %s extension", Constants.DEFAULT_EXTENSION);
        return Constants.DEFAULT_EXTENSION;
    }
}
