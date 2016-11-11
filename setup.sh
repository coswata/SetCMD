#!/bin/sh
#cloudatcostのUbuntu向け設定

echo "Input User Name"
read user

echo "Input SSH Port number"
read port

echo "Input SSH Key"
read key

adduser ${user}
gpasswd -a ${user} sudo

sudo apt-get update
sudo apt-get -y install ssh

mkdir /home/${user}/.ssh
chmod 700 /home/${user}/.ssh
echo ${key} > /home/${user}/.ssh/authorized_keys
chmod 600 /home/${user}/.ssh/authorized_keys
chown -R ${user}:${user} /home/${user}/.ssh

sudo sed -i "s/Port "[^\n]*"/Port "${port}"/g" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config 
sudo sed -i "s/PermitRootLogin without-password/PermitRootLogin no/g" /etc/ssh/sshd_config
sudo service ssh restart

sudo iptables-save > iptables_backup.txt
sudo iptables -F
sudo iptables -X
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD DROP
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport ${port} -j ACCEPT

sudo iptables -A INPUT -m limit --limit 1/s -j LOG --log-prefix '[IPTABLES INPUT] : '
sudo iptables -A INPUT -j DROP
sudo iptables -A FORWARD -m limit --limit 1/s -j LOG --log-prefix '[IPTABLES FORWARD] : '
sudo iptables -A FORWARD -j DROP
sudo iptables-save > iptables_settings.txt
sudo iptables-restore iptables_settings.txt
sudo apt-get -y install iptables-persistent