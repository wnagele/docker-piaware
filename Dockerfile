FROM debian:stretch

ENV MLAT yes

RUN apt update && apt install -y \
  autoconf \
  build-essential \
  debhelper \
  dh-systemd \
  git \
  libz-dev \
  python3-dev \
  python3-venv \
  socat \
  tcl8.6-dev \
  wget

RUN git clone https://github.com/flightaware/piaware_builder.git
RUN piaware_builder/sensible-build.sh stretch
WORKDIR /piaware_builder/package-stretch
RUN dpkg-buildpackage -b
RUN apt install -y ../piaware_*.deb

WORKDIR /
COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]
