# ha-addons

自研 Home Assistant HAOS 插件仓库（个人用）。

## frp-relay

自建 frpc：把本机 HA 经自有公网服务器（frp 服务端，自部署）中转到公网，供远程访问。

- 安装：HA 设置 → 插件 → 插件商店 → 右上角 ⋮ → 仓库 → 添加 `https://github.com/iceCloudZ/ha-addons`
- 配置（插件选项，无密钥入库）：
  - `server_addr`：frps 服务器地址
  - `server_port`：frps 端口（默认 7000）
  - `token`：frps auth.token
  - `remote_port`：frps 侧代理端口（默认 7512，建议绑回环后由 nginx/Caddy 做 TLS 前置）
- 隧道开启 useEncryption + useCompression
- frpc 版本默认 0.71.1，与 frps 对齐（Dockerfile ARG 可改）
