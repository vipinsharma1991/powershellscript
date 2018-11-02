#!/bin/bash
#!/usr/bin/expect
sudo -i
echo 'pconnectadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -m $1 -p "Passw0rd@123"
echo -e "Passw0rd@123\nPassw0rd@123" | passwd $1;
