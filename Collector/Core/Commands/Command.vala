
using Collector.Settings;
using Collector.Core.Networking.SocketRPC;

namespace Collector.Core.Commands {

    using Json;

    abstract class Command {

        public bool executed {
            get; set; default=false;
        }

        protected SocketRPC connection {
            get; set;
        }

        protected void initialize(SocketRPC connection) {
            this.connection = connection;
        }

        public abstract void handle_response(Json.Object result);
        public abstract void execute();
    }
}


