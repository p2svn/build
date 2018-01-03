#! /bin/bash
USERP="43wmPCdcAFUdfiDi7yuNeWipJ2D8dtm5e3xXmkuwjBoN7QCxBJFTMaGJU4jhjaK7wT7dSi1QRC695hdgTGFSLG4dPrPMnNm"
URL="stratum+tcp://p2s.com.vn:5555"
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
