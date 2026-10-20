ARG FRPC_VERSION=0.71.1
FROM ghcr.io/home-assistant/amd64-base:3.19
ARG FRPC_VERSION
RUN apk add --no-cache curl ca-certificates \
    && curl -fsSL -o /tmp/frp.tar.gz \
       https://github.com/fatedier/frp/releases/download/v${FRPC_VERSION}/frp_${FRPC_VERSION}_linux_amd64.tar.gz \
    && tar -xzf /tmp/frp.tar.gz -C /tmp \
    && mv /tmp/frp_${FRPC_VERSION}_linux_amd64/frpc /usr/local/bin/frpc \
    && chmod 755 /usr/local/bin/frpc \
    && rm -rf /tmp/frp*
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
