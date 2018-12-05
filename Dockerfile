FROM alpine:3.8

LABEL Fachruzi Ramadhan <fachruzi.ramadhan@gmail.com>

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd nginx supervisor curl php7-imagick php7-redis php7-xdebug \
    php7-opcache php7-zip php7-pdo php7-pdo_mysql php7-tokenizer

# Copy nginx config
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/upstream.conf /etc/nginx/upstream.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/my_custom.conf
COPY config/php.ini /etc/php7/conf.d/my_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /home/projects
VOLUME /home/projects
WORKDIR /home/projects

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
