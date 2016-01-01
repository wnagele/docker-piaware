#!/bin/sh
if [ -z "$2" ]; then
  echo "Missing arguments: <flightaware user> <flightaware password>"
  exit 1
fi
if [ -z "${BEAST_PORT_30005_TCP_ADDR}" ]; then
  echo "BEAST_PORT_30005_TCP_ADDR environment variable not set"
  exit 1
fi

echo "user: $1" > /root/.piaware
echo "password: $2" >> /root/.piaware
if [ "yes" = "${MLAT}" ]; then
  echo "mlat: 1" >> /root/.piaware
elif [ "no" = "${MLAT}" ]; then
  echo "mlat: 0" >> /root/.piaware
fi

socat TCP-LISTEN:30005,fork TCP:${BEAST_PORT_30005_TCP_ADDR}:${BEAST_PORT_30005_TCP_PORT:-30005} &
/usr/bin/piaware -debug
