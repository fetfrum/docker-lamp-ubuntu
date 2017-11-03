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
phpmyadmin \
bash-completion \
unzip \
nano \
sudo \
locales \
mc

locale-gen en_US.UTF-8
echo LANG=en_US.UTF-8 > /etc/default/locale

cp /etc/skel/.bash_logout /root/
cp /etc/skel/.bashrc /root/
cp /etc/skel/.profile /root/

mysql_install_db

ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
a2enconf  phpmyadmin

rm /packages.sh
