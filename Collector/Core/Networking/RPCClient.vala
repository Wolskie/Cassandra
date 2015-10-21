
using Collector.Settings;

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

        /**
         * build_json
         *
         * Build jsonrpc json string
         *
         * @param method        method to use
         * @param parameters    method paramaters
         */
        private string build_json(string method, string[] parameters) {

            // Increase the request_id by one every
            // time so we know what the response was to.
            request_id = request_id + 1;


            // Build the json using builder
            Json.Builder builder = new Json.Builder();

            builder.begin_object();
            builder.set_member_name("cassandra");
            builder.add_string_value("0.0");

            builder.set_member_name("method");
            builder.add_string_value(method);


            if (parameters != null) {

                builder.set_member_name("params");
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

        public Json.Object parse_json(string data)  {
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

        /**
         * request
         *
         * Send jsontpc request
         *
         * @param method        Method to call
         * @param parameters    Method parameters
         */
        public Json.Object request(string method, string[] parameters)
        {

            size_t length;
            string http_response = "{}";

            Soup.Logger logger;

            // Create the JSON string
            string request = build_json(method, parameters);

            string response = "{}";

            if(Config.DEBUG) {
                logger = new Soup.Logger(Soup.LoggerLogLevel.BODY, -1);
            } else {
                logger = new Soup.Logger(Soup.LoggerLogLevel.NONE, -1);
            }

            try {
                Soup.Message msg = new Soup.Message("POST", this.endpoint);
                Soup.Session session = new Soup.Session();

                // Add logger depending on config
                session.add_feature(logger);

                // Add the headers object
                Soup.MessageHeaders headers = new Soup.MessageHeaders(
                        Soup.MessageHeadersType.REQUEST);

                // Create body and append json data
                Soup.MessageBody body = new Soup.MessageBody();
                body.append_take(request.data);

                // Set request headers for authentication
                headers.append("Content-Type", "application/json");
                headers.append("X-RPC-Auth-Username", this.username);
                headers.append("X-RPC-Auth-Password", this.password);

                // Apply the body and headers
                // to the message
                msg.request_headers = headers;
                msg.request_body = body;

                // Send the request
                session.send_message(msg);

                // Response from the relay
                response = (string) msg.response_body.flatten().data;


            } catch (Error e) {
                stdout.puts("RPCClient::request(): error=" + e.message);
            }

            return parse_json(response);

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
