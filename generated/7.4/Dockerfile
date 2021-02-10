# This is an auto-generated file, do not edit.
# See <root>/Dockerfile.template
FROM php:7.4

LABEL description="PHP configured for a development environment" \
      maintainer="Malone Tuning <web@malonetuning.com>"

RUN apt-get update && apt-get install -y \
  git \
  libcurl4-gnutls-dev \
  libicu-dev \
  libvpx-dev \
  libjpeg-dev \
  libpng-dev \
  libxpm-dev \
  zlib1g-dev \
  libfreetype6-dev \
  libxml2-dev \
  libexpat1-dev \
  libbz2-dev \
  libgmp3-dev \
  libldap2-dev \
  unixodbc-dev \
  libpq-dev \
  libsqlite3-dev \
  libaspell-dev \
  libsnmp-dev \
  libpcre3-dev \
  libtidy-dev \
  libzip-dev \
  openssh-client \
  unzip

# Install PHP Extensions
# pdo_mysql, intl, zip, opcache, and xdebug
RUN docker-php-ext-install \
  pdo_mysql \
  pdo_pgsql \
  intl \
  gd \
  zip \
  bz2 \
  pcntl \
  opcache \
&& pecl install \
  xdebug \
  redis \
&& docker-php-ext-enable xdebug \
&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# Memory Limit
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Install wait-for-it
COPY ./wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
