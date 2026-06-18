#!/bin/bash

# Railway ကပေးတဲ့ PORT ကိုယူ
PORT=${PORT:-8080}

# config ထဲ port replace လုပ်ပြီး run
sed -i "s/PORT_PLACEHOLDER/${PORT}/g" /v2ray/config.json

/v2ray/v2ray run -config /v2ray/config.json
