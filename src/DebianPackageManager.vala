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
    public class DebianPackageManager : Object {
        private const string PK_ACTION_INSTALL_FILE = "org.debian.apt.install-file";
        private const string PK_ACTION_MANAGE_PACKAGES = "org.debian.apt.install-or-remove-packages";
        private Queue<DebianPackage> queue;

        private DebianPackage? first = null;

        construct {
            queue = new Queue<DebianPackage> ();
        }

        public void add_package (DebianPackage package) {
            queue.push_head (package);
        }

        public void remove_package (DebianPackage package) {
            if (queue.index (package) != -1) {
                queue.remove (package);
            }
        }

        // public async Gee.ArrayList<TransactionResult> install () {
        //     var results = new Gee.ArrayList<TransactionResult> ();

        //     first = queue.peek_nth (0);
        //     first.notify["status"].connect (status_changed);
        //     first.install.begin ();

        //     yield;
        //     return results;
        // }

        // private void status_changed () {
        //     if (first.status != Pk.Status.CANCEL && first.status != Pk.Status.RUNNING) {
        //         return;
        //     }

        //     first.notify["status"].disconnect (status_changed);

        //     for (int i = 1; i < queue.get_length (); i++) {
        //         var package = queue.peek_nth (i);
        //         package.install.begin ();
        //     }            
        // }

        public async static TransactionResult perform_default_action (DebianPackage package, Cancellable? cancellable) {
            if (package.is_installed) {
                var result = yield package.uninstall (cancellable);
                return result;
            } else {
                var result = yield package.install (cancellable);
                return result;
            }
        }

        private async static bool preauthenticate (string action) {
            try {
                var bus = yield Bus.@get (BusType.SYSTEM);
                unowned string? unique_name = bus.get_unique_name ();
                if (unique_name == null) {
                    return true;
                }
            
                var subject = new Polkit.SystemBusName (unique_name);
                var authority = yield Polkit.Authority.get_async ();
                var result = yield authority.check_authorization (subject, action, null, Polkit.CheckAuthorizationFlags.ALLOW_USER_INTERACTION);
                return result.get_is_authorized ();
            } catch (Error e) {
                warning (e.message);
            }

            return true;
        }
    }
}