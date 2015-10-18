using Collector.Settings;
using Collector.Core.Networking.RPCClient;

namespace Collector.Core.Commands {

    using Soup;
    using Json;
    using Gee;

    class PingCommand : Command {

        public string relay   { get; set; }
        public bool   success { get; set; default=false; }

        private JsonRPCClient client;

        public PingCommand(string relay) {
            this.relay  = relay;
            this.client = new JsonRPCClient(this.relay);
            this.client.authenticate(Config.USERNAME, Config.PASSWORD);
        }

        public override void handle_response() {
            this.executed = true;
        }

        public override void execute() {

            Json.Node response = this.client.request("ping", {});
            this.executed = true;
        }
    }
}


