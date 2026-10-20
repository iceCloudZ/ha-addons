#!/bin/sh
set -e
if [ -z "${SERVER_ADDR}" ] || [ -z "${TOKEN}" ]; then
    echo "[frp-relay] 请先在插件配置里填 server_addr / token"
    exit 1
fi
mkdir -p /share
cat > /share/frpc.toml <<CONF
serverAddr = "${SERVER_ADDR}"
serverPort = ${SERVER_PORT}
auth.token = "${TOKEN}"

[[proxies]]
name = "homeassistant"
type = "tcp"
remotePort = ${REMOTE_PORT}

[proxies.transport]
useEncryption = true
useCompression = true
CONF
echo "[frp-relay] connecting to ${SERVER_ADDR}:${SERVER_PORT} ..."
exec /usr/local/bin/frpc -c /share/frpc.toml
