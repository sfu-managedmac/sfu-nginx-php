FROM nginx
MAINTAINER Brian Warsing <dayglojesus@gmail.com>

ENV REFRESHED_AT 2015-06-20
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -yq install \
        git \
        curl \
        php5-fpm \
        php5-sqlite \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD config_files/www.conf /etc/php5/fpm/pool.d/www.conf
ADD config_files/default.conf /etc/nginx/conf.d/default.conf
ADD run.sh /

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
    mkdir /app /appdata && \
    chown -R nginx:nginx /app /appdata && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    echo "<?php phpinfo(); ?>" > /app/index.php && \
    chmod +x /run.sh

VOLUME ["/app", "/appdata"]

CMD ["/run.sh"]