FROM alpine:latest

ENV UUID=dd4523c3-fa0a-4aa3-acfe-0a49c7f643ce VER=4.18.0 ROOT_PASSWORD=alpine SSH_PORT=7777 SSPASS=sspass

RUN apk add --no-cache --virtual .build-deps busybox bash ca-certificates curl openssh-server openssh-sftp-server caddy \
 && ssh-keygen -A \
 && mkdir -m 777 /etc/v2ray \
 && mkdir -m 777 /v2ray \
 && mkdir -m 777 /etc/caddy/www \
 && mkdir -m 777 /usr/bin/v2ray

ADD files/config.json /config.json
ADD files/caddy.conf /etc/caddy/caddy.conf
ADD files/authorized_keys /etc/ssh/authorized_keys
RUN chmod 600 /etc/ssh/authorized_keys
ADD files/sshd_config /etc/ssh/sshd_config
ADD files/index.html /etc/caddy/www/index.html
ADD run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh
