#!/usr/bin/env bash

#Updates the list of available packages and their versions
apt-get -y update
#Installs newer versions of the installed packages for security reasons
apt-get -y upgrade
#Install Apache
apt-get install -y apache2
#Install PHP and plugins 
apt-get install -y php php-mysql
#Restart Apache
service apache2 restart
#Remove Apache Index
cd /var/www/html/ 
#Download Wordpress and extract it
wget https://wordpress.org/latest.tar.gz
tar xzfv latest.tar.gz
rsync -a  wordpress/* .
rm latest.tar.gz
rm -rf wordpress/
rm index.html
#Install and configure MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'	
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server
apt-get install -y mysql-client 
mysql -u root --password=root -e "CREATE DATABASE wordpress;"
mysql -u root --password=root -e "create user 'wp_user'@'localhost' identified by 'wp_pass';"
mysql -u root --password=root -e "grant all on wordpress.* to 'wp_user'@'localhost';"
mysql -u root --password=root -e "flush privileges;"
#Load wordpress configuratión file
cp /vagrant_data/wp-config.php /var/www/html/wp-config.php
#Reboot machine
reboot