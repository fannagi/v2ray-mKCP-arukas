rm -f /etc/motd
cat >>/etc/motd <<EOF
Alpine Linux Version : $(cat /etc/alpine-release)
Kernel Version : $(uname -r)
Hostname : $(uname -n)
Enjoy your Docker-Linux Node !
EOF

echo "root:${ROOT_PASSWORD}" | chpasswd

sed -i "s/uuid/$UUID/g" /etc/v2ray/config.json
sed -i "s/sspass/$SSPASS/g" /etc/v2ray/config.json

#(/usr/sbin/sshd -D -e \
#	-o PermitRootLogin=yes \
#	-o Port=${SSH_PORT}) &
/usr/sbin/sshd -D -e &
/usr/sbin/caddy -conf /etc/caddy/caddy.conf >/dev/null  2>&1  &
echo "Start sshd & caddy Success !"
cd /tmp
wget -O v2ray.zip http://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip
unzip v2ray.zip "v2ray" -d /usr/bin/v2ray/
unzip v2ray.zip "v2ctl" -d /usr/bin/v2ray/
unzip v2ray.zip "geosite.dat" -d /usr/bin/v2ray/
unzip v2ray.zip "geoip.dat" -d /usr/bin/v2ray/

#if [ ! -f "v2ray" ]; then
#  mv /v2ray/v2ray-v$VER-linux-64/v2ray .
#  mv /v2ray/v2ray-v$VER-linux-64/v2ctl .
#  mv /v2ray/v2ray-v$VER-linux-64/geoip.dat .
#  mv /v2ray/v2ray-v$VER-linux-64/geosite.dat .
#fi
cd /usr/bin/v2ray
#cp -f /config.json .
chmod +x v2ray v2ctl
./v2ray -config=/etc/v2ray/config.json
