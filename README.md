Docker lamp ubuntu
==================

Dependencies
------------

- dockerfile/ubuntu

Installed applications
-----------------------

- Ubuntu 16.04
- Apache 2
- php 5.4
- MySQL 5.6

mariadb-server 
mariadb-client
php7.0 
libapache2-mod-php7.0 
php7.0-mysql 
php7.0-curl 
php7.0-gd 
php7.0-intl 
php-pear 
php-imagick 
php7.0-imap 
php7.0-mcrypt 
php-memcache 
php7.0-pspell 
php7.0-recode 
php7.0-sqlite3 
php7.0-tidy 
php7.0-xmlrpc 
php7.0-xsl 
php7.0-mbstring 
php-gettext 
php7.0-opcache 
php-apcu 
phpmyadmin 
bash-completion 
unzip 
sudo


Usage
-----

    docker run -d -p 80:80 -p 3306:3306 -p 22:22 -p 443:443 -v /srv/lamp/mysql:/var/lib/mysql -v /srv/lamp/root:/root --name lamp-ubuntu fetfrum/docker-lamp-ubuntu


#### Access to mysql-server from host.

    mysql -uroot -P 3306 -h 127.0.0.1

You must add remote user before this command.

#### Access to apache2 from host.

    http://localhost:80

