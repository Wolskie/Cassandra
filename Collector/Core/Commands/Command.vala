
using Collector.Settings;
using Collector.Core.Networking.TCPClient;

namespace Collector.Core.Commands {

    using Json;

    abstract class Command {

        public bool executed {
            get; set; default=false;
        }

        protected TCPClient client {
            get; set;
        }

        protected void initialize(TCPClient client) {
            this.client = client;
        }

        public abstract void handle_response(Json.Object result);
        public abstract void execute();
    }
}


