using Collector.Config;

namespace Collector.Core.Commands {
    class PingCommand : Command {

        public string relay   { get; set; }
        public bool   success { get; set; default=false; }

        public PingCommand(string relay) {
            this.relay = relay;
        }

        public void execute() {
            this.executed = true;
        }
    }
}


