FROM ubuntu:focal

#
# Adapted from https://ubuntu.com/tutorials/install-and-configure-wordpress
# by Mark Stover
#
# Tell apt-get not to prompt us
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone before installing mysql-serve
ENV TZ=US/Central
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    ed \
    ghostscript \
    libapache2-mod-php \
    mysql-server \
    php \
    php-bcmath \
    php-curl \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install wordpress
#ADD --chown=www-data:www-data ./www/ /srv/
RUN mkdir -p /srv/www
RUN chown www-data: /srv/www
ADD --chown=www-data:www-data https://wordpress.org/latest.tar.gz /
RUN sudo -u www-data tar zx -C /srv/www -f /latest.tar.gz

# Configure apache to run wordpress site
ADD wordpress.conf  /etc/apache2/sites-available
RUN sudo a2ensite wordpress && sudo a2enmod rewrite && sudo a2dissite 000-default
#RUN sudo service apache2 start


#ARG MYSQL_USER_PASSWORD=p@ss4h0rnsN3tDb
ARG MYSQL_USER_PASSWORD=blahblah
# Configure mysql server
#RUN sudo service mysql start
ADD mysql.sh /
RUN chmod 755 /mysql.sh 
RUN service mysql restart && /mysql.sh

ADD start.sh / 
RUN chmod 755 /start.sh
EXPOSE 80
ENTRYPOINT /start.sh && /bin/bash

