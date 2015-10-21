using Collector.Settings;

namespace Collector.Core.Networking.TCPClient {

    errordomain Error {
        MESSAGE
    }

    public class TCPClient : GLib.Object {

        public signal void on_data_received(string data);
        public signal void on_client_disconect();

        private int port {
            get; set ;
            default = 9293;
        }

        private bool connected {
            get; set;
            default = false;
        }

        private InetAddress address;
        private SocketClient client;
        private SocketConnection connection;


        public TCPClient() {
            if(Config.DEBUG) {
                stdout.puts("TCPClient(): New client.\n");
            }
        }

        public void connect(string ip_address, int port) {

            this.port = port;
            address = new InetAddress.from_string(ip_address);
            client = new SocketClient();

            if(Config.DEBUG) {
                stdout.puts("TCPClient: connect(): Attempting connection to " +
                        ip_address + @":$port...\n");
            }

            try {
                process_request();
            } catch(Error e) {
                if(Config.DEBUG) {
                    stdout.puts("TCPClient: connect(): Failed.\n");
                }
            }

        }

        private void process_request() throws Error {

            InetSocketAddress socket = new InetSocketAddress(address, (uint16)port);

            try {
                connection = client.connect(socket, null);
                if(!connection.closed) {
                    if(Config.DEBUG) {
                        connected = true;
                        stdout.puts("TCPClient: process_request(): Connected.\n");
                    }
                }
            } catch(GLib.Error e) {
                return;
            }

            DataInputStream input = new DataInputStream(connection.input_stream);

            ThreadFunc<void*> run = () => {

                string message = "";

                while(connected) {
                    try {
                        uint8 byte = input.read_byte(null);
                        message += ((unichar)byte).to_string();

                        if(message.has_suffix("\r\n\r\n")) {
                            on_data_received(message.strip());
                            message = "";
                        }


                    } catch(GLib.Error e) {
                        disconnect();
                        return null;
                    }
                }
                return null;
            };

            new Thread<void*>("readThread", run);

        }

        public void disconnect() {
            if(!connected) {
                try {

                    if(Config.DEBUG) {
                        stdout.puts("TCPClient: disconnect(): Disconnecting.\n");
                    }

                    connection.socket.close();
                    connection.close();
                    connected = false;

                    on_client_disconect();
                    connection.dispose();
                    client.dispose();

                } catch(GLib.Error e) {

                    if(Config.DEBUG) {
                        stdout.puts("TCPClient: disconnect(): Not connected.\n");
                    }
                }
            }
        }

    }

}
