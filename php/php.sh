#! /bin/ash

mkdir -p /run/php
rm -rf /etc/php7/php-fpm.d/www.conf
cp /php/www.conf /etc/php7/php-fpm.d/www.conf