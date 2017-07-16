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


public class Eddy.TransactionResult : Object {
    public Gee.ArrayList<Package> packages { get; construct; }
    public Pk.Role role { get; construct; }
    public Error? error { get; set; default = null; }
    public bool cancelled { get; set; default = false; }

    construct {
        packages = new Gee.ArrayList<Package> ();
    }

    public TransactionResult (Pk.Role role) {
        Object (role: role);
    }

    public void add_package (Package package) {
        packages.add (package);
    }

    public bool is_empty () {
        return packages.size < 1;
    }
}
