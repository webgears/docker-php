#!/usr/bin/env bash

# We need to install dependencies only for Docker
[[ ! -e /.dockerenv ]] && exit 0

set -xe
export php_ini=/usr/local/etc/php/php.ini
cp /usr/local/etc/php/php.ini-production $php_ini
sed -i "s/\(memory_limit *= *\).*/\1-1/" $php_ini

# Install git (the php image doesn't have it) which is required by composer
apt-get update
apt-get install apt-utils -yqq
apt-get install git zip unzip zlib1g-dev libzip-dev wget libxml2-dev libpq-dev openssh-client sudo libxslt1-dev libpng-dev libjpeg-dev libwebp-dev -yqq

# Install autoconf and libtool to make sure javascript dependencies can compile
apt install autoconf libtool -yqq

mkdir -p ~/.ssh && ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Install composer
wget -cO - https://getcomposer.org/composer-stable.phar > /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# Install PCOV code coverage library
pecl install pcov
docker-php-ext-enable pcov

docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-webp=/usr/include

docker-php-ext-install pdo_mysql pgsql intl zip xsl sysvsem calendar gd

# Install Deployer (https://deployer.org/)
curl -LO https://deployer.org/deployer.phar
mv deployer.phar /usr/local/bin/dep
chmod +x /usr/local/bin/dep
