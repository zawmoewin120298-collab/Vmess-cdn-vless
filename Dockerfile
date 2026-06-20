FROM alpine:latest
RUN apk add --no-cache curl unzip

# V2Ray core အား ရယူခြင်း
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && mkdir -p /v2ray \
    && unzip /tmp/v2ray.zip -d /v2ray

COPY config.json /v2ray/config.json

# Railway အား Port 8080 သို့ တိုက်ရိုက် မျက်နှာမူခိုင်းခြင်း
EXPOSE 8080
CMD ["/v2ray/v2ray", "run", "-config", "/v2ray/config.json"]
