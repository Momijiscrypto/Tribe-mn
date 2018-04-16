#!/bin/bash

echo "Checking for updates..."
apt-get update -y && apt-get upgrade -y

echo "Getting the necessarry dependencies..."
sleep 2
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

echo "Cloning the Momijiscrypto Github for the compiled wallet..."
cd
mkdir tribe
cp -R Tribe-mn/tribe/. tribe
cd tribe
sleep 3s

echo "Starting the Tribe wallet daemon..."
chmod +755 tribed && chmod +755 tribe-cli && chmod +755 tribe-tx
sleep 3s

./tribed -daemon
echo "Daemon started for 15 seconds..."
sleep 15s
echo "Stopping server now..."
./tribe-cli stop

cd && cd .tribe

 echo "Now copying nodes to tribe.conf..."
  sleep 3s
  echo "addnode=104.156.250.28:9399" >> tribe.conf
  echo "addnode=51.15.162.15:58758" >> tribe.conf
  echo "addnode=94.156.35.73:9399" >> tribe.conf
  echo "addnode=45.77.114.30:9399" >> tribe.conf
  echo "addnode=185.81.167.100:9399" >> tribe.conf
  echo "addnode=198.58.117.5:9399" >> tribe.conf
  echo "addnode=45.77.67.141:56585" >> tribe.conf
  echo "addnode=193.27.209.108:48244" >> tribe.conf
  echo "addnode=172.104.13.253:42668" >> tribe.conf
  echo "addnode=144.217.67.68:46168" >> tribe.conf
  echo "addnode=5.79.97.229:56590" >> tribe.conf
  echo "addnode=46.4.37.60:9399" >> tribe.conf
  echo "addnode=146.0.47.218:33020" >> tribe.conf
  echo "addnode=51.15.162.15:53954" >> tribe.conf
  echo "addnode=184.67.166.234:54527" >> tribe.conf
  echo "addnode=193.27.209.108:53930" >> tribe.conf
  echo "addnode=104.13.209.85:49735" >> tribe.conf
  echo "addnode=46.163.166.59:56718" >> tribe.conf
  echo "addnode=198.27.74.189:57912" >> tribe.conf
  echo "addnode=185.213.208.179:63768" >> tribe.conf
  echo "addnode=84.162.255.248:57203" >> tribe.conf
  echo "addnode=45.32.193.12:41392" >> tribe.conf
  echo "addnode=80.211.128.10:43612" >> tribe.conf
  echo "addnode=108.231.195.26:64305" >> tribe.conf
  echo "addnode=184.69.47.154:50689" >> tribe.conf
  echo "addnode=52.23.180.74:9399" >> tribe.conf
  echo "addnode=212.47.226.127:56972" >> tribe.conf
  echo "addnode=184.69.47.154:64672" >> tribe.conf
  echo "addnode=184.67.166.234:54491" >> tribe.conf
  echo "addnode=184.69.47.154:58173" >> tribe.conf

read -p "Is this your first masternode? Y/N " choice
case "$choice" in
  y|Y ) echo "Running initial initialization..."
cd
cd tribe
echo "Testing wallet with nodes..."
sleep 3s
./tribed -daemon
echo "Running 3 block count tests... It's okay to get an error"
sleep 5s
./tribe-cli getblockcount
sleep 5s
./tribe-cli getblockcount
sleep 5s
./tribe-cli getblockcount
echo "Stopping wallet daemon for rpc credentials..."
./tribe-cli stop
sleep 3s

cd
cd .tribe

echo "masternode=1" >> tribe.conf
echo "Please enter your rpc credentials... "
  echo "rpcuser="
  read rpcuser
  echo "rpcuser=$rpcuser" >>tribe.conf
  echo "rpcpassword="
  read rpcpassword
  echo "rpcpassword=$rpcpassword" >>tribe.conf
  echo "Enter 9399 if this is your first masternode."
  echo "rpcport="
  read rpcport
  echo "rpcport=$rpcport" >>tribe.conf
  echo "Enter your masternode's public ip address."
  echo "masternodeaddr="
  read vpsip
  echo "masternodeaddr=$vpsip:$rpcport" >> tribe.conf
  echo "Enter your masternode pirvate key/Gen key: "
  read mngenkey
  echo "masternodeprivkey=$mngenkey" >> tribe.conf;;
  n|N ) echo "Running second initialization..."
cd
cd tribe
echo "Testing wallet with nodes..."
sleep 3s
./tribed -daemon
echo "Running 3 block count tests... It's okay to get an error."
./tribe-cli getblockcount
sleep 5s
./tribe-cli getblockcount
sleep 5s
./tribe-cli getblockcount
echo "Stopping wallet daemon for rpc credentials..."
./tribe-cli stop
sleep 3s

cd
cd .tribe
      echo "masternode=1" >>tribe.conf
      echo "Please enter your rpc credentials... "
      echo "rpcuser="
      read rpcuser
      echo "rpcuser=$rpcuser" >>tribe.conf
      echo "rpcpassword="
      read rpcpassword
      echo "rpcpassword=$rpcpassword" >>tribe.conf
      echo "Enter 9399 if this is your first masternode. Port must be set differentlt than your original"
      echo "Example: my second masternode will be set to port 9499 instead of 9399"
      echo "rpcport="
      read rpcport
      echo "rpcport=$rpcport" >>tribe.conf
      echo "Enter your new vps ip address"
      echo "bind="
      read bind
      echo "bind=$bind:$rpcport" >> tribe.conf
      echo "Enter your first masternode's public ip address."
      echo "masternodeaddr="
      read vpsip
      echo "masternodeaddr=$vpsip:9399" >> tribe.conf
      echo "Enter your second masternode pirvate key/Gen key: "
      read mngenkey
      echo "masternodeprivkey=$mngenkey" >> tribe.conf
	;;
  * ) echo "Please enter Y or N";;
esac
echo "Waiting 60 seconds for backups to complete..."
sleep 60s
cd && cd tribe
echo "Syncing..."
./tribed -daemon

cd && cd Tribe-mn
git reset --hard

cd
echo "You can use the command: ./tribe-cli getblockcount to see what block you're on. All you need to do first is type: cd tribe and ./tribe-cli getblockcount"
echo "Please confirm your block count is matching with the block explorer before running: ./tribe-cli masternode status "