#!/bin/sh
#Webminのインストールのみ実行
#Port 10000の解放は手動で行ってね

sudo apt-get -y install apt-show-versions libapt-pkg-perl libauthen-pam-perl libio-pty-perl libnet-ssleay-perl

wget http://www.webmin.com/download/deb/webmin-current.deb
sudo dpkg -i webmin-current.deb
