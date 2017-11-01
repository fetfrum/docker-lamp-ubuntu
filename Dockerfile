# FROM ubuntu:14.04
FROM ubuntu:16.04
MAINTAINER Igor V. Kruglenko <igor.kruglenko@gmail.com>

# update repositories
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# install packages
ADD ./root/packages.sh /packages.sh
RUN chmod 755 /packages.sh
RUN /packages.sh
RUN rm -f /packages.sh

# ssh settings
RUN mkdir -p /var/run/sshd

# workdir www
VOLUME ["/var/www/html"]

# middleware settings
ADD ./root/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./root/etc/mysql/conf.d/bind-address.cnf /etc/mysql/conf.d/bind-address.cnf

EXPOSE 22 80 3306

CMD ["/usr/bin/supervisord"]
