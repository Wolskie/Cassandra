
using Collector.Settings;

namespace Collector.Core.Commands {

    abstract class Command {

        public bool executed {
            get; set; default=false;
        }

        public abstract void handle_response();
        public abstract void execute();
    }
}


