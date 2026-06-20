# ----- Stage 1: V2Ray Download -----
FROM alpine:latest AS v2ray-builder
RUN apk add --no-cache curl unzip
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && mkdir -p /v2ray \
    && unzip /tmp/v2ray.zip -d /v2ray

# ----- Stage 2: Final Image with Caddy -----
FROM caddy:latest

# Cache ဟောင်းများ ကတ်တွယ်နေခြင်းမှ ကာကွယ်ရန် Caddy ၏ ဖွဲ့စည်းပုံလမ်းကြောင်းကို နေရာအသစ်သို့ ပြောင်းလဲပစ်ခြင်း
ENV XDG_CONFIG_HOME=/tmp/caddy_config
ENV XDG_DATA_HOME=/tmp/caddy_data

# V2Ray ဖိုင်များကို Caddy Image ထဲသို့ ကူးထည့်ခြင်း
COPY --from=v2ray-builder /v2ray /v2ray

# Configuration ဖိုင်များ ထည့်သွင်းခြင်း
COPY config.json /v2ray/config.json
COPY Caddyfile /etc/caddy/Caddyfile

# Script ထဲတွင် အမိန့်ဟောင်းများအားလုံးကို ကျော်လွန်၍ Caddyfile အသစ်အတိုင်းသာ သန့်သန့်ရှင်းရှင်း မောင်းနှင်ခိုင်းခြင်း
RUN echo '#!/bin/sh' > /entrypoint.sh \
    && echo '/v2ray/v2ray run -config /v2ray/config.json &' >> /entrypoint.sh \
    && echo 'caddy run --config /etc/caddy/Caddyfile --adapter caddyfile' >> /entrypoint.sh \
    && chmod +x /entrypoint.sh

EXPOSE 80 443 8080

ENTRYPOINT ["/entrypoint.sh"]

