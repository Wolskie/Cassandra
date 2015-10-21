using Collector.Settings;
using Collector.Core.Commands;
using Collector.Core.Networking.SocketRPC;
using Collector.Core.Networking.Relay;

static int main(string[] args) {
    Config.initialize();

    SocketRPC client = new SocketRPC("http://127.0.0.1:9293");
    PingCommand p = new PingCommand(client, "127.0.0.1");
    p.execute();
    return 0;
}
