#!/bin/sh
set -e
# HA 插件标准通道：/data/options.json（基础镜像自带 jq）；env 仅作本地调试兜底
CONFIG=/data/options.json
if [ -f "$CONFIG" ]; then
    SERVER_ADDR=$(jq -r '.server_addr // empty' "$CONFIG")
    SERVER_PORT=$(jq -r '.server_port // 7000' "$CONFIG")
    TOKEN=$(jq -r '.token // empty' "$CONFIG")
    REMOTE_PORT=$(jq -r '.remote_port // 7512' "$CONFIG")
fi
SERVER_ADDR="${SERVER_ADDR:-${server_addr}}"
SERVER_PORT="${SERVER_PORT:-${server_port:-7000}}"
TOKEN="${TOKEN:-${token}}"
REMOTE_PORT="${REMOTE_PORT:-${remote_port:-7512}}"
if [ -z "${SERVER_ADDR}" ] || [ -z "${TOKEN}" ]; then
    echo "[frp-relay] 请先在插件配置里填 server_addr / token"
    exit 1
fi
mkdir -p /data
cat > /data/frpc.toml <<CONF
serverAddr = "${SERVER_ADDR}"
serverPort = ${SERVER_PORT}
auth.token = "${TOKEN}"

[[proxies]]
name = "homeassistant"
type = "tcp"
localIP = "homeassistant"
localPort = 80
remotePort = ${REMOTE_PORT}

[proxies.transport]
useEncryption = true
useCompression = true
CONF
echo "[frp-relay] connecting to ${SERVER_ADDR}:${SERVER_PORT} remote_port=${REMOTE_PORT}"
exec /usr/local/bin/frpc -c /data/frpc.toml
