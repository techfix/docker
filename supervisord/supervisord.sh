#! /bin/ash

mkdir -p /etc/supervisor.d

mv /supervisord/supervisord.ini /etc/supervisor.d/supervisord.ini
mv /supervisord/nginx.conf /etc/supervisor.d/nginx.conf
mv /supervisord/php.conf /etc/supervisor.d/php.conf