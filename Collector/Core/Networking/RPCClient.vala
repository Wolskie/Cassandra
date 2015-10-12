
using Collector.Config;

namespace Collector.Core.Networking.RPCClient {
    using Soup;
    using Json;

    public class JsonRPCClient {

        public string endpoint  { get; set; }
        public string username  { get; set; }
        public string password  { get; set; }

        protected int request_id { get; set; default = 0;}

        /**
         * authenticate
         *
         * Set username and password to access the web
         * service via basic auth.
         *
         * @param username  Username for basic auth
         * @param password  Password for basic auth
         */
        public void authenticate(string username, string password) {
            this.username = username;
            this.password = password;
        }

        private string build_json(string method, string[] parameters) {

            // Increase the request_id by one every
            // time so we know what the response was to.
            request_id = request_id + 1;


            // Build the json using builder
            Json.Builder builder = new Json.Builder();

            builder.begin_object();
            builder.set_member_name("jsonrpc");
            builder.add_string_value("2.0");

            builder.set_member_name("method");
            builder.add_string_value(method);

            builder.set_member_name("params");
            builder.begin_array();
            foreach(var p in parameters) {
                builder.add_string_value(p);
            }
            builder.end_array();

            builder.set_member_name("id");
            builder.add_int_value(request_id);
            builder.end_object();

            Json.Generator generator = new Json.Generator();
            Json.Node root = builder.get_root();

            generator.set_root(root);

            return generator.to_data(null);

        }

        public string request(string method, string[] parameters) {

            size_t length;
            string response;

            // Create the JSON string
            string request = build_json(method, parameters);

            if(CSettings.DEBUG) {
                stdout.puts("RPCClient::request(): request=" + request);
            }

            try {
                Soup.Message msg = new Soup.Message("POST", this.endpoint);

            } catch (Error e) {
            }

            return "";

        }

        /**
         * JsonRPCClient
         *
         * Constructor
         *
         * Set the relay address to use and the class
         * name for the jsonrpc request.
         *
         * @param endpoint  Default relay address
         * @param rem_class Class to use in jsonrcp request
         */
        public JsonRPCClient(string endpoint) {
            this.endpoint  = endpoint;
            this.request_id = Random.int_range(0,100000);
        }

    }
}