
using Collector.Settings;
using Collector.Core.Networking.RPCClient;

namespace Collector.Core.Commands {

    using Json;

    abstract class Command {

        public bool executed {
            get; set; default=false;
        }

        protected JsonRPCClient client {
            get; set;
        }

        protected void initialize(string relay) {
            this.client = new JsonRPCClient(relay);
            this.client.authenticate(Config.USERNAME, Config.PASSWORD);
        }

        public abstract void handle_response(Json.Object result);
        public abstract void execute();
    }
}


