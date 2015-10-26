using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.TCPClient;
using Collector.Core.Networking.Relay;

void callback_a(string data) {
    stdout.puts(@"data='$data'");
}

void callback_b(string data) {
    stdout.puts(@"testtest='$data'");
}


static int main(string[] args) {
    Config.initialize();
    TCPClient client = new TCPClient();
    client.on_data_received.connect(callback_a);

    var loop = new MainLoop();
    client.connect("127.0.0.1", 9293);

    GetRelaysCommand r = new GetRelaysCommand(client);
    r.execute();

    loop.run();

    return 0;

}
