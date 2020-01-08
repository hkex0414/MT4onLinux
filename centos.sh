#!/bin/bash
# 1. ユーザー作成
# useradd -G wheel hoge

# 2. 作成したユーザーにパスワードを設定する 
# passwd hoge

# nanoインストール
# yum install nano

# 3. 作業用ユーザーにsudo権限を付与
# nano /etc/sudoers
# 設定ファイル中で下記がコメント(#)されていた場合はコメントを外して保存
# %wheel  ALL=(ALL)       ALL

# 4. SSHの設定ファイル確認・変更
# nano /etc/ssh/sshd_config

# PasswordAuthentication no→PasswordAuthentication yes

# 5. sshdをリロードする
# systemctl reload sshd

# 6.yumアップデート
yum -y update

# 7.タイムゾーン変更
timedatectl set-timezone Asia/Tokyo

# 8.日本語化
yum -y install ibus-kkc vlgothic-*
localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf

# 8.GUIインストール
yum -y install epel-release
yum -y groupinstall "GNOME Desktop"

# 9.Wineインストール
yum -y remove wine
yum -y erase wine wine-*

yum -y install samba-winbind-clients
yum -y groupinstall 'Development Tools'
yum -y install glibc-devel.{i686,x86_64} gnutls-devel.{i686,x86_64} freetype-devel.{i686,x86_64} alsa-lib-devel.{i686,x86_64}
yum -y install libtiff-devel.{i686,x86_64} libgcc.{i686,x86_64} libX11-devel.{i686,x86_64} libxml2-devel.{i686,x86_64}
yum -y install libjpeg-turbo-devel.{i686,x86_64} libpng-devel.{i686,x86_64} libXrender-devel.{i686,x86_64}

mkdir wine
cd wine
wget https://dl.winehq.org/wine/source/4.0/wine-4.0.tar.xz
tar Jxfv wine-4.0.tar.xz
cd wine-4.0
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

cd ~

# 10.RemoteDesktop設定
yum -y install --enablerepo=epel xrdp tigervnc-server
systemctl start xrdp.service
systemctl enable xrdp.service

systemctl start firewalld
systemctl enable firewalld.service
firewall-cmd --permanent --zone=public --add-port=3389/tcp
firewall-cmd --reload
