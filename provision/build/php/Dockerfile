FROM php:7.3-fpm
MAINTAINER phuongbui <ghetrung1@gmail.com>

# install node js
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash -
RUN apt-get update && apt-get install -y git nodejs net-tools

# install php ext
RUN apt-get install -y zip libicu-dev build-essential libcurl4-openssl-dev pkg-config libssl-dev libssl-dev zlib1g-dev libpng-dev libjpeg-dev\
           libfreetype6-dev libzip-dev\
           libc-client-dev libkrb5-dev\
    && rm -r /var/lib/apt/lists/*\
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl\
    && docker-php-ext-install imap\
    && docker-php-ext-configure intl\
    && docker-php-ext-install mysqli pdo_mysql intl\
    && docker-php-ext-install zip

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# install mongodb ext
RUN pecl install mongodb\
    && docker-php-ext-enable mongodb

# download composer and run them inside
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.19
# install mail
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' >> /usr/local/etc/php/php.ini

# install xdebug
RUN pecl install xdebug

WORKDIR /app
