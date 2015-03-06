#!/bin/bash
#
#LAMP Install Script V1.0
#DATE 2015.3.6
#MAINTAINER Pengfei.Shi--<shipengfei92@gmail.com>
#
#Replace the mysql root password for your own
#MYSQL_ROOT_PASS=omnilab
MYSQL_ROOT_PASS=$1
#Replace the mysql phpmyadmin password for your own
#MYSQL_PHPMYADMIN_PASS=0mnil@b
MYSQL_PHPMYADMIN_PASS=$2

#Set the DNS of SJTU
echo "nameserver 202.120.2.101" > /etc/resolv.conf
#Change the sources.list to SJTU Local Sources
sed -i "s/nova.clouds.archive.ubuntu.com/ftp.sjtu.edu.cn/g" /etc/apt/sources.list

apt-get update

echo mysql-server mysql-server/root_password password $MYSQL_ROOT_PASS | sudo debconf-set-selections  
echo mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASS | sudo debconf-set-selections

echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_PHPMYADMIN_PASS" |debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_PHPMYADMIN_PASS" | debconf-set-selections

apt-get install -y mysql-server-5.5
apt-get install -y apache2
apt-get install -y php5 php5-mysql
apt-get install -y phpmyadmin
#Create the test file for php
echo "<?php phpinfo() ?>" >> /var/www/html/test.php
#Link the phpmyadmin to apache2 dir
ln -s /usr/share/phpmyadmin/ /var/www/html/


