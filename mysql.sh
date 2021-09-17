#/usr/bin/env bash

#Create the DB
mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER 
    ON wordpress.*
    TO wordpress@localhost;
FLUSH PRIVILEGES;
EOF

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/password_here/${MYSQL_USER_PASSWORD}/" /srv/www/wordpress/wp-config.php


#Substitution of keys from https://stackoverflow.com/a/6233537
SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
STRING='put your unique phrase here'
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /srv/www/wordpress/wp-config.php


