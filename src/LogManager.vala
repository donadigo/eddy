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

public class Eddy.LogManager : Object {
    public bool fetched { get; set; default = false; }

    private DesktopAppInfo? app_info;
    private Gee.HashSet<PackageUri> installed_uris;

    private static LogManager? instance = null;
    public static LogManager get_default () {
        if (instance == null) {
            instance = new LogManager ();
        }

        return instance;
    }

    private LogManager () {
        installed_uris = new Gee.HashSet<PackageUri> ((Gee.HashDataFunc<PackageUri>?)package_uri_hash_func, (Gee.EqualDataFunc<PackageUri>?)package_uri_equal_func);
    }

    construct {
        app_info = new DesktopAppInfo ("com.github.donadigo.eddy.desktop");
    }

    public Gee.HashSet<PackageUri> get_installed_uris () {
        return installed_uris;
    }

    public void fill_out_external_uri (PackageUri puri) {
        foreach (PackageUri existing_puri in installed_uris) {
            if (existing_puri.uri == puri.uri) {
                puri.installed_timestamp = existing_puri.installed_timestamp;
            }
        }
    }

    public int64 log_events (TransactionResult result) {
#if USE_ZEITGEIST
        var event = new Zeitgeist.Event ();
        event.interpretation = "package-install";
        event.manifestation = "user-action";
        event.timestamp = new DateTime.now_local ().to_unix ();
        
        if (app_info == null) {
            app_info = new DesktopAppInfo ("com.github.donadigo.eddy.desktop");
        }

        if (app_info != null) {
            event.set_actor_from_app_info (app_info);
        }

        foreach (var package in result.packages) {
            var sub = new Zeitgeist.Subject ();
            sub.uri = File.new_for_path (package.filename).get_uri ();

            event.add_subject (sub);
        }

        try {
            Zeitgeist.Log.get_default ().insert_event_no_reply (event);
        } catch (Error e) {
            warning ("Failed to add events to log: %s", e.message);
        }

        return event.timestamp;
#else
        return 0;
#endif
    }

    public async int fetch () {
#if USE_ZEITGEIST
        var event = new Zeitgeist.Event ();
        event.interpretation = "package-install";
        event.manifestation = "user-action";

        if (app_info == null) {
            app_info = new DesktopAppInfo ("com.github.donadigo.eddy.desktop");
        }

        if (app_info != null) {
            event.set_actor_from_app_info (app_info);
        }

        var templates = new GenericArray<Zeitgeist.Event> (1);
        templates.add (event);

        try {
            var result_set = yield Zeitgeist.Log.get_default ().find_events (
                new Zeitgeist.TimeRange.anytime (),
                templates,
                Zeitgeist.StorageState.ANY,
                100,
                Zeitgeist.ResultType.MOST_RECENT_EVENTS 
            );

            while (result_set.has_next ()) {
                var ev = result_set.next_value ();
                if (ev == null) {
                    break;
                }

                for (int i = 0; i < ev.num_subjects (); i++) {
                    var sub = ev.get_subject (i);
                    var puri = new PackageUri (sub.uri, ev.timestamp);

                    // If this package was installed multiple times,
                    // we'll take advantage of the fact that we use only the URI string
                    // to compare PackageUri's and that the recent event will be on top.
                    installed_uris.add (puri);
                }
            }
        } catch (Error e) {
            warning (e.message);
        }

        fetched = true;
        return installed_uris.size;
#else
        return 0;
#endif
    }
}