CentOSでMT4を稼働させるための環境構築スクリプトです。

yum -y install git
git clone https://github.com/hkex0414/MT4onLinux.git
chmod -R 755 MT4onLinux

cd MT4onLinux
./centos.sh
