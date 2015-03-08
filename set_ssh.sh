#!/bin/sh
#SSHのインストールとiptablesの設定を一度に実行
#公開鍵の設定が必要なので、そちらは手動で行う

if [ $# -ne 1 ]; then
    echo "Input SSH Port number"
    read port
else
    port=${1}
fi

sudo apt-get -y install ssh

sudo sed -i "s/Port "[^\n]*"/Port "${port}"/g" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config 
sudo sed -i "s/PermitRootLogin without-password/PermitRootLogin no/g" /etc/ssh/sshd_config

./set_iptables.sh ${port}

sudo service ssh restart
