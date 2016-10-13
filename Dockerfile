FROM debian:jessie

ENV MLAT yes

RUN apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade

RUN apt-get -y install git
RUN git clone https://github.com/flightaware/piaware_builder.git

RUN apt-get -y install wget build-essential debhelper tcl8.6-dev autoconf python3-dev python3-venv libz-dev dh-systemd
RUN piaware_builder/sensible-build.sh jessie
WORKDIR /piaware_builder/package-jessie
RUN dpkg-buildpackage -b
RUN apt-get -y install net-tools tcllib tcl-tls itcl3 tclx8.4 init-system-helpers
RUN dpkg -i ../piaware_*.deb

RUN apt-get -y install socat
WORKDIR /
ADD start.sh /
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
