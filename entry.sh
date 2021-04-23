#!/bin/ash

echo "Fix missing files"

if [ -z "$(ls /dokuwiki/conf)" ]; then
  cp -r /pure/conf/* /dokuwiki/conf/
fi

if [ -z "$(ls /dokuwiki/lib/tpl)" ]; then
  cp -r /pure/lib/tpl/* /dokuwiki/lib/tpl/
fi

if [ -z "$(ls /dokuwiki/lib/plugins)" ]; then
  cp -r /pure/lib/plugins/* /dokuwiki/lib/plugins/
fi

if [ -z "$(ls /dokuwiki/data)" ]; then
  cp -r /pure/data/* /dokuwiki/data/
fi

echo "Fix permissions"

chown nobody.nobody -R /dokuwiki/conf
chown nobody.nobody -R /dokuwiki/lib/tpl
chown nobody.nobody -R /dokuwiki/lib/plugins
chown nobody.nobody -R /dokuwiki/data

echo "Start service"

php-fpm7
nginx -g 'daemon off;'
