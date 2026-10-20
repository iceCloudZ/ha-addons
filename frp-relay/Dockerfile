FROM ghcr.io/home-assistant/amd64-base:3.19
ARG FRPC_VERSION=0.71.1
ARG FRP_MIRROR=http://101.34.219.188:1789/static
RUN apk add --no-cache curl ca-certificates     && curl -fsSL -o /tmp/frp.tar.gz ${FRP_MIRROR}/frp_${FRPC_VERSION}_linux_amd64.tar.gz     && echo "1d9875210972a5d1a62b2dc4c48df45ab0af05d3ca1b5e494a014428259df803  /tmp/frp.tar.gz" | sha256sum -c -     && tar -xzf /tmp/frp.tar.gz -C /tmp     && mv /tmp/frp_${FRPC_VERSION}_linux_amd64/frpc /usr/local/bin/frpc     && chmod 755 /usr/local/bin/frpc     && rm -rf /tmp/frp*
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
