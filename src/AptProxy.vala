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
    [DBus (name = "org.debian.apt")]
    public interface AptService : Object {
        public abstract async string install_packages (string[] packages) throws IOError;
        public abstract async string install_file (string path, bool force) throws IOError;
        public abstract async void fix_broken_depends () throws IOError;
        public abstract async void fix_incomplete_install () throws IOError;
    }

    [DBus (name = "org.debian.apt.transaction")]
    public interface AptTransaction : Object {
        public abstract bool paused { owned get; }
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
        private const string APTD_DBUS_NAME = "org.debian.apt";
        private const string APTD_DBUS_PATH = "/org/debian/apt";

        private static AptService? service;
        public static unowned AptService? get_service () {
            if (service == null) {
                service = Bus.get_proxy_sync (BusType.SYSTEM, APTD_DBUS_NAME, APTD_DBUS_PATH);
            }

            return service;
        }

        public static AptTransaction? get_transaction (string transaction_path) {
            return Bus.get_proxy_sync (BusType.SYSTEM, APTD_DBUS_NAME, transaction_path);
        }
    }
}