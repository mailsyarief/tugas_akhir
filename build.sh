docker-compose up -d
docker exec c_app composer install
docker exec c_app cp .env.example .env
docker exec c_app php artisan key:generate
docker exec c_app chown -R www-data:www-data /var/www


