FROM ubuntu:xenial
MAINTAINER atomney <atomney+docker@gmail.com>

# Tell APT that humans aren't going to answer package questions
ENV DEBIAN_FRONTEND noninteractive

ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 443
ENV SSH_HOST localhost
ENV SSH_PORT 22
ENV OPENVPN_HOST localhost
ENV OPENVPN_PORT 1194
ENV HTTPS_HOST localhost
ENV HTTPS_PORT 8443

# Install packages
RUN apt-get update -y && \
    apt-get install -y sslh && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# PORTS
EXPOSE 443

# Set the script to run on container launch
CMD sslh -f -u root -p ${LISTEN_IP}:${LISTEN_PORT} --ssh ${SSH_HOST}:${SSH_PORT} --ssl ${HTTPS_HOST}:${HTTPS_PORT} --openvpn ${OPENVPN_HOST}:${OPENVPN_PORT}
