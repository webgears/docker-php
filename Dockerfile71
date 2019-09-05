FROM php:7.1

ADD ./scripts /scripts 
ADD ./bin/slack /usr/local/bin
RUN /scripts/php_install.sh
RUN apt-get install jq -yqq
RUN apt-get clean
