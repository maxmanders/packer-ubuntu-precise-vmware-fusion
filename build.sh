#!/bin/bash -x

# TZ Config
echo "Europe/London" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Base Packages
apt-get -y update
apt-get -y upgrade
apt-get -y purge apparmor libapparmor1
apt-get -y install ntp avahi-daemon python-setuptools build-essential chkconfig curl git-core ssl-cert unzip
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

# VMWare Tools
cd /tmp
mkdir -p /mnt/cdrom
mount -o loop /home/vagrant/linux.iso /mnt/cdrom
tar zxvf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
/tmp/vmware-tools-distrib/vmware-install.pl -d
rm /home/vagrant/linux.iso
umount /mnt/cdrom

# And reboot 
if [ -f /var/run/reboot-required ]; then
  /sbin/reboot
fi
exit 0
