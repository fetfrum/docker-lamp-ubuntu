#/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor \
mariadb-server \
mariadb-client \
php7.0 \
libapache2-mod-php7.0 \
php7.0-mysql \
php7.0-curl \
php7.0-gd \
php7.0-intl \
php-pear \
php-imagick \
php7.0-imap \
php7.0-mcrypt \
php-memcache \
php7.0-pspell \
php7.0-recode \
php7.0-sqlite3 \
php7.0-tidy \
php7.0-xmlrpc \
php7.0-xsl \
php7.0-mbstring \
php-gettext \
php7.0-opcache \
php-apcu \
phpmyadmin
