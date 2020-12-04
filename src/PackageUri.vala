/*-
 * Copyright (c) 2020 Adam Bieńkowski
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

public class Eddy.PackageUri {
    public string uri;
    public int64 installed_timestamp = -1;

    public PackageUri (string uri, int64 timestamp) {
        this.uri = uri;
        this.installed_timestamp = timestamp;
    }
}

namespace Eddy {
    public static uint package_uri_hash_func (PackageUri puri) {
        return str_hash (puri.uri);
    }

    public static bool package_uri_equal_func (PackageUri puri1, PackageUri puri2) {
        return str_equal (puri1.uri, puri2.uri);
    }
}