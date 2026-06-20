FROM alpine:latest

RUN apk add --no-cache curl unzip \
    && curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && mkdir -p /v2ray \
    && unzip /tmp/v2ray.zip -d /v2ray \
    && rm -rf /tmp/v2ray.zip

WORKDIR /v2ray
COPY config.json /v2ray/config.json

EXPOSE 8080
CMD ["./v2ray", "run", "-config", "/v2ray/config.json"]
