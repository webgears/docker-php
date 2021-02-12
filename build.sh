#!/bin/bash

set -e

SKIP_BUILD=0
DEPLOY=0

while getopts "sph" opt; do
    case $opt in
    h)
        echo "Usage:"
        echo "    -h        Display this help message."
        echo "    -p        Pushes the containers"
        echo "    -s        Skip the build"
        exit 0
        ;;
    p)
        DEPLOY=1
        ;;
    s)
        SKIP_BUILD=1
        ;;
    \?)
        echo "Invalid Option: -$OPTARG" 1>&2
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

if ((!SKIP_BUILD)); then
#    docker build . -f Dockerfile72 -t wbgrs/php:7.2
    docker build . -f Dockerfile74 -t wbgrs/php:7.4
#    docker build . -f Dockerfile72-node -t wbgrs/php:7.2-node
#    docker build . -f Dockerfile74-node -t wbgrs/php:7.4-node
#    docker build . -f Dockerfile72-phpqa -t wbgrs/php:7.2-phpqa
#    docker build . -f Dockerfile74-phpqa -t wbgrs/php:7.4-phpqa
#    docker build . -f Dockerfile72-node-fpm -t wbgrs/php:7.2-node-fpm
#    docker build . -f Dockerfile74-node-fpm -t wbgrs/php:7.4-node-fpm
#    docker build . -f Dockerfile72-node-apache -t wbgrs/php:7.2-node-apache
#    docker build . -f Dockerfile74-node-apache -t wbgrs/php:7.4-node-apache
#    docker build . -f Dockerfile72-python -t wbgrs/php:7.2-python
#    docker build . -f Dockerfile74-python -t wbgrs/php:7.4-python
#    docker build . -f Dockerfile72-eb -t wbgrs/php:7.2-eb
#    docker build . -f Dockerfile74-eb -t wbgrs/php:7.4-eb
    docker build . -f Dockerfile74-node14 -t wbgrs/php:7.4-node14
    docker build . -f Dockerfile74-node14-fpm -t wbgrs/php:7.4-node14-fpm
    docker build . -f Dockerfile74-node14-phpqa -t wbgrs/php:7.4-node14-phpqa
fi

if ((DEPLOY)); then
    docker push wbgrs/php:7.2
    docker push wbgrs/php:7.4
    docker push wbgrs/php:7.2-node
    docker push wbgrs/php:7.4-node
    docker push wbgrs/php:7.2-phpqa
    docker push wbgrs/php:7.4-phpqa
    docker push wbgrs/php:7.2-node-fpm
    docker push wbgrs/php:7.4-node-fpm
    docker push wbgrs/php:7.2-node-apache
    docker push wbgrs/php:7.4-node-apache
    docker push wbgrs/php:7.2-python
    docker push wbgrs/php:7.4-python
    docker push wbgrs/php:7.2-eb
    docker push wbgrs/php:7.4-eb
    docker push wbgrs/php:7.4-node14
    docker push wbgrs/php:7.4-node14-fpm
    docker push wbgrs/php:7.4-node14-phpqa
fi
