using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.TCPClient;
using Collector.Core.Networking.Relay;

void callback_a(string data) {
    string test = data.strip();
    stdout.puts(@"data='$test'");
}

static int main(string[] args) {
    Config.initialize();

    TCPClient client = new TCPClient();
    client.connect("127.0.0.1", 9293);


    client.on_data_received.connect(callback_a);
    client.write_string("test HELLO HELLO");

    GetRelaysCommand r = new GetRelaysCommand(client);
    r.execute();


    stdin.read_line();

    return 0;

}
