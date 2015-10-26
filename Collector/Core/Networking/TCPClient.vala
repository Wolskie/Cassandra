using Collector.Settings;

namespace Collector.Core.Networking.TCPClient {

    errordomain Error {
        MESSAGE
    }

    public class TCPClient : GLib.Object {

        public signal void on_data_received(string data);
        public signal void on_client_connect();
        public signal void on_client_disconect();

        private int port {
            get; set ;
            default = 9293;
        }

        public bool connected {
            get; set;
            default = false;
        }

        private InetAddress address;
        private SocketClient client;
        private TcpConnection connection;


        public TCPClient() {
            #if DEBUG
                stdout.puts("TCPClient(): New client.\n");
            #endif
        }

        public void connect(string ip_address, int port) {

            this.port = port;
            address = new InetAddress.from_string(ip_address);
            client = new SocketClient();

            #if DEBUG
                stdout.puts("TCPClient: connect(): Attempting connection to " +
                        ip_address + @":$port...\n");
            #endif

            try {
                process_request.begin();
            } catch(Error e) {
                if(Config.DEBUG) {
                    stdout.puts("TCPClient: connect(): Failed.\n");
                }
            }

        }

        public void write_string(string message) {
            if(!connected) {
                #if DEBUG
                    stdout.puts("TCPClient: write_string(): Not connected.\n");
                #endif

                return;
            }

            try {
                connection.output_stream.write(message.data, null);
            } catch (GLib.IOError e) {
                #if DEBUG
                    stdout.puts("TCPClient: write_string(): Failed.\n");
                #endif
                disconnect();
            }
        }

        private async void process_request() throws ThreadError {

            InetSocketAddress socket = new InetSocketAddress(address, (uint16)port);

            try {
                connection = (TcpConnection)client.connect(socket, null);
                if(!connection.closed) {
                    connected = true;
                    #if DEBUG
                        stdout.puts("TCPClient: process_request(): Connected.\n");
                    #endif
                }
            } catch(GLib.Error e) {
                return;
            }

            DataInputStream input = new DataInputStream(connection.input_stream);

            if(!Thread.supported()) {
                #if DEBUG
                    stdout.puts("TCPClient: process_request(): No thread support.\n");
                #endif
                return;
            }

            ThreadFunc<void*> run = () => {

                string message = "";

                while(connected) {
                    try {
                        uint8 byte = input.read_byte(null);
                        message += ((unichar)byte).to_string();

                        if(message.has_suffix("\r\n\r\n")) {
                            on_data_received(message);
                            message = "";
                        }

                    } catch(GLib.Error e) {
                        disconnect();
                        return null;
                    }
                }
                return null;
            };

            Thread.create<void*>(run, false);
        }

        public void disconnect() {
            if(!connected) {
                try {
                    #if DEBUG
                        stdout.puts("TCPClient: disconnect(): Disconnecting.\n");
                    #endif

                    connection.socket.close();
                    connection.close();
                    connected = false;

                    on_client_disconect();
                    connection.dispose();
                    client.dispose();

                } catch(GLib.Error e) {
                    #if DEBUG
                        stdout.puts("TCPClient: disconnect(): Not connected.\n");
                    #endif
                }
            }
        }
    }
}
