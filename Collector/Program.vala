using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.RPCClient;

static int main(string[] args) {
    Config.initialize();

    PingCommand p = new PingCommand("http://127.0.0.1:8999");
    p.execute();

    return 0;
}
