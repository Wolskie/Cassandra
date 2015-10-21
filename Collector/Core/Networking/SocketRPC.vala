namespace Collector.Core.Networking.SocketRPC {

    using Gee;
    using Soup;

    public class SocketRPC : GLib.Object {


        public URI relay      { get; set; }
        public int request_id { get; set; default = 0  ; }

        protected SocketClient client;
        protected TcpConnection connection;
        protected InetAddress address;

        public SocketRPC(string uri) {

            relay = new URI(uri);
            request_id = Random.int_range(0,100000);

            address = new InetAddress.from_string(relay.get_host());
            client  = new SocketClient();

            connection = (TcpConnection) client.connect(
                    new InetSocketAddress(address, (uint16)relay.get_port()));
        }

        public async void request(string method, string[] param) throws Error {
            connection.output_stream.write(@"{ $method }\n\0".data);

            connection.socket.set_blocking(true);
            DataInputStream input = new DataInputStream(connection.input_stream);
            string m = input.read_line(null).strip();

            stdout.puts(@"request: $m");
        }

    }
}
