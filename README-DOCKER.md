## Build Tileserver v2.0 + Apache Docker Image

# Reference

`https://github.com/docker-library/docs/blob/master/php/variant-apache.md`
`https://hub.docker.com/_/php`
`https://github.com/mlocati/docker-php-extension-installer`

# Apache with Dockerfile

`FROM php:8.2.7-apache
COPY . /var/www/html/`

# Build the image

`docker build -t tileserver-php:2.0 .`
`docker run -d --name tileserver-app tileserver-php:2.0`
`docker run -d -p 80:80 -v "${PWD}":/var/www/html/data --name tileserver-php tileserver-php:2.0`

where `${PWD}` is the data tiles directory

# Use the default production configuration

`RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"`
