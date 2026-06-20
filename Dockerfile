FROM alpine:latest
RUN apk add --no-cache curl unzip

# V2Ray တင်သွင်းခြင်း
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && mkdir -p /v2ray \
    && unzip /tmp/v2ray.zip -d /v2ray

COPY config.json /v2ray/config.json

# Port 8080 ကို တိုက်ရိုက် သတ်မှတ်မောင်းနှင်ခြင်း
EXPOSE 8080
CMD ["/v2ray/v2ray", "run", "-config", "/v2ray/config.json"]

