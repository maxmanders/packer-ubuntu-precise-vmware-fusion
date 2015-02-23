# Packer VM builder

Build a new Vagrant base box for VMWare Fusion based on Ubuntu 14.04 LTS x86_64
* `ntp`
* `avahi-daemon`
* `build-essential`
* `chkconfig`
* `curl`
* `git-core`
* `ssl-cert`
* `unzip`
* Linux headers and DKMS
* Defaults to Europe/London timezone
* Nukes apparmor
* Python Setuptools for easy_install and pip
* No root login allowed
* Standard no-password `vagrant` user
* VMWare Tools installed 
* VirtualBox Guest Additions Installed

## Installation

Install the correct [Packer](http://packer.io) for your system.

	packer build ubuntu-trusty.json

Once this has completed, there will be an `ubuntu-trusty.box` file th the provider
included in the file name in the current directory.

This can be imported to Vagrant with

	vagrant box add ubuntu-trusty-<type> /path/to/ubuntu-precise.<type>.box --provider [vmware_fusion,virtualbox]


