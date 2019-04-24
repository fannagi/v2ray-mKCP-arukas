FROM alpine:latest

ENV UUID=uuid VER=4.18.0 ROOT_PASSWORD=alpine SSPASS=sspass UU1ID=uuid1 UU2ID=uuid2 UU3ID=uuid3 UU4ID=uuid4 UU5ID=uuid5 UU6ID=uuid6

RUN apk add --no-cache --virtual .build-deps busybox bash ca-certificates curl openssh-server openssh-sftp-server caddy tzdata \
 && ssh-keygen -A \
 && mkdir -m 755 /etc/v2ray \
 && mkdir -m 755 /etc/caddy/www \
 && mkdir -m 755 /usr/bin/v2ray \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
 && echo "Asia/Shanghai" > /etc/timezone
 
ADD files/config.json /etc/v2ray/config.json
ADD files/caddy.conf /etc/caddy/caddy.conf
ADD files/authorized_keys /etc/ssh/authorized_keys
RUN chmod 600 /etc/ssh/authorized_keys
ADD files/sshd_config /etc/ssh/sshd_config
ADD files/index.html /etc/caddy/www/index.html
ADD run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh
