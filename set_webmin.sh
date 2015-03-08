#!/bin/sh
#Install Webmin

sudo apt-get -y install apt-show-versions libapt-pkg-perl libauthen-pam-perl libio-pty-perl libnet-ssleay-perl

wget http://www.webmin.com/download/deb/webmin-current.deb
sudo dpkg -i webmin-current.deb
