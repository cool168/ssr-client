FROM alpine:3.5

MAINTAINER shadou <shadou@erhuo.two>

WORKDIR /root

ENV TZ 'Asia/Shanghai'

ENV SSR_VERSION 3.0.1

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata python py-setuptools wget libsodium \
    && wget --no-check-certificate https://github.com/shadowsocksr/shadowsocksr/archive/$SSR_VERSION.tar.gz \
    && tar -zxvf $SSR_VERSION.tar.gz \
    && (cd /root/shadowsocksr-$SSR_VERSION && python setup.py install)  \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del wget \
    && rm -f $SSR_VERSION.tar.gz \
    && rm -rf shadowsocksr-$SSR_VERSION \
    rm -rf /var/cache/apk/*

EXPOSE 80 1081

CMD sslocal -s ${SERVER_ADDR:-0.0.0.0} \
            -p ${SERVER_PORT:-80\
            -k ${PASSWORD:-$(hostname)} \
            -m ${METHOD:-chacha20} \
	        -O ${PROTOCOL:-origin} \
            -o ${OBFS:-plain} \
            -t ${TIMEOUT:-300} \
            -d ${DNS_ADDR:-8.8.8.8} \
            --fast-open
