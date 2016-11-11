#!/bin/sh
#CloudatCost向けの設定
#Ubuntuでrootの前提

echo "Input User Name"
read user

adduser ${user}
gpasswd -a ${user} sudo

#chown -R ${user}:${user} .ssh
#mv .ssh/ /home/${user}/.ssh