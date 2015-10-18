using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.RPCClient;

static int main(string[] args) {
    Config.init();

    PingCommand p = new PingCommand("http://127.0.0.1:899");
    p.execute();

    if(p.success) {
        stdout.puts("Success");
    } else {
        
        stdout.puts("failed");
    }

    return 0;
}
