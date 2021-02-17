/*-
 * Copyright 2021 Adam Bieńkowski <donadigos159@gmail.com>
 *
 * This program is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see http://www.gnu.org/licenses/.
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
