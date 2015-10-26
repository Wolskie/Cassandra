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

        public async void handle_response(string data) {
            stdout.puts("got response!");
        }

        public async override void execute() {
            string request = JsonUtils.build_json_string("get_relays", 0, {});
            client.on_data_received.connect(handle_response);
            client.write_string(request);
        }
    }
}


