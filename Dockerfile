FROM ubuntu:15.10

RUN apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade

RUN apt-get -y install git
RUN git clone https://github.com/flightaware/piaware_builder.git

RUN apt-get -y install wget build-essential debhelper tcl8.5-dev autoconf python3-dev python-virtualenv libz-dev
RUN piaware_builder/sensible-build.sh
WORKDIR /piaware_builder/package
RUN dpkg-buildpackage -b
RUN apt-get -y install net-tools tcllib tcl-tls itcl3 tclx8.4
RUN dpkg -i ../piaware_*.deb

RUN apt-get -y install socat
WORKDIR /
ADD start.sh /
RUN chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
