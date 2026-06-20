# ----- Stage 1: V2Ray Build -----
FROM alpine:latest AS v2ray-builder
RUN apk add --no-cache curl unzip
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && mkdir -p /v2ray \
    && unzip /tmp/v2ray.zip -d /v2ray

# ----- Stage 2: Final Image with Caddy -----
FROM caddy:latest

ENV XDG_CONFIG_HOME=/tmp/caddy_config
ENV XDG_DATA_HOME=/tmp/caddy_data

COPY --from=v2ray-builder /v2ray /v2ray
COPY config.json /v2ray/config.json
COPY Caddyfile /etc/caddy/Caddyfile

# V2Ray ကို နောက်ကွယ်မှာ အရင်မောင်းပြီး Caddy ကို အရှေ့ကနေ တိုက်ရိုက်မောင်းခြင်း
CMD /v2ray/v2ray run -config /v2ray/config.json & caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

EXPOSE 8080
