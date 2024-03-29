FROM php:7.4.21-fpm-alpine3.13
LABEL maintainer="ppabc <ppabc@qq.com>" version="1.0"
ENV SWOOLE_VERSION=4.7.0 \
    REDIS_VERSION=5.3.3

#Timezone and lib
RUN apk add -U tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata

RUN set -ex \
        && cd /tmp \
        && curl -SL "https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz" -o swoole.tar.gz \
        && curl -SL "http://pecl.php.net/get/redis-${REDIS_VERSION}.tgz" -o redis.tgz \
        && ls -alh \
        && apk update \
        && apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
        # for swoole ext
        && apk add --no-cache libaio \
         linux-headers \
         libaio-dev libzip-dev libxpm-dev oniguruma-dev file gcc g++ libc-dev make autoconf libwebp-dev libtool libzip libpng libstdc++ libpng libpng-dev freetype freetype-dev libjpeg-turbo-dev libmcrypt-dev jpeg jpeg-dev \
         hiredis-dev imagemagick imagemagick-dev  \
         openssl-dev \
         libstdc++ \
         librdkafka-dev \
        # php extension: redis
        && pecl install redis.tgz \
        && docker-php-ext-enable redis \
        # php extension: pdo_mysql
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install ctype json mbstring zip opcache \
        && docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg --with-xpm --with-freetype --enable-gd-jis-conv \
        && docker-php-ext-install  gd   \
        && docker-php-ext-install mysqli \
        # php extension: bcmath
        && docker-php-ext-install bcmath \
        # php extension: swoole
        && cd /tmp \
        && mkdir -p swoole \
        && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
        && rm swoole.tar.gz \
                && ( \
                    cd swoole \
                    && phpize \
                    && ./configure --enable-async-redis --enable-mysqlnd --enable-coroutine --enable-openssl \
                    && make -j$(nproc) && make install \
                ) \
                && rm -r swoole \
                && docker-php-ext-enable swoole \
        && apk del .phpize-deps
ADD php-fpm-7.4.21a/install /install
RUN /bin/cp /install/so/*.so  /usr/local/lib/php/extensions/no-debug-non-zts-20190902/  && \
    /bin/cp /install/php.ini  /usr/local/etc/php/php.ini  && \
    /bin/cp /install/php-fpm.conf  /usr/local/etc/php-fpm.conf  && \
    /bin/cp /install/www.conf  /usr/local/etc/php-fpm.d/www.conf  && \
    /bin/cp /install/00_loader.ini  /usr/local/etc/php/conf.d/00_loader.ini && \
    rm -rf /install  && \
    echo "Asia/Shanghai" > /etc/timezone
