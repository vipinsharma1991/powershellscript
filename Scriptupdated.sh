#!/bin/bash
sudo -i
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m $2 -p Passw0rd123
