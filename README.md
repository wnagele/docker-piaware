### Requirements
 * Register a Flightaware account ([flightaware.com](http://flightaware.com))
 * Beast data feed (for instance [mradochonski/dump1090-docker](https://hub.docker.com/r/mradochonski/dump1090-docker))

### Running
`docker run --link dump1090:beast --env FEEDER_ID=<feeder id> wnagele/piaware <flightaware user> <flightaware password>`

### Configuration
Flightaware normally assigns a random feeder ID every time a Piaware site connects to it. As Flightaware uses this ID to identify a receiver you have to use the FEEDER\_ID environment variable to keep it consistent. Running this for the first time omit the FEEDER\_ID variable and find the "Site identifier" value shown on Flightaware MyADSB page. For all subsequent invocations use this value as your FEEDER\_ID.

### Environment variables
Use `BEAST_PORT_30005_TCP_ADDR` and `BEAST_PORT_30005_TCP_PORT` to configure the connection details for the Beast data feed. If you link in a container named `beast` that exposes port 30005 these will be set by Docker directly.

MLAT support is enabled by default. You can set `MLAT` to `no` if you would like to disable it.
