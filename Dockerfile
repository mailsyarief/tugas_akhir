FROM php:7.2-fpm

WORKDIR /var/www
COPY /code /var/www

RUN apt-get update && \
    apt-get install -y \
    git \
    zip \
    curl

RUN docker-php-ext-install pdo_mysql mbstring

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

RUN chown -R www-data:www-data /var/www

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN composer install
COPY /build/.env /var/www
RUN php artisan key:generate
RUN chown -R www-data:www-data /var/www

EXPOSE 9000
CMD ["php-fpm"]