#!/bin/bash
sudo -i
echo 'CodexAdmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m $1 -p $2
echo "$1:$2" | chpasswd
sudo usermod -aG sudo $1
echo '$1 ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Singapore /etc/localtime
