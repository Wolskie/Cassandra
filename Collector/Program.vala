using Collector.Config;
using Collector.Core.Networking.Commands;

static int main(string[] args) {
    stdout.puts(Commands.ping_relays("test"));
    return 0;
}
