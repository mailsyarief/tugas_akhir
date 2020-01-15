docker-compose up -d
docker exec c_app composer install
docker exec c_app cp .env.example .env
docker exec c_app php artisan key:generate


