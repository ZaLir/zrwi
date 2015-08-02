# Version: 0.0.2
FROM debian:wheezy
MAINTAINER Ludovic Bellier "ludovic.bellier@synolia.com"

ADD ./conf/source.list/source.list /etc/apt/sources.list

RUN apt-get upgrade
RUN apt-get update
# GITHUB RUN apt-get install -y php5-common php5-cli php5-fpm php5-mcrypt php5-mysql php5-gd php5-imagick php5-curl php5-intl
RUN apt-get install -y php5-fpm php5 php5-curl php5-imap php5-gd php5-mysqlnd php5-mcrypt php5-xsl php5-ldap php5-cli

#apt-get install php5-fpm php5 php5-curl php5-imap php5-gd php5-mysqlnd php5-mcrypt php5-xsl php5-ldap php5-cli

RUN rm /etc/php5/fpm/pool.d/www.conf

#php5-apcu 
#
ADD ./conf/symfony.ini /etc/php5/fpm/conf.d/
ADD ./conf/symfony.ini /etc/php5/cli/conf.d/

ADD ./conf/symfony.pool.conf /etc/php5/fpm/pool.d/

RUN usermod -u 1000 www-data

# Define working directory.
WORKDIR /home

EXPOSE 9000
CMD ["php5-fpm", "-F"]
#CMD ["data-container-start"]