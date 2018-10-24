#!/bin/sh
if [ -z "$2" ]; then
  echo "Missing arguments: <flightaware user> <flightaware password>"
  exit 1
fi
if [ -z "${BEAST_PORT_30005_TCP_ADDR}" ]; then
  echo "BEAST_PORT_30005_TCP_ADDR environment variable not set"
  exit 1
fi

/usr/bin/piaware-config flightaware-user "$1"
/usr/bin/piaware-config flightaware-password "$2"
/usr/bin/piaware-config allow-mlat "${MLAT}"

if [ -n "${FEEDER_ID}" ]; then
  /usr/bin/piaware-config feeder-id "${FEEDER_ID}"
fi

socat TCP-LISTEN:30005,fork TCP:${BEAST_PORT_30005_TCP_ADDR}:${BEAST_PORT_30005_TCP_PORT:-30005} &
/usr/bin/piaware -debug
