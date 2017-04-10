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

namespace Eddy.Constants {
    public const string APP_NAME = "Eddy";
    public const string EXEC_NAME = "github.donadigo.eddy";
    public const string DESKTOP_NAME = EXEC_NAME + ".desktop";
    public const Gdk.RGBA BRAND_COLOR = { 0.92, 0.33, 0.32, 1 };

    public const Gtk.TargetEntry[] DRAG_TARGETS = {{ "text/uri-list", 0, 0 }};
    public const string DPKG_DEB_BINARY = "/usr/bin/dpkg-deb";
    public const string[] SUPPORTED_MIMETYPES = { "application/vnd.debian.binary-package" };

    public const string WELCOME_VIEW_ID = "welcome-view";
    public const string LIST_VIEW_ID = "list-view";
    public const string DETAILED_VIEW_ID = "detailed-view";
    public const string PROGRESS_VIEW_ID = "progress-view";
}