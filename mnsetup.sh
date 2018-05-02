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

echo "Creating new Tribe folder..."
cd
mkdir tribe
cp -R Tribe-mn/dasv012/. tribe
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

echo "Waiting 60 seconds for backups to complete..."
sleep 60s

read -p "Is this your first masternode? Y/N " choice
case "$choice" in
  y|Y ) echo "Running first instance..."
cd
cd tribe
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

echo "Please enter your rpc credentials... "
echo "masternode=1" >> tribe.conf
echo "daemon=1" >> tribe.conf
echo "listen=0" >> tribe.conf
  echo "rpcuser="
  read rpcuser
  echo "rpcuser=$rpcuser" >>tribe.conf
  echo "rpcpassword="
  read rpcpassword
  echo "rpcpassword=$rpcpassword" >>tribe.conf
  echo "rpcport=9399" >>tribe.conf
  echo "Enter your masternode's public ip address."
  echo "masternodeaddr="
  read vpsip
  echo "masternodeaddr=$vpsip:$rpcport" >> tribe.conf
  echo "Enter your masternode pirvate key/Gen key: "
  read mngenkey
  echo "masternodeprivkey=$mngenkey" >> tribe.conf;;
  n|N ) echo "Running second instance..."
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
echo "masternode=1" >> tribe.conf
echo "daemon=1" >> tribe.conf
echo "listen=0" >> tribe.conf
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
cd && cd Tribe-mn
git reset --hard

cd && cd tribe
./tribed -daemon

cd
echo "You can use the command: ./tribe-cli getblockcount to see what block you're on. All you need to do first is type: cd tribe and ./tribe-cli getblockcount"
echo "Please confirm your block count is matching with the block explorer before running: ./tribe-cli masternode status "
