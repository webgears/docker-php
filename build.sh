#!/bin/bash

docker build . -f Dockerfile70 -t wbgrs/php:7.0
docker build . -f Dockerfile71 -t wbgrs/php:7.1
docker build . -f Dockerfile72 -t wbgrs/php:7.2
docker build . -f Dockerfile74 -t wbgrs/php:7.4
docker build . -f Dockerfile70-node -t wbgrs/php:7.0-node
docker build . -f Dockerfile71-node -t wbgrs/php:7.1-node
docker build . -f Dockerfile72-node -t wbgrs/php:7.2-node
docker build . -f Dockerfile72-eb -t wbgrs/php:7.2-eb
docker build . -f Dockerfile74-node -t wbgrs/php:7.4-node
docker build . -f Dockerfile72-phpqa -t wbgrs/php:7.2-phpqa
docker build . -f Dockerfile74-phpqa -t wbgrs/php:7.4-phpqa
docker build . -f Dockerfile72-node-fpm -t wbgrs/php:7.2-node-fpm
docker build . -f Dockerfile74-node-fpm -t wbgrs/php:7.4-node-fpm
docker build . -f Dockerfile72-node-apache -t wbgrs/php:7.2-node-apache
docker build . -f Dockerfile74-node-apache -t wbgrs/php:7.4-node-apache

docker push wbgrs/php:7.0
docker push wbgrs/php:7.1
docker push wbgrs/php:7.2
docker push wbgrs/php:7.4
docker push wbgrs/php:7.0-node
docker push wbgrs/php:7.1-node
docker push wbgrs/php:7.2-node
docker push wbgrs/php:7.2-eb
docker push wbgrs/php:7.4-node
docker push wbgrs/php:7.2-phpqa
docker push wbgrs/php:7.4-phpqa
docker push wbgrs/php:7.2-node-fpm
docker push wbgrs/php:7.4-node-fpm
docker push wbgrs/php:7.2-node-apache
docker push wbgrs/php:7.4-node-apache
