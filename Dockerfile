FROM alpine:latest

ENV UUID=uuid1 ROOT_PASSWORD=alpine SSPASS=sspass UUID1=mp UUID2=wj UUID3=wsl UUID4=dxb UUID5=ycz UUID6=test

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
