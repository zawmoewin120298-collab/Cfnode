FROM alpine:latest

# Install Xray and Cloudflared
RUN apk add --no-cache ca-certificates curl
RUN wget -O /usr/bin/xray https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /usr/bin/xray -d /usr/bin/ && chmod +x /usr/bin/xray
RUN wget -O /usr/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/bin/cloudflared

COPY config.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

