FROM resin/armv7hf-debian:stretch

# Build environment variables
ENV MONITOR_VERSION=0.1.675 \
    CREATED="BLOODY2k"

RUN apt-get update && apt-get -y install apt-transport-https

# GET Mosquitto key for apt
ADD http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key /mosquitto-repo.gpg.key
RUN apt-key add /mosquitto-repo.gpg.key
ADD http://repo.mosquitto.org/debian/mosquitto-stretch.list /etc/apt/sources.list.d/mosquitto-stretch.list
RUN apt-cache search mosquitto
 
# Install Monitor dependencies
RUN apt-get update && \
    apt-get install -y \
        pi-bluetooth \
        libmosquitto-dev \
        mosquitto \
        mosquitto-clients \
        git \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Monitor
WORKDIR /
RUN git clone git://github.com/andrewjfreyer/monitor
RUN bash /monitor/monitor.sh