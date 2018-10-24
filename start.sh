#!/bin/sh
if [ "$#" -eq 2 ]; then
  FLIGHTAWARE_USER="$1"
  FLIGHTAWARE_PASS="$2"
elif [ "$#" -gt 2 ]; then
  echo "Too many arguments. Usage: [<flightaware user> <flightaware password>]"
  exit 1
elif [ "$#" -gt 0 ]; then
  echo "Too few arguments. Usage: [<flightaware user> <flightaware password>]"
  exit 1
fi
if [ -z "${BEAST_PORT_30005_TCP_ADDR}" ]; then
  echo "BEAST_PORT_30005_TCP_ADDR environment variable not set"
  exit 1
fi

/usr/bin/piaware-config flightaware-user "${FLIGHTAWARE_USER:?}"
/usr/bin/piaware-config flightaware-password "${FLIGHTAWARE_PASS:?}"
/usr/bin/piaware-config allow-mlat "${MLAT:=no}"

if [ -n "${FEEDER_ID}" ]; then
  /usr/bin/piaware-config feeder-id "${FEEDER_ID}"
fi

socat TCP-LISTEN:30005,fork TCP:${BEAST_PORT_30005_TCP_ADDR}:${BEAST_PORT_30005_TCP_PORT:-30005} &
/usr/bin/piaware -debug
