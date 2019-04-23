FROM alpine:latest

ENV UUID=uuid1 ROOT_PASSWORD=alpine SSPASS=sspass UU1ID=mp UU2ID=wj UU3ID=wsl UU4ID=dxb UU5ID=ycz UU6ID=test

RUN apk add --no-cache --virtual .build-deps busybox bash ca-certificates curl openssh-server openssh-sftp-server caddy \
 && ssh-keygen -A \
 && mkdir -m 755 /etc/caddy/www \
 && mkdir -m 755 /etc/v2ray \
 && mkdir -m 755 /usr/bin/v2ray
 
ADD files/config.json /etc/v2ray/config.json
ADD files/caddy.conf /etc/caddy/caddy.conf
ADD files/authorized_keys /etc/ssh/authorized_keys
RUN chmod 600 /etc/ssh/authorized_keys
ADD files/sshd_config /etc/ssh/sshd_config
ADD files/index.html /etc/caddy/www/index.html
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh
ENTRYPOINT /root/run.sh
