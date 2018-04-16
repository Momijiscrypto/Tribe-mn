#!/bin/bash

echo "Stopping your masternode..."
sleep 5s
cd das
./das-cli stop
cd

echo "Pulling wallet files from Momijiscrypto's Github for the compiled wallet..."
git clone https://github.com/Momijiscrypto/Tribe-mn

mkdir tribe
cp -R Tribe-mn/dasv012/. tribe
cd tribe
sleep 3s

echo "Starting the new Tribe wallet daemon..."
chmod +755 tribed && chmod +755 tribe-cli && chmod +755 tribe-tx
sleep 3s

./tribed -daemon
echo "Daemon started for 15 seconds..."
sleep 15s
./tribe-cli stop

cd
echo "Copying das masternode settings..."
cp .das/das.conf .tribe
cd .tribe && mv das.conf tribe.conf && cd
rm -r .das

echo "Updating your masternode..."
echo "deleting old client folders and old repository..."
sleep 5s
cd
rm -r DAS-Source
rm -r das
rm -r DAS-Masternode-script

cd tribe
echo "Running 3 block count tests... It's okay to get an error"
sleep 5s
./tribe-cli getblockcount
sleep 5s
./tribe-cli getblockcount
sleep 5s
./tribe-cli getblockcount

sleep 3s
echo "Please verify your blockcount is caught up with ./tribe-cli getblockcount.
Once confirmed, run ./tribe-cli masternode status."
echo "You can start your masternode up now by typing cd tribe, ./tribed -daemon and ./tribe-cli masternode status"
