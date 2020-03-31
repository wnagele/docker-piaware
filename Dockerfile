FROM debian:buster

ENV PIAWARE_VERSION 3.8.1
ENV MLAT yes

RUN apt update && apt install -y \
  autoconf \
  build-essential \
  debhelper \
  devscripts \
  dh-systemd \
  git \
  libboost-filesystem-dev \
  libboost-program-options-dev \
  libboost-regex-dev \
  libboost-system-dev \
  libz-dev \
  python3-dev \
  python3-venv \
  socat \
  tcl8.6-dev \
  wget

# Workaround from version 3.8.1. Should be removed in the future.
RUN apt install -y libssl-dev tcl-dev chrpath
RUN git clone http://github.com/flightaware/tcltls-rebuild.git /tcltls-rebuild
WORKDIR /tcltls-rebuild
RUN ./prepare-build.sh buster
WORKDIR /tcltls-rebuild/package-buster
RUN dpkg-buildpackage -b
RUN apt install -y ../tcl-tls_*.deb

RUN git clone https://github.com/flightaware/piaware_builder.git /piaware_builder
WORKDIR /piaware_builder
RUN git fetch --all --tags && git checkout tags/v${PIAWARE_VERSION}
RUN ./sensible-build.sh buster
WORKDIR /piaware_builder/package-buster
RUN dpkg-buildpackage -b
RUN apt install -y ../piaware_*.deb

WORKDIR /
COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]
