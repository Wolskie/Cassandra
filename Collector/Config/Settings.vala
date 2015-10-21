namespace Collector.Settings {

    public class Config {

        public static string VERSION  = "0.0-dev";
        public static bool   DEBUG    = true;

        public static string DEFAULT_RELAY = "127.0.0.1:9292";
        public static int    PING_MAX_TIME = 1800;

        public static string USERNAME = "client_username";
        public static string PASSWORD = "ahY7^4sCd0(922ssDDsss)a";

        public static void initialize() {
            new Config();
        }

    }

}
