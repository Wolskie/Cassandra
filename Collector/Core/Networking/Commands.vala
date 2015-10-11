using Collector.Config;

namespace Collector.Core.Networking.Commands {

    using Gee;
    using Soup;
    using Json;

    public class Commands {

        /**
         * Create json string from a builder object.
         *
         * @param builder Json.Builder object to convert to string
         */
        private static string build_json(Builder builder) {
            Generator generator = new Json.Generator();
            Json.Node root = builder.get_root();
            generator.set_root(root);

            return generator.to_data(null);
        }

        /**
         * Query the relay to check if the relay is a sarissa
         * relay or not.
         *
         * @param relay URI of the relay in the form of host:port
         */
        public static string ping_relays(string relay) {

            Builder builder = new Builder();

            builder.begin_object();
            builder.set_member_name("command");
            builder.add_string_value("ping");
            builder.end_object();

            return  build_json(builder);

        }
    }

}
