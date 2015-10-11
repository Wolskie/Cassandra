namespace Collector.Core.Networking {

    using Gee;

    public class Client {

        private string[] _relays;

        public Client(string[] relays) {
            _relays = identify_relays(relays);
        }

        /**
         * Ping each relay if we get the response, we are
         * expecting, update _relays.
         */
        public string[] identify_relays(string[] relays) {
            string[]  goodrelays = {};
            return goodrelays;
        }
    }

}
