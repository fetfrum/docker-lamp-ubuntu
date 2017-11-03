FROM ubuntu:16.04
MAINTAINER Igor V. Kruglenko <igor.kruglenko@gmail.com>


# workdir www
VOLUME ["/var/www/"]
ADD ./root/phpinfo.php /var/www/html/
VOLUME ["/var/lib/mysql"]
VOLUME ["/root"]

# update repositories
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# install packages
ADD ./root/packages.sh /packages.sh
RUN chmod 755 /packages.sh && /packages.sh 

# ssh settings
RUN apt-get install -y openssh-server openssh-client passwd && mkdir -p /var/run/sshd

#RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd

# Put your own public key at id_rsa.pub for key-based login.
RUN mkdir -p /root/.ssh && touch /root/.ssh/authorized_keys && chmod 700 /root/.ssh
#ADD id_rsa.pub /root/.ssh/authorized_keys

# middleware settings
ADD ./root/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./root/etc/mysql/conf.d/bind-address.cnf /etc/mysql/conf.d/bind-address.cnf

EXPOSE 22 80 443 3306

CMD ["/usr/bin/supervisord"]
