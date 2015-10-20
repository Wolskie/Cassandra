# Cassandra 
Client Cassandra for Sarissa application.

## Notes

Below is a list of command and instructions we're planning on
supporting, this list will be dynamicall updated as we
design and progress development.

### Commands

**ping(String relay)**
Ask the relay to do self checks to ensure it's functional
and contact Sarissa as well as forward all tcp and udp traffic.

**register(Json.Object sysinfo)**
Send system information to sarissa.

**relays()**
Ask the relay for a list of other relays it knows about.

### Instructions

**uninstall()**
Uninstall Cassandra and or Bianca from the system if they
are installed, this will not remove collected data from the database.

**upgrade()**
Askes Bianca to upgrade to cassandra.

**startvnc(String password, String relay, int port)**
Starts VNCServer in reverse connection mode and connects
to the relay which will forward traffic.

**exec(String command)**
Execute _command_ on the system

**elevate()**
Uses a number of tricks to try get root.

**screenshot()**
Take and upload a screenshot.

_more will come ...__
