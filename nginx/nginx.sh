#! /bin/ash

mkdir -p /run/nginx
chown -R nginx:nginx /var/log/php7
rm -rf /etc/nginx/nginx.conf
mv /nginx/nginx.conf /etc/nginx/nginx.conf
rm -rf /etc/nginx/conf.d/default.conf
mv /nginx/laravel.conf /etc/nginx/conf.d/laravel.conf