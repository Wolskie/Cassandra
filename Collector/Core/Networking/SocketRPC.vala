using Collector.Utils.JSON;

namespace Collector.Core.Networking.SocketRPC {

    using Gee;
    using Soup;

    public class SocketRPC : GLib.Object {


        public URI relay      { get; set; }
        public int request_id { get; set; default = 0  ; }

        private SocketClient client;
        private TcpConnection connection;
        private InetAddress address;

        private DataInputStream  input_stream;
        private OutputStream output_stream;

        public SocketRPC(string uri) {

            // Create URI ange random rquest ID
            relay = new URI(uri);
            request_id = Random.int_range(0,100000);

            // Set adress 
            address = new InetAddress.from_string(relay.get_host());
            client  = new SocketClient();

            // Create Connection
            connection = (TcpConnection) client.connect(
                    new InetSocketAddress(address, (uint16)relay.get_port()));

            // Set the Output and input Stream
            input_stream = new DataInputStream(connection.input_stream);
            output_stream = connection.output_stream;

        }

        public Json.Object request(string method, string[] param) throws Error {

            string response;
            string request_json;
            request_id = request_id + 1;

            // Build the request message
            request_json = JsonUtils.build_json_string(method, request_id, param);

            // Write the message and wait for a response
            output_stream.write(request_json.data);

            connection.socket.set_blocking(true);
            response = input_stream.read_line(null).strip();
            connection.socket.set_blocking(false);

            // We have a response;
            stdout.puts(@"request: $response");

 
            return new Json.Object();

        }

    }
}
