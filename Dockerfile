FROM alpine:latest

# လိုအပ်သော package များတင်ခြင်း
RUN apk add --no-cache ca-certificates curl unzip

# Xray core ကို download လုပ်ခြင်း
RUN wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/ && \
    chmod +x /usr/bin/xray && \
    rm /tmp/xray.zip

# Cloudflared ကို download လုပ်ခြင်း
RUN wget -O /usr/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/bin/cloudflared

# Folder များဆောက်ပြီး Permission ပေးခြင်း
RUN mkdir -p /etc/xray && chmod 777 /etc/xray

COPY config.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Port 3000 ကို ဖွင့်ပေးခြင်း (Hugging Face အတွက်)
EXPOSE 3000

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
