using Collector.Settings;
using Collector.Utils.JSON;
using Collector.Core.Networking.TCPClient;

namespace Collector.Core.Commands {

    using Soup;
    using Json;

    class GetRelaysCommand : Command {

        public string relay    { get; set; }
        public bool   success  { get; set; default=false; }

        public GetRelaysCommand(TCPClient connection) {
            initialize(connection);
        }

        public override void handle_response(Json.Object result) {
            stdout.puts("got result");
        }

        public override void execute() {
            this.on_message_received.connect(handle_response);
        }
    }
}


