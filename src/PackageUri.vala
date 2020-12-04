
public class Eddy.PackageUri {
    public string uri;
    public int64 installed_timestamp = -1;

    public PackageUri (string uri, int64 timestamp) {
        this.uri = uri;
        this.installed_timestamp = timestamp;
    }
}

namespace Eddy {
    public static uint package_uri_hash_func (PackageUri puri) {
        return str_hash (puri.uri);
    }

    public static bool package_uri_equal_func (PackageUri puri1, PackageUri puri2) {
        return str_equal (puri1.uri, puri2.uri);
    }
}