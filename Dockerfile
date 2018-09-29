FROM alpine:3.8

ENV CRON false
ENV WORKER false

RUN apk add --no-cache \
    curl \
    wget \
    git \
    nano \
    supervisor \
    nodejs \
    nodejs-npm \
    nginx \
    $( \
        apk search -qe --no-cache 'php7*' \
            | sed -e 's/[^ ]*apache[^ ]*//ig' \
            | sed -e 's/[^ ]*dev[^ ]*//ig' \
            | sed -e 's/[^ ]*pear[^ ]*//ig' \
            | sed -e 's/[^ ]*xdebug[^ ]*//ig' \
            | sed -e 's/[^ ]*doc[^ ]*//ig' \
            | sed -e 's/[^ ]*mustache[^ ]*//ig' \
            | sed -e 's/[^ ]*kafka[^ ]*//ig' \
            | sed -e 's/[^ ]*solr[^ ]*//ig' \
            | sed -e 's/[^ ]*protobuf[^ ]*//ig' \
            | sed -e 's/[^ ]*couchbase[^ ]*//ig' \
            | sed -e 's/[^ ]*mongo[^ ]*//ig' \
            | sed -e 's/[^ ]*pgsql[^ ]*//ig' \
            | cat \
    ) \
    composer \
    libpng-dev \
    nasm \
    autoconf \
    optipng \
    gifsicle \
    make \
    automake \
    g++ \
    libtool

ADD init.sh /init.sh
ADD ./supervisord /supervisord
ADD ./nginx /nginx
ADD ./php /php

RUN chmod 755 /init.sh && \
    chmod 755 /nginx/nginx.sh && \
    chmod 755 /php/php.sh && \
    chmod 755 /supervisord/supervisord.sh

RUN /nginx/nginx.sh
RUN /php/php.sh 
RUN /supervisord/supervisord.sh

EXPOSE 80 443 9000
WORKDIR /var/www/html

CMD [ "/init.sh" ]