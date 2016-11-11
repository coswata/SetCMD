#!/bin/sh
#SSHの公開鍵

echo "Input SSH Key"
read key

mkdir .ssh
chmod 700 .ssh
echo ${key} >> .ssh/authorized_keys
chmod 600 .ssh/authorized_keys