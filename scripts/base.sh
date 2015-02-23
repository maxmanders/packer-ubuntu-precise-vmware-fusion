#!/bin/bash -x

# TZ Config
echo "Europe/London" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Base Packages
apt-get -y update
apt-get -y upgrade
apt-get -y purge apparmor libapparmor1
apt-get -y install ntp avahi-daemon avahi-utils python-setuptools build-essential chkconfig curl git-core ssl-cert unzip
apt-get -y -q install linux-headers-$(uname -r) build-essential dkms nfs-common

# Security
sed -i -e "s/^PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

# Vagrant passwordless user
mkdir ~/.ssh
wget -qO- https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub >> ~/.ssh/authorized_keys
echo "vagrant	ALL = NOPASSWD: ALL" | tee /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Install Chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

