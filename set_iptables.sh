#!/bin/sh
#iptablesの設定を実行
#解放するポートはSSH用のポートのみ

if [ $# -ne 1 ]; then
    echo "Input SSH Port number"
    read port
else
    port=${1}
fi

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
