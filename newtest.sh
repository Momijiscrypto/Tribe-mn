#!/bin/bash

echo "Checking for updates..."
apt-get update -y
apt-get upgrade -y

echo "Getting the necessarry dependencies..."
sleep 2

echo "Checking for system updates..."
apt-get install update -y
echo "Checking for software upgrades..."
apt-get upgrade -y
echo "Checking for distro upgrades..."
apt-get dist-upgrade -y
echo "Installing the nano text editor..."
apt-get install nano htop git -y
echo "Installing dev tools..."
apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils -y
apt-get install libboost-all-dev -y

echo "Installing bitcoin repository..."
apt-get install software-properties-common -y
add-apt-repository ppa:bitcoin/bitcoin -y
apt-get update -y
apt-get install libdb4.8-dev libdb4.8++-dev -y

echo "Installing Git..."
apt-get install git-core -y


echo "Cloning the Momijiscrypto Github for the compiled wallet..."
cd
mkdir das
cd das
git clone https://github.com/Momijiscrypto/DAS-Masternode-script
cd dasv012
sleep 3s

echo "Starting the DAS wallet daemon..."
./dasd -daemon
echo "Daemon started for 15 seconds..."
sleep 15s
echo "Stopping server now..."
./das-cli stop

cd
cd .das

 echo "Now copying nodes to das.conf..."
  sleep 3s
  echo "addnode=104.156.250.28:9399" >> das.conf
  echo "addnode=51.15.162.15:58758" >> das.conf
  echo "addnode=94.156.35.73:9399" >> das.conf
  echo "addnode=45.77.114.30:9399" >> das.conf
  echo "addnode=185.81.167.100:9399" >> das.conf
  echo "addnode=198.58.117.5:9399" >> das.conf
  echo "addnode=45.77.67.141:56585" >> das.conf
  echo "addnode=193.27.209.108:48244" >> das.conf
  echo "addnode=172.104.13.253:42668" >> das.conf
  echo "addnode=144.217.67.68:46168" >> das.conf
  echo "addnode=5.79.97.229:56590" >> das.conf
  echo "addnode=46.4.37.60:9399" >> das.conf
  echo "addnode=146.0.47.218:33020" >> das.conf
  echo "addnode=51.15.162.15:53954" >> das.conf
  echo "addnode=184.67.166.234:54527" >> das.conf
  echo "addnode=193.27.209.108:53930" >> das.conf
  echo "addnode=104.13.209.85:49735" >> das.conf
  echo "addnode=46.163.166.59:56718" >> das.conf
  echo "addnode=198.27.74.189:57912" >> das.conf
  echo "addnode=185.213.208.179:63768" >> das.conf
  echo "addnode=84.162.255.248:57203" >> das.conf
  echo "addnode=45.32.193.12:41392" >> das.conf
  echo "addnode=80.211.128.10:43612" >> das.conf
  echo "addnode=108.231.195.26:64305" >> das.conf
  echo "addnode=184.69.47.154:50689" >> das.conf
  echo "addnode=52.23.180.74:9399" >> das.conf
  echo "addnode=212.47.226.127:56972" >> das.conf
  echo "addnode=184.69.47.154:64672" >> das.conf
  echo "addnode=184.67.166.234:54491" >> das.conf
  echo "addnode=184.69.47.154:58173" >> das.conf

read -p "Is this your first masternode? Y/N " choice
case "$choice" in
  y|Y ) echo "Running initial initialization..."
cd
cd das
cd dasv012
echo "Testing wallet with nodes..."
sleep 3s
./dasd -daemon
echo "Running 3 block count tests... It's okay to get an error"
./das-cli getblockcount
sleep 5s
./das-cli getblockcount
sleep 5s
./das-cli getblockcount
echo "Stopping wallet daemon for rpc credentials..."
./das-cli stop
sleep 3s

cd
cd .das

echo "masternode=1" >> das.conf
echo "Please enter your rpc credentials... "
  echo "rpcuser="
  read rpcuser
  echo "rpcuser=$rpcuser" >>das.conf
  echo "rpcpassword="
  read rpcpassword
  echo "rpcpassword=$rpcpassword" >>das.conf
  echo "Enter 9399 if this is your first masternode."
  echo "rpcport="
  read rpcport
  echo "rpcport=$rpcport" >>das.conf
  echo "Enter your masternode's public ip address."
  echo "masternodeaddr="
  read vpsip
  echo "masternodeaddr=$vpsip:$rpcport" >> das.conf
  echo "Enter your masternode pirvate key/Gen key: "
  read mngenkey
  echo "masternodeprivkey=$mngenkey" >> das.conf;;
  n|N ) echo "Running second initialization..."
cd
cd das
cd dasv012
echo "Testing wallet with nodes..."
sleep 3s
./dasd -daemon
echo "Running 3 block count tests... It's okay to get an error."
./das-cli getblockcount
sleep 5s
./das-cli getblockcount
sleep 5s
./das-cli getblockcount
echo "Stopping wallet daemon for rpc credentials..."
./das-cli stop
sleep 3s

cd
cd .das
      echo "masternode=1" >>das.conf
      echo "Please enter your rpc credentials... "
      echo "rpcuser="
      read rpcuser
      echo "rpcuser=$rpcuser" >>das.conf
      echo "rpcpassword="
      read rpcpassword
      echo "rpcpassword=$rpcpassword" >>das.conf
      echo "Enter 9399 if this is your first masternode. Port must be set differentlt than your original"
      echo "Example: my second masternode will be set to port 9499 instead of 9399"
      echo "rpcport="
      read rpcport
      echo "rpcport=$rpcport" >>das.conf
      echo "Enter your new vps ip address"
      echo "bind="
      read bind
      echo "bind=$bind:$rpcport" >> das.conf
      echo "Enter your first masternode's public ip address."
      echo "masternodeaddr="
      read vpsip
      echo "masternodeaddr=$vpsip:9399" >> das.conf
      echo "Enter your second masternode pirvate key/Gen key: "
      read mngenkey
      echo "masternodeprivkey=$mngenkey" >> das.conf
      echo "Waiting 60 seconds for backups to complete..."
	sleep 60s
	cd
	cd das
	cd dasv012
	echo "Syncing..."
	./dasd -daemon

cd
echo "You can use the command: sudo ./das-cli getblockcount to see what block you're on. All you need to do first is type: cd das/dasv012 and ./das-cli getblockcount"
echo "Please confirm your block count is matching with the block explorer before running: ./das-cli masternode status "
