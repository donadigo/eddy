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
        public static uint task_count { public get; private set; default = 0; }
        private static Pk.Task client;

        public string filename { public get; construct; }
        public string name { 
            get {
                return target.get_name ();
            }
        }

        public string summary { 
            get {
                return target.summary;
            }
        }

        public string version { 
            get {
                return target.get_version ();
            }
        }

        public uint64 installed_size { 
            get {
                return target.size;
            }
        }

        public string homepage { 
            owned get {
                return target.url;
            }
        }

        public string description {
            owned get {
                return target.description;
            }
        }

        public Pk.Status status { public get; private set; }
        public Pk.Exit exit_code { get; set; default = Pk.Exit.UNKNOWN; }
        public uint progress { get; set; default = 0; }

        public bool can_cancel { public get; private set; default = false; }
        public bool has_task { get; set; default = false; }

        public bool is_installed { public get; private set; default = false; }

        private Cancellable? cancellable = null;  

        private Pk.Package? target = null;

        static construct {
            client = new Pk.Task ();
            client.interactive = false;
            client.allow_reinstall = true;
        }

        public async static TransactionResult install_packages (Gee.ArrayList<DebianPackage> packages, Cancellable? cancellable, Pk.ProgressCallback callback) {
            string[] filenames = {};
            Pk.Exit exit_code = Pk.Exit.UNKNOWN;

            var result = new TransactionResult (Pk.Role.INSTALL_FILES);
            foreach (var package in packages) {
                package.has_task = true;
                package.exit_code = Pk.Exit.UNKNOWN;

                filenames += package.filename;
                result.add_package (package);
            }

            filenames += null;

            try {
                var results = yield client.install_files_async (filenames, cancellable, (progress, type) => {
                    switch (type) {
                        case Pk.ProgressType.ITEM_PROGRESS:
                            var item_progress = progress.item_progress;
                            string id = item_progress.package_id;
                            string name = Pk.Package.id_split (id)[0];
                            foreach (var package in packages) {
                                if (package.name != name) {
                                    continue;
                                }

                                package.status = item_progress.get_status ();
                                package.progress = item_progress.percentage;
                            }

                            break;
                        default:
                            break;
                    }

                    callback (progress, type);
                });

                exit_code = results.get_exit_code ();
            } catch (Error e) {
                result.error = e;
                exit_code = Pk.Exit.FAILED;
            }

            foreach (var package in packages) {
                yield package.reset ();
                package.exit_code = exit_code;
            }   

            return result;
        }

        public async static TransactionResult perform_default_action (DebianPackage package, Cancellable? cancellable) {
            if (package.is_installed) {
                var result = yield package.uninstall (cancellable);
                return result;
            } else {
                var result = yield package.install (cancellable);
                return result;
            }
        }

        public static unowned string status_to_title (Pk.Status status) {
            // From https://github.com/elementary/appcenter/blob/master/src/Core/ChangeInformation.vala#L51
            switch (status) {
                case Pk.Status.SETUP:
                    return _("Starting");
                case Pk.Status.WAIT:
                    return _("Waiting");
                case Pk.Status.RUNNING:
                    return _("Running");
                case Pk.Status.QUERY:
                    return _("Querying");
                case Pk.Status.INFO:
                    return _("Getting information");
                case Pk.Status.REMOVE:
                    return _("Removing packages");
                case Pk.Status.DOWNLOAD:
                    return _("Downloading");
                case Pk.Status.INSTALL:
                    return _("Installing");
                case Pk.Status.REFRESH_CACHE:
                    return _("Refreshing software list");
                case Pk.Status.UPDATE:
                    return _("Installing updates");
                case Pk.Status.CLEANUP:
                    return _("Cleaning up packages");
                case Pk.Status.OBSOLETE:
                    return _("Obsoleting packages");
                case Pk.Status.DEP_RESOLVE:
                    return _("Resolving dependencies");
                case Pk.Status.SIG_CHECK:
                    return _("Checking signatures");
                case Pk.Status.TEST_COMMIT:
                    return _("Testing changes");
                case Pk.Status.COMMIT:
                    return _("Committing changes");
                case Pk.Status.REQUEST:
                    return _("Requesting data");
                case Pk.Status.FINISHED:
                    return _("Finished");
                case Pk.Status.CANCEL:
                    return _("Cancelling");
                case Pk.Status.DOWNLOAD_REPOSITORY:
                    return _("Downloading repository information");
                case Pk.Status.DOWNLOAD_PACKAGELIST:
                    return _("Downloading list of packages");
                case Pk.Status.DOWNLOAD_FILELIST:
                    return _("Downloading file lists");
                case Pk.Status.DOWNLOAD_CHANGELOG:
                    return _("Downloading lists of changes");
                case Pk.Status.DOWNLOAD_GROUP:
                    return _("Downloading groups");
                case Pk.Status.DOWNLOAD_UPDATEINFO:
                    return _("Downloading update information");
                case Pk.Status.REPACKAGING:
                    return _("Repackaging files");
                case Pk.Status.LOADING_CACHE:
                    return _("Loading cache");
                case Pk.Status.SCAN_APPLICATIONS:
                    return _("Scanning applications");
                case Pk.Status.GENERATE_PACKAGE_LIST:
                    return _("Generating package lists");
                case Pk.Status.WAITING_FOR_LOCK:
                    return _("Waiting for package manager lock");
                case Pk.Status.WAITING_FOR_AUTH:
                    return _("Waiting for authentication");
                case Pk.Status.SCAN_PROCESS_LIST:
                    return _("Updating running applications");
                case Pk.Status.CHECK_EXECUTABLE_FILES:
                    return _("Checking applications in use");
                case Pk.Status.CHECK_LIBRARIES:
                    return _("Checking libraries in use");
                case Pk.Status.COPY_FILES:
                    return _("Copying files");
            }

            return "";            
        }

        public DebianPackage (string filename) {
            Object (filename: filename);
        }

        public async TransactionResult install (Cancellable? _cancellable) {
            has_task = true;
            cancellable = _cancellable;
            exit_code = Pk.Exit.UNKNOWN;

            var result = new TransactionResult (Pk.Role.INSTALL_FILES);
            result.add_package (this);

            string[] filenames = { filename, null };

            try {
                var results = yield client.install_files_async (filenames, cancellable, progress_callback);
                exit_code = results.get_exit_code ();
            } catch (Error e) {
                result.error = e;
                exit_code = Pk.Exit.FAILED;
            }

            yield reset ();
            return result;
        }

        public async TransactionResult uninstall (Cancellable? _cancellable) {
            has_task = true;
            cancellable = _cancellable;
            exit_code = Pk.Exit.UNKNOWN;

            string[] names = { target.package_id, null };

            var result = new TransactionResult (Pk.Role.REMOVE_PACKAGES);
            result.add_package (this);

            try {
                var results = yield client.remove_packages_async (names, false, false, cancellable, progress_callback);
                exit_code = results.get_exit_code ();
            } catch (Error e) {
                result.error = e;
                exit_code = Pk.Exit.FAILED;
            }

            yield reset ();
            return result;
        }

        public void cancel () {
            if (cancellable != null && can_cancel) {
                cancellable.cancel ();
            }
        }
        
        public async bool populate () {
            string[] filenames = { filename, null };
            try {
                var results = yield client.get_details_local_async (filenames, null, () => {});
                var details = results.get_details_array ()[0];

                target = new Pk.Package ();
                if (target.set_id (details.package_id)) {
                    target.summary = details.summary;
                    target.description = details.description;
                    target.size = details.size;
                    target.url = details.url;

                    yield update_installed_state ();
                    return true;
                }
              
            } catch (Error e) {
                warning (e.message);
            }

            return false;            
        }

        public async void update_installed_state () {
            string[] names = { name, null };

            uint installed = 0;
            try {
                var results = yield client.resolve_async (Pk.Filter.INSTALLED, names, null, () => {});
                results.get_package_array ().@foreach ((package) => {
                    if (Pk.Info.INSTALLED in package.get_info ()) {
                        installed++;
                    }
                });
            } catch (Error e) {
                warning (e.message);
            }

            is_installed = installed >= 1;
        }

        public unowned string get_status_title () {
            return status_to_title (status);
        }

        public unowned string? get_exit_icon () {
            switch (exit_code) {
                case Pk.Exit.SUCCESS:
                    return "process-completed-symbolic";
                case Pk.Exit.FAILED:
                case Pk.Exit.KILLED:
                    return "dialog-error-symbolic";
            }

            return null;
        }

        public unowned string get_exit_title () {
            switch (exit_code) {
                case Pk.Exit.SUCCESS:
                    return _("Finished");
                case Pk.Exit.CANCELLED:
                    return _("Cancelled");
                case Pk.Exit.FAILED:
                case Pk.Exit.KILLED:
                    return _("Failed");
            }

            return _("Unknown");
        }

        public async void reset () {
            yield update_installed_state ();
            progress = 0;
            can_cancel = false;
            status = Pk.Status.UNKNOWN;
            cancellable = null;
            has_task = false;
        }

        private void progress_callback (Pk.Progress _progress, Pk.ProgressType type) {
            switch (type) {
                case Pk.ProgressType.STATUS:
                    status = _progress.get_status ();
                    break;
                case Pk.ProgressType.PERCENTAGE:
                    progress = _progress.percentage;
                    break;
                case Pk.ProgressType.ALLOW_CANCEL:
                    can_cancel = _progress.allow_cancel;
                    break;
                default:
                    break;
            }
        }
    }
}