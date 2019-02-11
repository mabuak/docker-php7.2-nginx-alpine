FROM alpine:3.8

LABEL Fachruzi Ramadhan <fachruzi.ramadhan@gmail.com>

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd nginx supervisor curl php7-imagick php7-redis php7-xdebug \
    php7-opcache php7-zip php7-pdo php7-pdo_mysql php7-tokenizer php7-fileinfo php7-pdo_mysql php7-simplexml \
    php7-xmlwriter php7-iconv composer php7-fileinfo

# Config PHP
RUN sed -i "s/;date.timezone =.*/date.timezone = Asia\/Jakarta/g" /etc/php7/php.ini \
    && sed -i "s/upload_max_filesize =.*/upload_max_filesize = 250M/g" /etc/php7/php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php7/php.ini \
    && sed -i "s/post_max_size =.*/post_max_size = 250M/g" /etc/php7/php.ini \
    && sed -i "s/user = nobody/user = root/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/group = nobody/group = root/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/listen.owner = nobody/listen.owner = root/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/listen.group = nobody/listen.group = root/g" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s/listen.group = nobody/listen.group = root/g" /etc/php7/php-fpm.d/www.conf

# Copy nginx config
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/upstream.conf /etc/nginx/upstream.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/my_custom.conf

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /home/projects
VOLUME /home/projects
WORKDIR /home/projects

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
