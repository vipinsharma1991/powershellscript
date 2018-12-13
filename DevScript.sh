#!/bin/bash
sudo -i
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m $1 -p $2
echo "$1:$2" | chpasswd
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Singapore /etc/localtime
