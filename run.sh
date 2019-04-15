# Configure V2Ray

rm -f /etc/motd
cat >>/etc/motd <<EOF
Linux Version : $(cat /etc/redhat-release)
Kernel Version : $(uname -r)
Hostname : $(uname -n)
Enjoy your Docker-Linux Node !
EOF

echo "root:${ROOT_PASSWORD}" | chpasswd

echo "Start Success !"

sed -i "s/uuid/$UUID/g" /v2ray/config.json

cat /etc/v2ray/config.json

(/usr/sbin/sshd -D -e \
	-o PermitRootLogin=yes \
	-o Port=${SSH_PORT}) &

v2ray/v2ray -config=/v2ray/config.json
