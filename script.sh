#!/bin/bash
sudo -i
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m ${user} -p ${password}
