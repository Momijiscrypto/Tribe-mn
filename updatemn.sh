#!/bin/bash

echo "Updating your masternode..."
echo "deleting old client folder..."
sleep 5s
cd
rm -r DAS-Source

echo "Cloning the Momijiscrypto Github for the compiled wallet..."
git pull origin master https://github.com/Momijiscrypto/DAS-Masternode-script
cd
mkdir das
cp -R DAS-Masternode-script/dasv012/. das
cd das
sleep 3s

echo "Starting the new DAS wallet daemon..."
chmod +755 dasd
chmod +755 das-cli
chmod +755 das-tx
sleep 3s

./dasd -daemon
echo "Daemon started for 15 seconds..."
sleep 15s
echo "Running 3 block count tests... It's okay to get an error"
sleep 5s
./das-cli getblockcount
sleep 5s
./das-cli getblockcount
sleep 5s
./das-cli getblockcount

sleep 3s
echo "Please verify your blockcount is caught up with ./das-cli getblockcount.
Once confirmed, run ./das-cli masternode status."
echo "You can start your masternode up now by typing cd das, ./dasd -daemon and ./das-cli masternode status"
