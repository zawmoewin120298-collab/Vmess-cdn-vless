FROM alpine:latest
RUN apk add --no-cache curl unzip

# V2Ray core ကို နောက်ဆုံးဗားရှင်း တိုက်ရိုက်ဒေါင်းလုဒ်ဆွဲခြင်း
RUN curl -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && mkdir -p /v2ray \
    && unzip /tmp/v2ray.zip -d /v2ray

# အစ်ကိုကြီးရဲ့ config.json ကို စက်ထဲသို့ ထည့်သွင်းခြင်း
COPY config.json /v2ray/config.json

# Railway အတွက် မူရင်း Port 8080 ကို တိုက်ရိုက်သတ်မှတ်ခြင်း
EXPOSE 8080

# V2Ray ကို တိုက်ရိုက် စတင်မောင်းနှင်ခြင်း
CMD ["/v2ray/v2ray", "run", "-config", "/v2ray/config.json"]

