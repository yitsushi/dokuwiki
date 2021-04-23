#!/bin/ash

mkdir -p /dokuwiki/data/pages
mkdir -p /dokuwiki/data/attic
mkdir -p /dokuwiki/data/media
mkdir -p /dokuwiki/data/media_attic
mkdir -p /dokuwiki/data/media_meta
mkdir -p /dokuwiki/data/meta
mkdir -p /dokuwiki/data/cache
mkdir -p /dokuwiki/data/locks
mkdir -p /dokuwiki/data/index
mkdir -p /dokuwiki/data/tmp

chown nobody.nobody /dokuwiki/data/*

php-fpm7
nginx -g 'daemon off;'
