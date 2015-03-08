#!/bin/bash
#
#
#Install Script V1.0
#DATE 2015.3.6
#MAINTAINER Pengfei.Shi--<shipengfei92@gmail.com>
#
#
#set your ubuntu password
passwd ubuntu<<EOF
#password
novaSJTU
novaSJTU
EOF
#Allow remote connection by password
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service ssh restart

#Set the DNS of SJTU
echo "nameserver 202.120.2.101" > /etc/resolv.conf
#Change the sources.list to SJTU Local Sources
sed -i "s/nova.clouds.archive.ubuntu.com/ftp.sjtu.edu.cn/g" /etc/apt/sources.list

apt-get update
apt-get install docker.io -y
