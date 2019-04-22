rm -f /etc/motd
cat >>/etc/motd <<EOF
Alpine Linux Version : $(cat /etc/alpine-release)
Kernel Version : $(uname -r)
Hostname : $(uname -n)
Enjoy your Docker-Linux Node !
EOF

echo "root:${ROOT_PASSWORD}" | chpasswd

echo "Start Success !"

sed -i "s/uuid/$UUID/g" /config.json
sed -i "s/sspass/$SSPASS/g" /config.json

#(/usr/sbin/sshd -D -e \
#	-o PermitRootLogin=yes \
#	-o Port=${SSH_PORT}) &
/usr/sbin/sshd -D -e &

/usr/sbin/caddy -conf /caddy/caddy.conf >/dev/null  2>&1  &

cd /v2ray
wget -O v2ray.zip http://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
unzip v2ray.zip 
if [ ! -f "v2ray" ]; then
  mv /v2ray/v2ray-v$VER-linux-64/v2ray .
  mv /v2ray/v2ray-v$VER-linux-64/v2ctl .
  mv /v2ray/v2ray-v$VER-linux-64/geoip.dat .
  mv /v2ray/v2ray-v$VER-linux-64/geosite.dat .
fi

cp -f /config.json .
chmod +x v2ray v2ctl
/v2ray/v2ray -config=/v2ray/config.json
