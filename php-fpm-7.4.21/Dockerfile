FROM php:7.4.21-fpm-alpine3.14

LABEL Maintainer="Jose Quintana <git.io/joseluisq>" \
    Description="PHP-FPM v7.4 with essential extensions on top of Alpine Linux."

# Composer - https://getcomposer.org/download/
ARG COMPOSER_VERSION="2.1.3"
ARG COMPOSER_SUM="f8a72e98dec8da736d8dac66761ca0a8fbde913753e9a43f34112367f5174d11"

# Swoole - https://github.com/swoole/swoole-src
ARG SWOOLE_VERSION="4.6.7"

# Install dependencies
RUN set -eux \
    && apk add --no-cache \
        ca-certificates \
        freetds \
        freetype \
        gettext \
        gmp \
        icu-libs \
        imagemagick \
        libffi \
        libgmpxx \
        libintl \
        libjpeg-turbo \
        libmcrypt \
        libpng \
        libpq \
        libssh2 \
        libstdc++ \
        libtool \
        libxpm \
        libxslt \
        libzip \
        make \
        rabbitmq-c \
        tidyhtml \
        tzdata \
        vips \
        yaml

#############################################
### Install and enable PHP extensions
#############################################

# Development dependencies
RUN set -eux \
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        cmake \
        curl-dev \
        freetds-dev \
        freetype-dev \
        gcc \
        gettext-dev \
        git \
        gmp-dev \
        icu-dev \
        imagemagick-dev \
        libc-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libssh2-dev \
        libwebp-dev \
        libxml2-dev \
        libxpm-dev \
        libxslt-dev \
        libzip-dev \
        linux-headers \
        openssl-dev \
        pcre-dev \
        pkgconf \
        postgresql-dev \
        rabbitmq-c-dev \
        tidyhtml-dev \
        vips-dev \
        yaml-dev \
        zlib-dev \
\
# Workaround for rabbitmq linking issue
    && ln -s /usr/lib /usr/local/lib64 \
# Enable ffi if it exists
    && set -eux \
        && if [ -f /usr/local/etc/php/conf.d/docker-php-ext-ffi.ini ]; then \
            echo "ffi.enable = 1" >> /usr/local/etc/php/conf.d/docker-php-ext-ffi.ini; \
        fi \
\
################################
# Install PHP extensions
################################
\
# Install gd
    && ln -s /usr/lib/x86_64-linux-gnu/libXpm.* /usr/lib/ \
    && docker-php-ext-configure gd \
        --enable-gd \
        --with-webp \
        --with-jpeg \
        --with-xpm \
        --with-freetype \
        --enable-gd-jis-conv \
    && docker-php-ext-install -j$(nproc) gd \
    && true \
\
# Install amqp
    && echo "/usr" | pecl install amqp \
    && docker-php-ext-enable amqp \
    && true \
\
# Install gettext
    && docker-php-ext-install -j$(nproc) gettext \
    && true \
\
# Install gmp
    && docker-php-ext-install -j$(nproc) gmp \
    && true \
\
# Install bcmath
    && docker-php-ext-install -j$(nproc) bcmath \
    && true \
\
# Install exif
    && docker-php-ext-install -j$(nproc) exif \
    && true \
\
# Install imagick
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && true \
\
# Install intl
    && docker-php-ext-install -j$(nproc) intl \
    && true \
\
# Install mcrypt
    && pecl install mcrypt \
    && docker-php-ext-enable mcrypt \
    && true \
\
# Install xmlrpc
    && docker-php-ext-configure xmlrpc --with-iconv-dir=/usr \
    && docker-php-ext-install -j$(nproc) xmlrpc \
    && true \
\
# Install memcache
    && pecl install memcache-4.0.5.2 \
    && docker-php-ext-enable memcache \
    && true \
\
# Install mysqli
    && docker-php-ext-install -j$(nproc) mysqli \
    && true \
\
# Install oauth
    && pecl install oauth \
    && docker-php-ext-enable oauth \
    && true \
\
# Install pdo_mysql
    && docker-php-ext-configure pdo_mysql --with-zlib-dir=/usr \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && true \
\
# Install pdo_dblib
    && docker-php-ext-install -j$(nproc) pdo_dblib \
    && true \
\
# Install pcntl
    && docker-php-ext-install -j$(nproc) pcntl \
    && true \
\
# Install pdo_pgsql
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && true \
\
# Install pgsql
    && docker-php-ext-install -j$(nproc) pgsql \
    && true \
\
# Install psr
    && pecl install psr \
    && docker-php-ext-enable psr \
    && true \
\
# Install soap
    && docker-php-ext-install -j$(nproc) soap \
    && true \
\
# Install ssh2
    && pecl install ssh2-1.2 \
    && docker-php-ext-enable ssh2 \
    && true \
\
# Install sockets, sysvmsg, sysvsem, sysvshm (also needed by swoole)
    && docker-php-ext-install -j$(nproc) \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
    && docker-php-source extract \
    && true \
\
# Install swoole
    && mkdir /usr/src/php/ext/swoole \
    && curl -Lo swoole.tar.gz https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz \
    && tar xfz swoole.tar.gz --strip-components=1 -C /usr/src/php/ext/swoole \
    && docker-php-ext-configure swoole \
            --enable-mysqlnd \
            --enable-sockets \
            --enable-openssl \
            --enable-http2 \
            --enable-swoole-json \
            --enable-swoole-curl \
    && docker-php-ext-install -j$(nproc) swoole \
    && rm -rf swoole.tar.gz $HOME/.composer/*-old.phar \
    && docker-php-ext-enable swoole \
    && true \
\
# Install tidy
    && docker-php-ext-install -j$(nproc) tidy \
    && true \
\
# Install xsl
    && docker-php-ext-install -j$(nproc) xsl \
    && true \
\
# Install yaml
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && true \
\
# Install vips
    && pecl install vips \
    && docker-php-ext-enable vips \
    && true \
\
# Install zip
    && docker-php-ext-configure zip --with-zip \
    && docker-php-ext-install -j$(nproc) zip \
    && true \
\
# Clean up build packages
    && docker-php-source delete \
    && apk del .build-deps \
    && true

# Install Composer
RUN set -eux \
    && curl -LO "https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar" \
    && echo "${COMPOSER_SUM}  composer.phar" | sha256sum -c - \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && composer --version \
    && true

RUN set -eux \
# Fix php.ini settings for enabled extensions
    && chmod +x "$(php -r 'echo ini_get("extension_dir");')"/* \
# Shrink binaries
    && (find /usr/local/bin -type f -print0 | xargs -n1 -0 strip --strip-all -p 2>/dev/null || true) \
    && (find /usr/local/lib -type f -print0 | xargs -n1 -0 strip --strip-all -p 2>/dev/null || true) \
    && (find /usr/local/sbin -type f -print0 | xargs -n1 -0 strip --strip-all -p 2>/dev/null || true) \
    && true

# Copy PHP-FPM configuration files
COPY php-fpm.tmpl.conf /var/data/php-fpm/php-fpm.tmpl.conf
COPY www.tmpl.conf /var/data/php-fpm/www.tmpl.conf
COPY php.tmpl.ini /var/data/php-fpm/default-php.tmpl.ini

RUN set -eux \
# PHP-FPM templates directory
    && mkdir -p /var/data/php-fpm \
# Remove few PHP-FPM default config files
    && rm -rf /usr/local/etc/php-fpm.d/zz-docker.conf \
    && rm -rf /usr/local/etc/php-fpm.d/docker.conf \
\
# Perform PHP-FPM testing
    && echo "date.timezone=UTC" > /usr/local/etc/php/php.ini \
    && php -v | grep -oE 'PHP\s[.0-9]+' | grep -oE '[.0-9]+' | grep '^7.4' \
    && /usr/local/sbin/php-fpm --test \
\
    && PHP_ERROR="$( php -v 2>&1 1>/dev/null )" \
    && if [ -n "${PHP_ERROR}" ]; then echo "${PHP_ERROR}"; false; fi \
    && PHP_ERROR="$( php -i 2>&1 1>/dev/null )" \
    && if [ -n "${PHP_ERROR}" ]; then echo "${PHP_ERROR}"; false; fi \
\
    && PHP_FPM_ERROR="$( php-fpm -v 2>&1 1>/dev/null )" \
    && if [ -n "${PHP_FPM_ERROR}" ]; then echo "${PHP_FPM_ERROR}"; false; fi \
    && PHP_FPM_ERROR="$( php-fpm -i 2>&1 1>/dev/null )" \
    && if [ -n "${PHP_FPM_ERROR}" ]; then echo "${PHP_FPM_ERROR}"; false; fi \
    && rm -f /usr/local/etc/php/php.ini \
    && true

# Copy util scripts
COPY envsubst.sh /envsubst.sh
COPY entrypoint.sh /entrypoint.sh

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]


# Metadata
LABEL org.opencontainers.image.vendor="Jose Quintana" \
    org.opencontainers.image.url="https://github.com/joseluisq/alpine-php-fpm" \
    org.opencontainers.image.title="PHP-FPM v7.4 Alpine" \
    org.opencontainers.image.description="PHP-FPM v7.4 with essential extensions on top of Alpine Linux." \
    org.opencontainers.image.version="$PHP_VERSION" \
    org.opencontainers.image.documentation="https://github.com/joseluisq/alpine-php-fpm"
