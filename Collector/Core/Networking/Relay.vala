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
            PingCommand query = new PingCommand(this.endpoint);
            query.execute();

            return query.success;
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

            PingCommand status_check = new PingCommand(relay);
            status_check.execute();

            if(status_check.success == true) {
                stdout.puts(@"RelayConroller: add(): Added relay '$relay'\n");
                relays.add(relay);
            } else {
                stdout.puts(@"RelayConroller: add(): '$relay' did not respond\n");
            }

            return status_check.success;
        }

    }

}
