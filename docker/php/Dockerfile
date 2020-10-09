FROM php:7.4-fpm-alpine
ARG TIMEZONE

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& composer --version

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
&& printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini \
&& "date"

# Requirements for symfony
RUN apk add --update $PHPIZE_DEPS icu icu-dev openldap-dev libldap zlib-dev libzip-dev libxml2-dev nodejs nodejs-npm git \
&& docker-php-ext-install pdo_mysql zip intl opcache pdo \
&& pecl install apcu \
&& echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
&& pecl install pecl/apcu_bc-1.0.5 \
&& echo "extension=apc.so" >> /usr/local/etc/php/conf.d/apcu.ini

# Special config for symfony
RUN echo "memory_limit=256M" >> /usr/local/etc/php/conf.d/symfony.ini \
&& echo "realpath_cache_size=4096K" >> /usr/local/etc/php/conf.d/symfony.ini \
&& echo "realpath_cache_ttl=600" >> /usr/local/etc/php/conf.d/symfony.ini \
&& echo "opcache.memory_consumption=256" >> /usr/local/etc/php/conf.d/symfony.ini \
&& echo "opcache.max_accelerated_files=20000" >> /usr/local/etc/php/conf.d/symfony.ini

# Install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | /bin/sh \
&& ln -s /root/.yarn/bin/yarn /usr/local/bin/yarn

# Install GD
RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /var/www/html
