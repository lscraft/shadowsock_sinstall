#!/bin/bash
#the first version of ss&pptp installer
echo "A script to install shadowsocks in Ubuntu"
apt-get install update
apt-get install python-pip
pip install shadowsocks
ip1=`ifconfig|grep 'inet addr:.*Bcast'|sed 's/^.*addr://g'|sed 's/  Bcast.*$//g'`
read -p "Your port(default is 9000)" port1
read -p "method(default is rc4-md5)" med
if [ "$med" == "" ]; then
med="rc4-md5"
fi
if [ "$port1" == "" ];then
port1=9000
fi
read -p "pasaword?(default is 123456)" pass1
if [ "$pass1" == "" ];then
pass1="123456"
fi
touch /etc/shadowsocks.json
cat >/etc/shadowsocks.json <<EOF
{"server":"$ip1",
"server_port":$port1,
"local_address": "127.0.0.1",
"local_port":1080,
"password":"$pass1",
"timeout":300,
"method":"$med"}
EOF
ssserver -c /etc/shadowsocks.json -d start

