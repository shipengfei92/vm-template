#!/bin/bash

apt-get update
apt-get install -y docker.io

[ -e /usr/lib/apt/methods/https ] || {
  apt-get update
  apt-get install -y apt-transport-https
}

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

sh -c "echo deb https://get.docker.com/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"

apt-get update
apt-get install -y lxc-docker

echo "DOCKER_OPTS=\"\$DOCKER_OPTS --registry-mirror=http://10.50.6.50:5000\"" >> /etc/default/docker
