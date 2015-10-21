using Collector.Settings;

namespace Collector.Utils.JSON {
    using Json;

    class JsonUtils {

        /**
         * build_json
         *
         * Build jsonrpc json string
         *
         * @param method        method to use
         * @param parameters    method paramaters
         */
        public static string build_json_string(string method, int
                request_id, string[] parameters) {


            // Build the json using builder
            Json.Builder builder = new Json.Builder();
            DateTime now = new DateTime.now_local();


            builder.begin_object();
            builder.set_member_name("Cassandra");
            builder.add_string_value(Config.VERSION);

            builder.set_member_name("Auth-Username");
            builder.add_string_value(Config.USERNAME);

            builder.set_member_name("Auth-Password");
            builder.add_string_value(Config.PASSWORD);

            builder.set_member_name("Method");
            builder.add_string_value(method);


            if (parameters != null) {

                builder.set_member_name("Params");
                builder.begin_array();

                foreach(var p in parameters) {
                    builder.add_string_value(p);
                }

                builder.end_array();
            }

            builder.set_member_name("id");
            builder.add_int_value(request_id);
            builder.end_object();

            Json.Generator generator = new Json.Generator();
            Json.Node root = builder.get_root();

            generator.set_root(root);

            return generator.to_data(null);

        }

        public static Json.Object parse_json(string data)  {
            // Parse
            Json.Parser parser;
            Json.Object root = null;

            try {
                parser = new Json.Parser();
                parser.load_from_data (data);

                // Get the root node:
                root = parser.get_root().get_object();

            } catch (Error e) {
                stdout.printf ("Unable to parse the string: %s\n", e.message);
            }

            return root;
        }

    }

}
