#!/bin/bash
sudo -i
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m $1 -p $2
