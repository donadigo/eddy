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
    public class DebianPackage : Object {
        public signal void finished ();

        public string filename { public get; construct; }
        public string name { public get; private set; }
        public string summary { public get; private set; }
        public string version { public get; private set; }
        public uint installed_size { public get; private set; }
        public string homepage { public get; private set; }
        public string description { public get; private set; }

        public bool valid { public get; private set; default = true; }

        public string status { public get; private set; }
        public string exit_state { public get; private set; }
        public uint progress { public get; private set; default = 0; }

        public bool transaction_cancellable { public get; private set; default = true; }
        public bool has_transaction { public get; private set; default = false; }

        public bool is_installed { public get; private set; default = false; }

        private Cancellable? cancellable = null;
        private TransactionError? error = null;     

        construct {
            finished.connect (reset);
        }

        public DebianPackage (string filename) {
            Object (filename: filename);
        }

        public bool equal (DebianPackage package) {
            return package.filename == filename;
        }

        public async TransactionResult install () {
            var transaction = yield prepare_install_transaction ();
            if (transaction == null) {
                error = new TransactionError ("no-transaction", _("could not create a transaction"));
                var result = new TransactionResult (this, error);
                exit_state = "exit-failed";
                finished ();
                return result;
            }

            var result = yield run_transaction (transaction);
            result.action_is_install = true;
            return result;
        }

        public async TransactionResult uninstall () {
            var transaction = yield prepare_uninstall_transaction ();
            if (transaction == null) {
                error = new TransactionError ("no-transaction", _("could not create a transaction"));
                var result = new TransactionResult (this, error);
                exit_state = "exit-failed";
                finished ();
                return result;
            }

            var result = yield run_transaction (transaction);
            result.action_is_install = false;
            return result;            
        }

        private async TransactionResult run_transaction (AptTransaction transaction) {
            if (has_transaction) {
                error = new TransactionError ("has-transaction", _("package already has a transaction running"));
                var result = new TransactionResult (this, error);
                exit_state = "exit-failed";
                finished ();
                return result;
            }

            has_transaction = true;

            transaction_cancellable = transaction.cancellable;

            ulong property_changed_id = transaction.property_changed.connect (handle_property_change);

            ulong finished_id = 0;
            finished_id = transaction.finished.connect (() => {
                if (property_changed_id != 0) {
                    transaction.disconnect (property_changed_id);
                }

                if (finished_id != 0) {
                    transaction.disconnect (finished_id);
                    Idle.add (run_transaction.callback);
                }
            });

            cancellable = new Cancellable ();
            cancellable.cancelled.connect (() => transaction.cancel.begin ());

            transaction.run.begin ();

            yield;

            var result = new TransactionResult (this, error);
            yield update_installed_state ();
            finished ();
            return result;
        }

        public void cancel () {
            if (cancellable != null) {
                cancellable.cancel ();
            }
        }

        private async AptTransaction? prepare_install_transaction () {
            try {
                var service = AptProxy.get_service ();
                if (service == null) {
                    return null;
                }

                string tid = yield service.install_file (filename, false);
                return AptProxy.get_transaction (tid);
            } catch (IOError e) {
                warning (e.message);
            }

            return null;
        }

        private async AptTransaction? prepare_uninstall_transaction () {
            try {
                var service = AptProxy.get_service ();
                if (service == null) {
                    return null;
                }

                string tid = yield service.remove_packages ({ name });
                return AptProxy.get_transaction (tid);
            } catch (IOError e) {
                warning (e.message);
            }

            return null;            
        }

        public async void populate_data () {
            string[] argv = { Constants.DPKG_DEB_BINARY, "--showformat=${Package}\\n${Version}\\n${Installed-Size}\\n${Homepage}\\n${Description}", "-W", filename, null };

            try {
                var subprocess = new Subprocess.newv (argv, SubprocessFlags.STDOUT_PIPE);
                string output;
                valid = yield subprocess.communicate_utf8_async (null, null, out output, null);
                if (!valid) {
                    return;
                }

                string[] tokens = output.split ("\n", 5);
                if (tokens.length < 5) {
                    valid = false;
                    return;
                }

                name = tokens[0];
                version = tokens[1];
                installed_size = 1024 * int.parse (tokens[2]);
                homepage = tokens[3];

                yield update_installed_state ();

                int i = 0;
                string desc = tokens[4];

                string buffer = "";
                string[] lines = desc.split ("\n");
                for (i = 0; i < lines.length; i++) {
                    string line = lines[i];
                    if (i == 0) {
                        summary = line;
                        continue;
                    }

                    if (line == " .") {
                        if (buffer.length > 0) {
                            buffer += line.substring (0, line.length - 1);
                        }
                    
                        buffer += "\n";
                        continue;
                    }

                    buffer += line.strip () + " ";
                }

                if (buffer.length > 0) {
                    description = buffer;
                } else {
                    description = _("Description not available.");    
                }
            } catch (Error e) {
                warning (e.message);
                valid = false;
            }            
        }

        private async void update_installed_state () {
            var task = new Pk.Task ();

            uint installed = 0;
            try {
                var results = yield task.resolve_async (Pk.Filter.INSTALLED, { name }, null, () => {});

                
                results.get_package_array ().@foreach ((package) => {
                    if (package.get_info () == Pk.Info.INSTALLED) {
                        installed++;
                    }
                });
            } catch (Error e) {
                warning (e.message);
            }

            is_installed = installed >= 1;
        }

        public unowned string? get_status_title () {
            switch (status) {
                case "status-setting-up":
                    return _("Setting up");
                case "status-query":
                    return _("Querying");
                case "status-waiting":
                    return _("Waiting");
                case "status-waiting-medium":
                    return _("Waiting for medium");
                case "status-waiting-config-file-prompt":
                    return _("Waiting for file configuration");
                case "status-waiting-lock":
                    return _("Waiting for package manager lock");
                case "status-running":
                    return _("Running");
                case "status-loading-cache":
                    return _("Loading cache");
                case "status-downloading-repo":
                    return _("Downloading information about available packages");
                case "status-downloading":
                    return _("Downloading files");
                case "status-committing":
                    return _("Commiting changes");
                case "status-cleaning-up":
                    return _("Cleaning up");
                case "status-resolving-dep":
                    return _("Resolving conflicts");
                case "status-finished":
                    return _("Finished");
                case "status-cancelling":
                    return _("Cancelling");
                case "status-authenticating":
                    return _("Waiting for authentication");
            }

            return _("Unknown");
        }

        public unowned string? get_exit_state_icon () {
            switch (exit_state) {
                case "exit-success":
                    return "process-completed-symbolic";
                case "exit-failed":
                case "exit-previous-failed":
                case "exit-unfinished":
                    return "dialog-error-symbolic";
            }

            return null;
        }

        public unowned string get_exit_state_title () {
            switch (exit_state) {
                case "exit-success":
                    return _("Finished");
                case "exit-cancelled":
                    return _("Cancelled");
                case "exit-failed":
                    return _("Failed");
                case "exit-previous-failed":
                    return _("Previous failed");
                case "exit-unfinished":
                    return _("Unfinished");
            }

            return _("Unknown");
        }

        private void reset () {
            progress = 0;
            transaction_cancellable = true;
            has_transaction = false;
            error = null;
            cancellable = null;
        }

        private void handle_property_change (string key, Variant val) {
            switch (key) {
                case "Status":
                    if (!val.is_of_type (VariantType.STRING)) {
                        break;
                    }

                    status = val.get_string ();
                    break;
                case "ExitState":
                    if (!val.is_of_type (VariantType.STRING)) {
                        break;
                    }

                    exit_state = val.get_string ();
                    break;
                case "Progress":
                    if (!val.is_of_type (VariantType.INT32)) {
                        break;
                    }

                    progress = val.get_int32 ();
                    break;
                case "Error":
                    if (!val.is_of_type (VariantType.TUPLE) || val.n_children () < 2) {
                        break;
                    }                    

                    var codename = val.get_child_value (0);
                    var description = val.get_child_value (1);

                    if (!codename.is_of_type (VariantType.STRING) || !description.is_of_type (VariantType.STRING)) {
                        break;
                    }

                    error = new TransactionError (codename.get_string (), description.get_string ());
                    break;
                case "Cancellable":
                    if (!val.is_of_type (VariantType.BOOLEAN)) {
                        break;
                    }

                    transaction_cancellable = val.get_boolean ();
                    break;
            }
        }
    }
}