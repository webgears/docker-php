#!/bin/bash

curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt-get install nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -yqq gnupg
apt-get install -yqq yarn

apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
