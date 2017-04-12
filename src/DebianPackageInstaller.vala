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
    public class DebianPackageInstaller : Object {
        private const string PK_ACTION_INSTALL_FILE = "org.debian.apt.install-file";

        public static async Gee.ArrayList<TransactionResult> install_packages (Gee.ArrayList<DebianPackage> packages) {
            var results = new Gee.ArrayList<TransactionResult> ();     

            bool success = yield preauthenticate ();
            if (!success) {
                return results;
            }

            foreach (var package in packages) {
                var result = yield package.install ();
                results.add (result);
            }

            return results;
        }

        private async static bool preauthenticate () {
            var bus = yield Bus.@get (BusType.SYSTEM);
            unowned string unique_name = bus.get_unique_name ();
            if (unique_name == null) {
                return true;
            }

            try {
                var subject = new Polkit.SystemBusName (unique_name);
                var authority = yield Polkit.Authority.get_async ();
                var result = yield authority.check_authorization (subject, PK_ACTION_INSTALL_FILE, null, Polkit.CheckAuthorizationFlags.ALLOW_USER_INTERACTION);
                return result.get_is_authorized ();
            } catch (Error e) {
                warning (e.message);
            }

            return true;
        }
    }
}