FROM php:7.2-fpm

WORKDIR /var/www

RUN apt-get update && \
    apt-get install -y \
    git \
    zip \
    curl

RUN docker-php-ext-install pdo_mysql mbstring

# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
#     && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
#     && php composer-setup.php \
#     && php -r "unlink('composer-setup.php');" \
#     && php composer.phar install --no-dev --no-scripts \
#     && rm composer.phar

RUN curl -sS https://getcomposer.org/installer | php \
    mv composer.phar /usr/local/bin/composer \
    chmod +x /usr/local/bin/composer

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

RUN chown -R www-data:www-data \
    /var/www/storage \
    /var/www/bootstrap/cache

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 9000
CMD ["php-fpm"]