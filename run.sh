# Configure V2Ray
echo -e '{"log":{"loglevel":"none"},"inbounds":[{"port":9999,"protocol":"vmess","settings":{"clients":[{"id":"uuid","alterId":64}]},"streamSettings":{"network":"kcp","kcpSettings":{"mtu":1350,"tti":100,"uplinkCapacity":10,"downlinkCapacity":50,"congestion":false,"readBufferSize":2,"writeBufferSize":2,"header":{"type":"wechat-video"}}}},{"port":9999,"protocol":"vmess","settings":{"clients":[{"id":"uuid","alterId":64}]}}],"outbounds":[{"protocol":"freedom","settings":{}}]}' > /v2ray/config.json
sed -i "s/uuid/$UUID/g" /v2ray/config.json
# Run V2Ray
/v2ray/v2ray -config=/v2ray/config.json
