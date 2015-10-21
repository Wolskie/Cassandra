using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.TCPClient;
using Collector.Core.Networking.Relay;


void dispatch(string a) {
    stdout.puts(a);
    a = "";
}

void callback_a(uint8 byte) {
    string test = ((unichar)byte).to_string();
    a = a + test;

    if((a.index_of("\r\n") - a.length) < 0) {
        dispatch(a);
    }

}

static int main(string[] args) {
    Config.initialize();

    TCPClient client = new TCPClient();
    client.connect("127.0.0.1", 9293);


    client.sig_data_received.connect(callback_a);


    while(true) {

    }
    return 0;

}
