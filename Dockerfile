FROM ubuntu:16.04
MAINTAINER Igor V. Kruglenko <igor.kruglenko@gmail.com>


# workdir www
VOLUME /var/www/
ADD ./root/phpinfo.php /var/www/html/
VOLUME /var/lib/mysql
VOLUME /root

# update repositories
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

COPY files/ /

RUN \
  groupadd mysql && \
  useradd -g mysql mysql && \
  apt-get update && \
  apt-get install -y gettext-base mariadb-server pwgen && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir --mode=0777 /var/run/mysqld && \
  chown mysql:mysql /var/lib/mysql && \
  printf '[mysqld]\nskip-name-resolve\n' > /etc/mysql/conf.d/skip-name-resolve.cnf && \
  chmod 777 /docker-entrypoint-initdb.d && \
  chmod 0777 -R /var/lib/mysql /var/log/mysql && \
  chmod 0775 -R /etc/mysql && \
  chmod 0755 -R /hooks && \
  cd /opt/configurability/src/mariadb_config_translator && \
  pip --no-cache install --upgrade pip && \
  pip --no-cache install --upgrade .

ENV DISABLE_PHPMYADMIN=0 \
    PMA_ARBITRARY=0 \
    PMA_HOST=localhost \
    MYSQL_GENERAL_LOG=0 \
    MYSQL_QUERY_CACHE_TYPE=1 \
    MYSQL_QUERY_CACHE_SIZE=16M \
    MYSQL_QUERY_CACHE_LIMIT=1M


# install packages
ADD ./root/packages.sh /packages.sh
RUN chmod 755 /packages.sh 
RUN /packages.sh 

# ssh settings
RUN apt-get install -y openssh-server openssh-client passwd && mkdir -p /var/run/sshd && \
sed -ri 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
echo 'root:changeme' | chpasswd && \
mkdir -p /root/.ssh && \
touch /root/.ssh/authorized_keys && \
chmod 700 /root/.ssh

#RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key

# Put your own public key at id_rsa.pub for key-based login.
#ADD id_rsa.pub /root/.ssh/authorized_keys

# middleware settings
ADD ./root/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./root/etc/mysql/conf.d/bind-address.cnf /etc/mysql/conf.d/bind-address.cnf

EXPOSE 22 80 443 3306

CMD ["/usr/bin/supervisord"]
