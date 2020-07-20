### Requirements
 * Register a Flightaware account ([flightaware.com](http://flightaware.com))
 * Beast data feed (for instance [mradochonski/dump1090-docker](https://hub.docker.com/r/mradochonski/dump1090-docker))

### Running
```docker run --link dump1090:beast --env FEEDER_ID=<feeder id> wnagele/piaware```

### Configuration
Flightaware normally assigns a random feeder ID (which is a 36-character UUID) every time a Piaware site connects to it. As Flightaware uses this ID to identify a receiver you have to use the `FEEDER_ID` environment variable to keep it consistent.

For the first run, omit the `FEEDER_ID` variable and start this container. [Claim your receiver]() and note the UUID on that page, which is the `FEEDER_ID`. Alternately, after claiming, you may go to your [My ADS-B](https://flightaware.com/adsb/stats/user/) page and find the "Unique Identifier" value. Use this value as your `FEEDER_ID`.

### Environment variables
Use `BEAST_PORT_30005_TCP_ADDR` and `BEAST_PORT_30005_TCP_PORT` to configure the connection details for the Beast data feed. If you link in a container named `beast` that exposes port 30005 these will be set by Docker directly.

MLAT support is enabled by default. You can set `MLAT` to `no` if you would like to disable it.
