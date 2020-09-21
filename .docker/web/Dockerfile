FROM php:7.4-apache

RUN a2enmod rewrite && a2enmod headers && a2enmod expires && a2enmod ssl

# Setup timezone
ENV TZ=Europe/Warsaw
RUN ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

# install required stuff
RUN apt-get update

RUN apt-get install -y locales
RUN apt-get install -y apt-utils
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y apt-transport-https
RUN apt-get install -y ca-certificates
RUN apt-get install -y gnupg
RUN apt-get install -y libzip-dev
RUN apt-get install -y zip
RUN apt-get install -y unzip
RUN apt-get install -y git-core
RUN apt-get install -y vim
RUN apt-get install -y nano
RUN apt-get install -y libicu-dev
RUN apt-get install -y libmemcached-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libfreetype6-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j "$(nproc)" gd

# Certificates for curl
RUN wget --no-check-certificate https://curl.haxx.se/ca/cacert.pem -O /etc/ssl/certs/cacert.pem

# Install "Composer" – https://getcomposer.org/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH="${PATH}:/root/.composer/vendor/bin"

RUN docker-php-ext-install intl
RUN docker-php-ext-install opcache
RUN docker-php-ext-install pdo_mysql
RUN pecl install memcached && docker-php-ext-enable memcached
RUN pecl install apcu && docker-php-ext-enable apcu

# node & yarn
RUN apt-get install -y gnupg
RUN apt-get install -y nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -yqq

# copy the bootstrap script
COPY bootstrap.sh /var/myboot/bootstrap.sh
RUN chmod +x /var/myboot/bootstrap.sh
CMD ["/var/myboot/bootstrap.sh"]

# Clean repository and image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 80
EXPOSE 443
