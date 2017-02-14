FROM alpine:3.5

MAINTAINER shadou <shadou@erhuo.two>

WORKDIR /root

ENV SSR_VERSION 3.0.1

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata python py-setuptools wget libsodium \
    && wget --no-check-certificate https://github.com/shadowsocksr/shadowsocksr/archive/$SSR_VERSION.tar.gz \
    && tar -zxvf $SSR_VERSION.tar.gz \
    && (cd /root/shadowsocks-$SS_VERSION && python setup.py install) \
    && apk del wget \
    && rm -f $SSR_VERSION.tar.gz \
    && rm -rf shadowsocksr-$SSR_VERSION \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /root/entrypoint.sh

ADD config.json /etc/config.json

ENTRYPOINT ["/root/entrypoint.sh"]