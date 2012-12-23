#!/bin/sh
##############################################################
# Jurre van Bergen
##############################################################
# Update System
echo 'System Update'
apt-get -y update
echo 'Update completed'
# System install with basic tools
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++ checkinstall colordiff make patch subversion git git-core
python-setuptools autoconf
# Download & Unpack Node.js - v. 0.8.1
echo 'Download Node.js - v. 0.8.1'
mkdir /tmp/node-install
cd /tmp/node-install
wget http://nodejs.org/dist/v0.8.16/node-v0.8.16.tar.gz
tar -zxf node-v0.8.*.tar.gz
echo 'Node.js download & unpack completed'
# Install Node.js
echo 'Install Node.js'
cd node-v0.8.*
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.8.16" --default
echo 'Node.js install completed'
# Install Redis
echo 'Install Redis'
cd /tmp
mkdir redis && cd redis
wget http://redis.googlecode.com/files/redis-2.6.7.tar.gz
tar -zxf redis-2.*.*.tar.gz
cd redis-2.*.*
make && make install
wget https://github.com/ijonas/dotfiles/raw/master/etc/init.d/redis-server
wget https://github.com/ijonas/dotfiles/raw/master/etc/redis.conf
mv redis-server /etc/init.d/redis-server
chmod +x /etc/init.d/redis-server
mv redis.conf /etc/redis.conf
useradd redis
mkdir -p /var/lib/redis
mkdir -p /var/log/redis
chown redis.redis /var/lib/redis
chown redis.redis /var/log/redis
update-rc.d redis-server defaults
echo 'Redis install completed. Run "sudo /etc/init.d/redis-server start"'
echo 'Server has now been bootstrapped..'
