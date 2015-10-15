using Collector.Config;
using Collector.Core.Commands;
using Collector.Core.Networking.RPCClient;

static int main(string[] args) {

    JsonRPCClient a = new JsonRPCClient("http://127.0.0.1:9292");

    a.request("abc", {"a", "b"});
    return 0;
}
