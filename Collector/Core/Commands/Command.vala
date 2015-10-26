
using Collector.Settings;
using Collector.Utils.JSON;
using Collector.Core.Networking.TCPClient;

namespace Collector.Core.Commands {

    abstract class Command {

        protected TCPClient client {
            get; set;
        }

        public void initialize(TCPClient client) {
            this.client = client;
        }

        public abstract async void execute();
    }
}


