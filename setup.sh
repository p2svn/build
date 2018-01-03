#! /bin/bash
NGAUNHIEN=$((RANDOM%3+1))
if [ $NGAUNHIEN = 1 ]; then
URL="stratum+tcp://p2s.com.vn:5555"
elif [ $NGAUNHIEN = 2 ]; then
URL="stratum+tcp://p2s.com.vn:3333"
else 
URL="stratum+tcp://p2s.com.vn:7777"
fi
USERP="45mAaQZm7MMct6qm6r4b2UZQpELzRKLRD7X7vMoJoAUGBvGtFJELuHDc5LzbWVxr48irRRPocGSffb5HKMNifxh62EASYGC"
ID=$(hostname)
PASS="admin@p2s.vn"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y automake build-essential autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev
git clone https://github.com/wolf9466/cpuminer-multi cpuminer
cd cpuminer
sudo ./autogen.sh
CFLAGS="-march=native" ./configure
make
sudo sysctl -w vm.nr_hugepages=$((`grep -c ^processor /proc/cpuinfo` * 3))
./minerd -a cryptonight -o $URL -u $USERP -p $ID:$PASS -t `grep -c ^processor /proc/cpuinfo`
