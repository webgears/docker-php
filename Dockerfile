FROM php:7.0

ADD ./scripts /scripts 
RUN /scripts/php_install.sh
