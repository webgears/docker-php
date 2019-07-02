#!/usr/bin/env bash

# We need to install dependencies only for Docker
[[ ! -e /.dockerenv ]] && exit 0

set -xe

# Install git (the php image doesn't have it) which is required by composer
apt-get update -yqq
apt-get install apt-utils -yqq
apt-get install git zip unzip zlib1g-dev libzip-dev wget libxml2-dev libpq-dev  -yqq

# Install composer
curl --silent --show-error https://getcomposer.org/installer | php

# Install mysql driver
# Here you can install any other extension that you need
docker-php-ext-install pdo_mysql pgsql intl zip
