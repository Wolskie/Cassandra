
using Collector.Settings;
using Collector.Utils.JSON;
using Collector.Core.Networking.TCPClient;

namespace Collector.Core.Commands {

    abstract class Command {

        public signal void on_message_received(Json.Object response);

        public int request_id {
            get; set; default = 0;
        }

        public bool executed {
            get; set; default=false;
        }

        protected TCPClient client {
            get; set;
        }

        protected void on_data_received(string data) {
            Json.Object response = JsonUtils.parse_json(data);
            string response_id = response.get_string_member("request_id");

            //if(response_id == this.request_id.to_string()) {
                on_message_received(response);
            //}

        }

        protected void initialize(TCPClient client) {
            this.client = client;
            this.client.on_data_received.connect(on_data_received);
        }

        public abstract void handle_response(Json.Object result);
        public abstract void execute();
    }
}


