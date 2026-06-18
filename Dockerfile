FROM alpine:latest

RUN apk add --no-cache curl unzip bash

# install v2ray
RUN curl -L -o v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && unzip v2ray.zip -d /v2ray \
    && chmod +x /v2ray/v2ray

WORKDIR /v2ray

COPY config.json /v2ray/config.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PORT=8080

CMD ["/entrypoint.sh"]
