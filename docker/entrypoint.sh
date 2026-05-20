#!/bin/bash
set -e

cd /var/www/html

mkdir -p storage/logs
mkdir -p bootstrap/cache

touch storage/logs/laravel.log

chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

composer install --no-interaction --prefer-dist

npm install
npm run build

php artisan optimize:clear
php artisan config:clear
php artisan cache:clear

php artisan storage:link || true

exec "$@"