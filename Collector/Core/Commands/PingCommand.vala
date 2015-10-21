using Collector.Settings;
using Collector.Core.Networking.SocketRPC;

namespace Collector.Core.Commands {

    using Soup;
    using Json;

    class PingCommand : Command {

        public string relay    { get; set; }
        public bool   success  { get; set; default=false; }

        public PingCommand(SocketRPC connection, string relay) {
            initialize(connection);

            // Set this.relay so we can access
            // relay here since this ping command
            // main objective is to talk to the relay,
            // other commands may not need this.

            this.relay = relay;
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
            Json.Object response = connection.request("ping", {});
            handle_response(response);
        }
    }
}


