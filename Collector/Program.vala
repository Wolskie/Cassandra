using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.TCPClient;
using Collector.Core.Networking.Relay;


void dispatch(string a) {
    stdout.puts(a);
    a = "";
}

void callback_a(string data) {
    stdout.puts(@"data='$data'");
}

static int main(string[] args) {
    Config.initialize();

    TCPClient client = new TCPClient();
    client.connect("127.0.0.1", 9293);


    client.on_data_received.connect(callback_a);


    while(true) {

    }
    return 0;

}
