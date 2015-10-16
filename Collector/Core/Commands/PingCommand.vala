using Collector.Settings;
using Collector.Core.Networking.RPCClient;

namespace Collector.Core.Commands {
    class PingCommand : Command {

        public string relay   { get; set; }
        public bool   success { get; set; default=false; }

        private JsonRPCClient client;

        public PingCommand(string relay) {
            this.relay  = relay;
            this.client = new JsonRPCClient(this.relay);
            this.client.authenticate(Config.USERNAME, Config.PASSWORD);
        }

        public void execute() {

            string response = this.client.request("ping", {});
            this.executed = true;
        }
    }
}


