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
    [DBus (name = "org.debian.apt")]
    public interface AptService : Object {
        public abstract async string install_packages (string[] packages) throws IOError;
        public abstract async string remove_packages (string[] packages) throws IOError;
        public abstract async string install_file (string path, bool force) throws IOError;
        public abstract async void fix_broken_depends () throws IOError;
        public abstract async void fix_incomplete_install () throws IOError;
    }

    public class TransactionError {
        public string codename;
        public string description;

        public TransactionError (string codename, string description) {
            this.codename = codename;
            this.description = description;
        }

        public string get_text () {
            int idx = description.last_index_of_char ('\n');
            if (idx != -1) {
                return description.slice (0, idx);
            }

            return description;
        }
    }

    public class TransactionResult {
        public DebianPackage package;
        public bool action_is_install;
        public TransactionError? error;

        public TransactionResult (DebianPackage package, TransactionError? error) {
            this.package = package;
            this.error = error;
        }
    }

    [DBus (name = "org.debian.apt.transaction")]
    public interface AptTransaction : Object {
        public abstract bool cancellable { owned get; }
        public abstract bool paused { owned get; }
        public abstract bool allow_unauthenticated { get; set; }
        public abstract int32 progress { owned get; }
        public abstract string status { owned get; }
        public abstract string exit_state { owned get; }

        public abstract async void cancel () throws IOError;
        public abstract async void run () throws IOError;
        public abstract async void run_after (string tid) throws IOError;
        public abstract async void simulate () throws IOError;

        public signal void finished (string status);
        public signal void property_changed (string key, Variant val);
    }

    public class AptProxy : Object {
        public const string APTD_DBUS_NAME = "org.debian.apt";
        private const string APTD_DBUS_PATH = "/org/debian/apt";

        private static AptService? service;
        public static unowned AptService? get_service () {
            if (service == null) {
                try {
                    service = Bus.get_proxy_sync (BusType.SYSTEM, APTD_DBUS_NAME, APTD_DBUS_PATH);
                } catch (IOError e) {
                    warning (e.message);
                }
            }

            return service;
        }

        public static AptTransaction? get_transaction (string transaction_path) {
            try {
                return Bus.get_proxy_sync (BusType.SYSTEM, APTD_DBUS_NAME, transaction_path);
            } catch (IOError e) {
                warning (e.message);
                return null;
            }
        }
    }
}