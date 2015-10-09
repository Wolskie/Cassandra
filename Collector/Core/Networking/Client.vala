namespace Collector.Core.Networking {

    using Gee;

    public class Client {

        private string[] _relays;

        public Client(string[] relays) {
            _relays = IdentifyRelays(relays);
        }

        /**
         * Ping each relay if we get the response, we are
         * expecting, update _relays.
         */
        public string[] IdentifyRelays(string[] relays) {
            string[]  goodrelays = {};
            return goodrelays;
        }
    }

}
