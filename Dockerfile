From php:7.2-fpm
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get update 
RUN apt-get install -y libmcrypt-dev && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install bcmath
RUN echo "date.timezone = PRC\n"\
    "memory_limit = 256M\n" \
    "upload_max_filesize = 200M\n" \
    "post_max_size = 200M\n" \
    "max_execution_time = 60\n" \
    "log_errors = On\n" \
    "error_log = /dev/stderr\n" >> /usr/local/etc/php/php.ini
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata