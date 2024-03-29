FROM alpine:3.11

RUN apk add --no-cache curl nginx \
      php7 php7-fpm php7-xml php7-gd php7-pcntl php7-session php7-bz2 \
      php7-gettext php7-yaml php7-json php7-zip php7-mbstring php7-fileinfo \
      php7-openssl php7-opcache php7-curl php7-tokenizer php7-common \
      php7-imagick php7-exif

RUN curl -o /dokuwiki-stable.tgz \
            https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && \
      mkdir /dokuwiki && \
      tar zxf /dokuwiki-stable.tgz -C /dokuwiki --strip 1

COPY entry.sh /entry.sh
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY default.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /entry.sh
RUN mkdir -p /var/run/php /run/nginx

RUN mkdir /pure && tar --strip 1 -C /pure -zxf /dokuwiki-stable.tgz

VOLUME /dokuwiki/data /dokuwiki/conf

EXPOSE 80

CMD ["/entry.sh"]
