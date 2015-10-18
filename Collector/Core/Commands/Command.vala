
using Collector.Settings;

namespace Collector.Core.Commands {

    using Json;

    abstract class Command {

        public bool executed {
            get; set; default=false;
        }

        public abstract void handle_response(Json.Object result);
        public abstract void execute();
    }
}


