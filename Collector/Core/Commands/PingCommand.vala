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

        /**
         * handle_response
         *
         * Takes the response json from the RPCClient
         * and performs the command with the results.
         *
         * @param response  response json from the rpclcient
         */
        public override void handle_response(Json.Object response) {
            string result = response.get_string_member("result");

            if(result.up() == "PONG") {
                this.success = true;
            }

            this.executed = true;
        }

        public override void execute() {
            Json.Object response = this.client.request("ping", {});
            handle_response(response);
        }
    }
}


