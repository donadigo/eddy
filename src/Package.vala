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

public class Eddy.Package : Object {
    private const int AUTH_FAILED_CODE = 303;
    private const int CANCELLED_CODE = 303;

    private static Pk.Task client;

    [Flags]
    public enum StateFlags {
        NOT_INSTALLED,
        INSTALLED,
        CAN_DOWNGRADE,
        CAN_UPDATE
    }

    public signal void state_updated ();

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
    public int progress { get; set; default = -1; }

    public bool can_cancel { public get; private set; default = false; }
    public bool has_task { get; set; default = false; }

    public StateFlags state_flags { public get; private set; default = StateFlags.NOT_INSTALLED; }
    
    public bool is_installed { 
        get {
            return StateFlags.INSTALLED in state_flags;
        }
    }

    public bool can_downgrade {
        get {
            return StateFlags.CAN_DOWNGRADE in state_flags;
        }
    }

    public bool can_update {
        get {
            return StateFlags.CAN_UPDATE in state_flags;
        }
    }

    public bool should_show_progress {
        get {
            return has_task &&
                progress >= 0 &&
                progress <= 100 &&
                status != Pk.Status.FINISHED &&
                status != Pk.Status.CANCEL &&
                status != Pk.Status.WAIT &&
                status != Pk.Status.WAITING_FOR_LOCK &&
                status != Pk.Status.WAITING_FOR_AUTH;
        }
    }

    private Cancellable? cancellable = null;

    private Pk.Package? target = null;

    static construct {
        client = new Pk.Task ();
        client.interactive = false;
        client.allow_reinstall = true;
    }

    public static bool get_was_cancelled (Error error) {
        return error.matches (Pk.ClientError.quark (), AUTH_FAILED_CODE) || error.matches (IOError.quark (), CANCELLED_CODE);
    }

    public async static TransactionResult install_packages (Gee.ArrayList<Package> packages, Cancellable? cancellable, Pk.ProgressCallback progress_callback_external) {
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
                            package.progress = (int)item_progress.percentage;
                        }

                        break;
                    default:
                        break;
                }

                progress_callback_external (progress, type);
            });

            exit_code = results.get_exit_code ();
        } catch (Error e) {
            result.error = e;

            if (get_was_cancelled (result.error)) {
                exit_code = Pk.Exit.CANCELLED;
                result.cancelled = true;
            } else {
                exit_code = Pk.Exit.FAILED;
            }
        }

        foreach (var package in packages) {
            yield package.reset ();
            package.exit_code = exit_code;
        }   

        return result;
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
            case Pk.Status.INSTALL:
            default:
                return _("Installing");
        }
    }

    private static int compare_versions (string a, string b) {
        if (a == b) {
            return 0;
        }

        string[] atok = a.split ("~");
        string[] btok = b.split ("~");

        if (atok.length < 2 && btok.length >= 2) {
            return -1;
        } else if (atok.length >= 2 && btok.length < 2) {
            return 1;
        }

        string aver = atok[0];
        string bver = btok[0];

        string[] aparts = aver.split (".");
        string[] bparts = bver.split (".");

        int length = int.max (aparts.length, bparts.length);
        for (int i = 0; i < length; i++) {
            int rc = strcmp (aparts[i], bparts[i]);
            if (rc < 0) {
                return -1;
            } else if (rc > 0) {
                return 1;
            }
        }

        return 0;
    }

    public Package (string filename) {
        Object (filename: filename);
    }

    public async TransactionResult perform_default_action (Cancellable? cancellable, Pk.ProgressCallback progress_callback_external) {
        if (is_installed) {
            var result = yield uninstall (cancellable, progress_callback_external);
            return result;
        } else {
            var result = yield install (cancellable, progress_callback_external);
            return result;
        }
    }

    public async TransactionResult install (Cancellable? _cancellable, Pk.ProgressCallback progress_callback_external) {
        has_task = true;
        cancellable = _cancellable;
        exit_code = Pk.Exit.UNKNOWN;

        var result = new TransactionResult (Pk.Role.INSTALL_FILES);
        result.add_package (this);

        string[] filenames = { filename, null };

        try {
            var results = yield client.install_files_async (filenames, cancellable, (progress, type) => {
                progress_callback_internal (progress, type);
                progress_callback_external (progress, type);
            });

            exit_code = results.get_exit_code ();
        } catch (Error e) {
            result.error = e;

            if (get_was_cancelled (result.error)) {
                exit_code = Pk.Exit.CANCELLED;
                result.cancelled = true;
            } else {
                exit_code = Pk.Exit.FAILED;
            }
        }

        yield reset ();
        return result;
    }

    public async TransactionResult uninstall (Cancellable? _cancellable, Pk.ProgressCallback progress_callback_external) {
        has_task = true;
        cancellable = _cancellable;
        exit_code = Pk.Exit.UNKNOWN;

        string[] names = { target.package_id, null };

        var result = new TransactionResult (Pk.Role.REMOVE_PACKAGES);
        result.add_package (this);

        try {
            var results = yield client.remove_packages_async (names, false, false, cancellable, (progress, type) => {
                progress_callback_internal (progress, type);
                progress_callback_external (progress, type);
            });

            exit_code = results.get_exit_code ();
        } catch (Error e) {
            result.error = e;

            if (get_was_cancelled (result.error)) {
                exit_code = Pk.Exit.CANCELLED;
                result.cancelled = true;
            } else {
                exit_code = Pk.Exit.FAILED;
            }
        }

        yield reset ();
        return result;
    }

    public void cancel () {
        if (cancellable != null && can_cancel) {
            cancellable.cancel ();
        }
    }

    public async bool populate () throws Error {
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
            throw e;
        }

        return false;
    }

    public async void update_installed_state () {
        state_flags = StateFlags.NOT_INSTALLED;

        string[] names = { name, null };
        try {
            bool found = false;

            var results = yield client.resolve_async (Pk.Filter.INSTALLED, names, null, () => {});
            results.get_package_array ().@foreach ((package) => {
                if (found) {
                    return;
                }

                if (Pk.Info.INSTALLED in package.get_info ()) {
                    found = true;
                    state_flags = StateFlags.INSTALLED;

                    int rc = compare_versions (package.get_version (), version); 
                    if (rc == 1) {
                        state_flags |= StateFlags.CAN_DOWNGRADE;
                    } else if (rc == -1) {
                        state_flags |= StateFlags.CAN_UPDATE;
                    }
                }
            });
        } catch (Error e) {
            warning (e.message);
        }

        state_updated ();
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

    private void progress_callback_internal (Pk.Progress _progress, Pk.ProgressType type) {
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
