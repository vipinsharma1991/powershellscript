#!/bin/bash
#!/usr/bin/expect
sudo -i
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m $1 -p "Passw0rd@123";
echo "$1:Passw0rd@123" | chpasswd
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Singapore /etc/localtime
