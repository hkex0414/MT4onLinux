#!/bin/bash
sudo su
yum -y update
timedatectl set-timezone Asia/Tokyo
yum -y install ibus-kkc vlgothic-*
localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf
yum -y install epel-release
yum -y groupinstall "GNOME Desktop"
yum -y --enablerepo=epel groupinstall "MATE Desktop"
echo "PREFERRED=/usr/bin/mate-session" > /etc/sysconfig/desktop
yum -y remove wine
yum -y erase wine wine-*
yum -y install samba-winbind-clients
yum -y groupinstall 'Development Tools'
yum -y install glibc-devel.{i686,x86_64} gnutls-devel.{i686,x86_64} freetype-devel.{i686,x86_64} alsa-lib-devel.{i686,x86_64}
yum -y install libtiff-devel.{i686,x86_64} libgcc.{i686,x86_64} libX11-devel.{i686,x86_64} libxml2-devel.{i686,x86_64}
yum -y install libjpeg-turbo-devel.{i686,x86_64} libpng-devel.{i686,x86_64} libXrender-devel.{i686,x86_64}
mkdir wine
cd wine
wget https://dl.winehq.org/wine/source/5.0/wine-5.0-rc5.tar.xz
tar Jxfv wine-5.0-rc5.tar.xz
cd wine-5.0-rc5
mkdir -p wine32 wine64
cd wine64
../configure --enable-win64
make
cd ../wine32
../configure --with-wine64=../wine64
make
cd ../wine32
make install
cd ../wine64
make install
yum -y install --enablerepo=epel xrdp tigervnc-server
systemctl start xrdp.service
systemctl enable xrdp.service
systemctl start firewalld
systemctl enable firewalld.service
firewall-cmd --permanent --zone=public --add-port=3389/tcp
firewall-cmd --reload

#useradd -G wheel sampleuser
#passwd sampleuser
#→パスワード入力
#mkdir bin
#cd bin
#wget http://www.kegel.com/wine/winetricks
#chmod +x winetricks
