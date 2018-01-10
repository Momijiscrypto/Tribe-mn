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

#echo "Installing Git..."
#apt-get install git-core -y

echo "Cloning the WWF(WhyWeFight) Github for the compiled wallet..." 
cd
git clone https://github.com/whywefight/DAS-12.2 DAS-Source

echo "renaming DAS-12.2-Ubuntu16-wwf and DAS-12.2-Ubuntu16-wwf to ubuntu16 and ubuntu17 respectively..."
cd
cd DAS-Source
mv DAS-12.2-Ubuntu16-wwf ubuntu16
mv DAS-12.2-Ubuntu17-wwf ubuntu17


echo "Starting the DAS wallet daemon..."
cd ubuntu17
./dasd -daemon
echo "Daemon started for 15 seconds..."
sleep 15s
echo "Stopping server now..."
./das-cli stop


cd
cd .das
echo "Please enter the masternode number. If this is your first, put 1, second put 2, and so on"
echo "masternode="
read mnNumber
echo "masternode=$mnNumber" >>das.conf
echo "Please enter your rpc credentials... "
echo "rpcuser="
read rpcuser
echo "rpcuser=$rpcuser" >>das.conf
echo "rpcpassword="
read rpcpassword
echo "rpcpassword=$rpcpassword" >>das.conf
echo "rpcport="
read rpcport
echo "rpcport=$rpcport" >>das.conf
echo "Enter your masternode's public ip address."
echo "masternodeaddr="
read vpsip
echo "masternodeaddr=$vpsip:$rpcport" >> das.conf
echo "Enter your masternode pirvate key/Gen key: "
read mngenkey
echo "masternodeprivkey=$mngenkey" >> das.conf

echo "Now copying nodes to das.conf..."

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

echo "Starting DAS daemon back up for syncing..."
echo "Waiting 60 seconds for backups to complete..."
sleep 60s
cd
cd DAS-Source/ubuntu17
echo "Syncing..."
./dasd -daemon
cd
echo "You can use the command: sudo ./das-cli getblockcount to see what block you're on. All you need to do first is type: cd DAS-Source/ubuntu16 and ./das-cli getblockcount"
echo "Please confirm your block count is matching with the block explorer before running: ./das-cli masternode status "
