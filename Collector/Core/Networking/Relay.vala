using Collector.Settings;
using Collector.Core.Commands;

namespace Collector.Core.Networking.Relay {

    using Gee;

    public class Relay {

        public string endpoint  { get; set; }

        public Relay(string endpoint) {
            this.endpoint = endpoint;
        }

        public string get_uri() {
            return this.endpoint;
        }

        public bool is_alive() {
            return false;
        }

    }

    public class RelayController : GLib.Object {

        static ArrayList<string> relays = new ArrayList<string>();

        /**
         * add
         *
         * Checks and adds a relay to a list of known
         * good relays.
         *
         * @param relay the relay to add
         */
        public static bool add(string relay) {
            return false;
        }

    }

}
