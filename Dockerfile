FROM php:8.2.7-apache

# Install extensions
RUN curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - | sh -s gd

# Set the default document root
ENV APACHE_DOCUMENT_ROOT /var/www/html

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html

# Copy php web app
COPY tileserver.php /var/www/html/
COPY .htaccess /var/www/html/

# Use the default php production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf && \
    a2enconf servername && a2enmod rewrite

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# create tiles directory - to be used with data volume
RUN mkdir /var/www/html/data
