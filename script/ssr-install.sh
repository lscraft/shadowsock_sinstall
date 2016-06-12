#!/bin/bash
#the first version of ss installer
echo "A script to install shadowsocks in Ubuntu"
apt-get install build-essential
wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz
tar xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
./configure && make -j2 && make install
ldconfig
cd ~
git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
cd shadowsocks/shadowsocks
read -p "Your port(default is 443)" port1
read -p "method(default is rc4-md5)" med
if [ "$med" == "" ]; then
med="rc4-md5"
fi
if [ "$port1" == "" ];then
port1=443
fi
read -p "pasaword?(default is 123456)" pass1
if [ "$pass1" == "" ];then
pass1="123456"
fi
touch /etc/shadowsocks.json
cat >/etc/shadowsocks.json <<EOF
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": $port1,
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "password": "$pass1",
    "timeout": 120,
    "method": "$med",
    "protocol": "auth_sha1_compatible",
    "protocol_param": "",
    "obfs": "tls1.0_session_auth_compatible",
    "obfs_param": "",
    "redirect": "",
    "dns_ipv6": false,
    "fast_open": true,
    "workers": 1
}
EOF
