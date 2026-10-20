#!/bin/sh
set -e
SERVER_ADDR="${SERVER_ADDR:-${server_addr}}"
SERVER_PORT="${SERVER_PORT:-${server_port:-7000}}"
TOKEN="${TOKEN:-${token}}"
REMOTE_PORT="${REMOTE_PORT:-${remote_port:-7512}}"
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
echo "[frp-relay] connecting to ${SERVER_ADDR}:${SERVER_PORT} remote_port=${REMOTE_PORT}"
exec /usr/local/bin/frpc -c /share/frpc.toml
