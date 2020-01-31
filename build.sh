#!/bin/sh
docker build -t maloneweb/docker-php-development:latest generated/latest &
docker build -t maloneweb/docker-php-development:7.4 generated/7.4 &
docker build -t maloneweb/docker-php-development:7.3 generated/7.3 &
docker build -t maloneweb/docker-php-development:7.2 generated/7.2 &
docker build -t maloneweb/docker-php-development:7.1 generated/7.1 &
docker build -t maloneweb/docker-php-development:7.0 generated/7.0 &
wait
