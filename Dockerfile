FROM alpine:3.5

ARG VER=2.20.2

RUN adduser -D -G root v2ray \
    mkdir -p /v2ray \
    && chown wangyi2005:root /opt/v2ray \
    && apk add --no-cache --virtual .build-deps ca-certificates curl \
    && cd /opt/v2ray \
    && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
    && unzip v2ray.zip \
    && mv /opt/v2ray/v2ray-v$VER-linux-64/v2ray /opt/v2ray/ \
    && rm -rf v2ray.zip \
    && rm -rf v2ray-v$VER-linux-64 \
    && apk del .build-deps 
   
ENV CONFIG_JSON=none V2RAY_CRT=none V2RAY_KEY=none

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER wangyi2005

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
