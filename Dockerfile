FROM ubuntu:xenial

# 告诉APT，不回答打包问题
ENV DEBIAN_FRONTEND noninteractive

ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 443
ENV SSH_HOST localhost
ENV SSH_PORT 22
ENV OPENVPN_HOST localhost
ENV OPENVPN_PORT 1194
ENV HTTPS_HOST localhost
ENV HTTPS_PORT 8443

# 安装包
RUN apt-get update -y && \
    apt-get install -y sslh && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# 默认放出端口
EXPOSE 443

# 将脚本设置为在容器启动时运行
CMD sslh -f -u root -p ${LISTEN_IP}:${LISTEN_PORT} --ssh ${SSH_HOST}:${SSH_PORT} --ssl ${HTTPS_HOST}:${HTTPS_PORT} --openvpn ${OPENVPN_HOST}:${OPENVPN_PORT}
