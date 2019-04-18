FROM alpine:latest

ENV UUID=dd4523c3-fa0a-4aa3-acfe-0a49c7f643ce VER=4.18.0 ROOT_PASSWORD=alpine SSH_PORT=7777 SSPASS=sspass

RUN apk add --no-cache --virtual .build-deps bash ca-certificates curl openssh-server \
 && ssh-keygen -A \
 && mkdir -m 777 /v2ray \
 && mkdir -m 777 /caddy \
 && mkdir -m 777 /caddy/www

ADD config.json /config.json
ADD caddy/caddy.conf /caddy/caddy.conf
ADD caddy/index.html /caddy/www/index.html
ADD run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh