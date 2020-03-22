FROM debian:stretch

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

RUN git clone https://github.com/flightaware/piaware_builder.git /piaware_builder
WORKDIR /piaware_builder
RUN git checkout 8cdcb9edec2b30d47be8bded54c30dc8876b0434
RUN ./sensible-build.sh stretch
WORKDIR /piaware_builder/package-stretch
RUN dpkg-buildpackage -b
RUN apt install -y ../piaware_*.deb

WORKDIR /
COPY start.sh /
RUN chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]
