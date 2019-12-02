#!/usr/bin/env bash

# We need to install dependencies only for Docker
[[ ! -e /.dockerenv ]] && exit 0

set -xe
export php_ini=/usr/local/etc/php/php.ini
cp /usr/local/etc/php/php.ini-production $php_ini
sed -i "s/\(memory_limit *= *\).*/\1-1/" $php_ini

# Install git (the php image doesn't have it) which is required by composer
apt-get update -yqq
apt-get install apt-utils -yqq
apt-get install git zip unzip zlib1g-dev libzip-dev wget libxml2-dev libpq-dev openssh-client sudo libxslt1-dev -yqq

mkdir -p ~/.ssh && ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Install composer
curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install fast composer package downloader
composer global require hirak/prestissimo

# Install PCOV code coverage library
pecl install pcov
docker-php-ext-enable pcov

# Install mysql driver
# Here you can install any other extension that you need
docker-php-ext-install pdo_mysql pgsql intl zip xsl sysvsem calendar
