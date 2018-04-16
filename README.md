# DAS-Masternode-script
A masternode script for DAS to ensure your masternode is running on your Ubuntu vps as fast as possible.
-Momijiscrypto


Instructions for a clean install on a vps:

1: On a clean install of Ubuntu 16.04 on your VPS, run the following command:

  apt-get update && apt-get install git -y

2: Once both have finished, copy the following command below:

  git clone https://github.com/Momijiscrypto/Tribe-mn

3: Run the following commands to make the script executable:

  cd Tribe-mn
  chmod +755 mnsetup.sh

4: Now that the script is executable, run:

  ./mnsetup.sh

5: This will take some time as the script downloads and installs the necesarry dependencies to run the wallet.

6: When the script is close to being finished, it will ask for you to input your rpc credentials for your node and copy it to your config file.

7: Once the script is finished, type:

  cd tribe

8: Run this command every so often to make sure the blockchain is up to date:

  ./tribe-cli getblockcount

9: Once the blockchain is up to date, make sure you start your masternode on your original wallet and then type in this on your vps:

  ./tribe-cli masternode status

------------------------------------------------------------------------------------------------------------

Instructions for updating a masternode on a vps:

1: When you want to update your masternode to the latest version, type:

  cd Tribe-mn && git pull

2: If you get an error from not being able to pull, run:

  cd Tribe-mn (If you aren't already in the folder)
  git reset --hard
  
  git pull

3: Once everything has been pulled, run:

  chmod +755 updatemn.sh
  
  ./updatemn.sh
