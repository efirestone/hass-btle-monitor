FROM resin/rpi-raspbian:stretch

# Build environment variables
ENV MON_VER=0.1.675 \
    CREATED="BLOODY2k" \
    MON_OPT=""

RUN apt-get update && \
    apt-get -y install apt-transport-https && \
    curl http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key > /mosquitto-repo.gpg.key && \
    apt-key add /mosquitto-repo.gpg.key && \
    curl http://repo.mosquitto.org/debian/mosquitto-stretch.list > /etc/apt/sources.list.d/mosquitto-st$ && \
    apt-cache search mosquitto && \
    apt-get update && \
    apt-get install -y \
        bluez \
        bluez-tools \
        libbluetooth-dev \
        libmosquitto-dev \
        mosquitto \
        mosquitto-clients \
        xxd \
        bc \
        bluez-hcidump \
        git \
        wget && \
    apt-get clean && \
    rm /mosquitto-repo.gpg.key && \
    rm /etc/apt/sources.list.d/mosquitto-st$ && \
    rm -rf /var/lib/apt/lists/*

ADD startup.sh /startup.sh

# Install Monitor
RUN ["chmod", "+x", "/startup.sh"]
ENTRYPOINT ["/startup.sh"]

# Annotate the mountable volume points
VOLUME /config
