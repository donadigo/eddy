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

public class Eddy.Application : Gtk.Application {
    public static string[] supported_mimetypes;

    private Pk.Control control;
    private MainWindow? window = null;

    construct {
        flags |= ApplicationFlags.HANDLES_OPEN;

        application_id = "com.github.donadigo.eddy";

        Intl.setlocale (LocaleCategory.ALL, "");
        Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
        Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (GETTEXT_PACKAGE);

        control = new Pk.Control ();

        var settings = AppSettings.get_default ();
        string[] available_mimetypes = settings.mime_types;

        if (available_mimetypes.length > 0) {
            debug ("Using cached mime types from %s schema: %s", Constants.SCHEMA_NAME, string.joinv ("; ", available_mimetypes));
            supported_mimetypes = available_mimetypes;
        } else {
            try {
                bool success = control.get_properties ();
                if (success) {
                    string[] mimes = strdupv (control.mime_types);
                    if (mimes.length > 0) {
                        supported_mimetypes = mimes;
                    }
                }
            } catch (Error e) {
                warning (e.message);
            }

            if (supported_mimetypes.length > 0) {
                debug ("Found %i supported mime types: %s", supported_mimetypes.length, string.joinv ("; ", supported_mimetypes));
            } else {
                debug ("No supported mime types found. Using default set of mime types");
                supported_mimetypes = Constants.DEFAULT_SUPPORTED_MIMETYPES;
            }

            settings.mime_types = supported_mimetypes;

            // Register Eddy as the default app if there's no handler for a supported mimetype
            register_default_handler ();
        }
        
        var quit_action = new SimpleAction ("quit", null);
        add_action (quit_action);
        set_accels_for_action ("app.quit", {"<Control>q"});
        quit_action.activate.connect (() => {
            if (window != null) {
                window.close ();
            }
        });
    }

    private static void register_default_handler () {
        var app_info = new DesktopAppInfo (Constants.DESKTOP_NAME);
        if (app_info == null) {
            warning ("AppInfo object not found for %s.", Constants.DESKTOP_NAME);
            return;
        }

        foreach (string mimetype in supported_mimetypes) {
            var handler = AppInfo.get_default_for_type (mimetype, false);
            if (handler == null) {
                try {
                    debug ("Registering %s as the default handler for %s", Constants.APP_NAME, mimetype);
                    app_info.set_as_default_for_type (mimetype);
                } catch (Error e) {
                    warning (e.message);
                }
            } else {
                unowned string[] types = handler.get_supported_types ();
                if (types == null || !(mimetype in types)) {
                    try {
                        debug ("Registering %s as the default handler for %s", Constants.APP_NAME, mimetype);
                        app_info.set_as_default_for_type (mimetype);
                    } catch (Error e) {
                        warning (e.message);
                    }
                }
            }
        }
    }

    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }

    public override void open (File[] files, string hint) {
        activate ();

#if USE_ZEITGEIST
        // Keep a reference to the File array when LogManager fetches the data
        var local_files = files;

        var log_manager = LogManager.get_default ();
        if (!log_manager.fetched) {
            ulong connect_id = 0U;
            connect_id = log_manager.notify["fetched"].connect (() => {
                if (log_manager.fetched) {
                    log_manager.disconnect (connect_id);
                    process_files (local_files);
                }
            });
        }
#else
        process_files (files);
#endif
    }

    private void process_files (File[] files) {
        var log_manager = LogManager.get_default ();

        PackageUri[] puris = {};
        foreach (var file in files) {
            var puri = new PackageUri (file.get_uri (), -1);
            log_manager.fill_out_external_uri (puri);
            puris += puri;
        }

        if (window != null) {
            window.open_uris.begin (puris);
        }
    }

    public override void activate () {
        if (window == null) {
            window = new MainWindow ();
            add_window (window);
            window.show_all ();
        } else {
            window.present ();
        }

        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });
    }
}

