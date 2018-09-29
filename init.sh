#! /bin/ash

for envvar in $(env) ; do
    echo $envvar | tee -a /var/www/html/.env
done

if [ "$CRON" = true ] ; then
    mv /supervisord/cron.conf /etc/supervisor.d/cron.conf
    if [ ! -d /etc/crontabs ] ; then
        mkdir -p /etc/crontabs
    fi
    cron="*       *       *       *       *       /usr/bin/php /var/www/html/artisan schedule:run >> /dev/stdout"
    echo "$cron" > /etc/crontabs/root
elif [ "$WORKER" = true ] ; then
    mv /supervisord/worker.conf /etc/supervisor.d/worker.conf
fi

exec /usr/bin/supervisord -n -c /etc/supervisor.d/supervisord.ini