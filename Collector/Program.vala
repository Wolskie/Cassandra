using Collector.Config;
using Collector.Core.Commands;
using Collector.Core.Networking.RPCClient;

static int main(string[] args) {

    JsonRPCClient a = new JsonRPCClient("http://test");

    a.request("test", {"a", "b"});
    return 0;
}
