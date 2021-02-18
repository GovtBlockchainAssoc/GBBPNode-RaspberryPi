# GBBPNode-RaspberryPi

#### Recommended hardware and setup ####
1.    Raspberry 4 (or later) with 4GB RAM (or more)
    	current recommended version is the CanaKit Raspberry Pi 4 4GB Starter Kit – 4GB RAM  
	available from Amazon.com for USD $99.99 (https://www.amazon.com/gp/product/B07V5JTMV9/ref=ppx_yo_dt_b_asin_title_o00_s00)  
	WARNING: Do NOT get a version without a fan!
2.    MicroSD Card (256 GB Class 10 minimun)  
	 * 256GB MicroSD cards pre-loaded with the GBBP Node software can be ordered at cost from https://www.gbaglobal.org/gbbp-sd/  
	 * If you wish to buy and set up your own, the GBA recommends a 256GB or larger card in the $25-35 range  
	  (e.g. https://www.amazon.com/Micro-Center-256GB-Adapter-Memory/dp/B07K81C9XN/ref=sr_1_7_sspa)  
	  WARNING: There are off-brand cards with 1TB storage in this price range and lower as well, but the reviews are terrible and they are NOT recommended
3.    30303 Port forwarding  
	* Find instructions for your router by Googling “port forwarding” followed by your ISP and/or router model.  
	* Check for success by pointing a web browser at http://portquiz.net:30303/  
*    (optional) USB keyboard, Monitor and HDMI cable (micro-HDMI)

#### You will also (temporarily) need your usual computer (Windows, Mac or Linux) ####

#### It is STRONGLY recommended that you test your Raspberry Pi assembly with the NOOBS MicroSD card that came with your Raspberry Pi ####

#### To install Ubuntu 20.04.02, follow the instructions at https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview ####
1.	To install Ubuntu 20.04.02, follow the instructions at https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview
2.	Insert SD card in Windows system
3.	Download the Imager
4.	Run the Imager
5.	In the Imager, Choose OS, select Ubuntu then select from the next pop-up menu 
	```"Server 20.04.2 LTS (RPi 3/4/4000) 64-bit server OS with long-term support for arm64 architectures```
         (possibly the 5th entry down the list)
6.	In the Imager, select the SD card drive
7.	Click on “WRITE” and wait for the magic to happen… (This magic might take a few minutes)

#### Unless you have a wired Ethernet connection, configure your wireless information (network name/SSID and password)
9.	When the writing is done, take the SD card out of Windows system and put in the Pi.

#### Install the Java JDK (temporary instructions at https://techoral.com/blog/java/install-openjdk-15-ubuntu.html) ####

#### To install Besu ####
1. Download the Besu packaged binaries from https://github.com/hyperledger/besu/releases.
2. Unpack the downloaded files and change into the besu-<release> directory.
3. Display Besu command line help to confirm installation:
```bin/besu --help```

#### If you are having problems connecting to your wi-fi ####
Follow one set of the instructions at https://smallbusiness.chron.com/run-command-startup-linux-27796.html to run the following command at boot up
```
sudo dhcpcd -4 
```
(if someone could tell me which method is best, I'll put that advice here)

#### To complete and run your GBBP Node ####
1. Save the current Besu config files and then replace them with the GBBP config.toml & ibft2Genesis.json files.  You will also want to create a bob (or whatever name you choose) data directory and add the file static-nodes.json to it.
2. Run your node with the command line
```
bin/besu --data-path=bob --config-file=config.toml --genesis-file=ibft2Genesis.json --min-gas-price=0 --miner-enabled --miner-coinbase=0xC3D693fBE006154eF80C288DB527FaC4bd38ca09 --logging=debug
```

At first, you will see your node connect to the GBBP but then receive a request to disconnect because it is unknown
```
Received Wire DISCONNECT (UNKNOWN) from peer: PeerInfo{version=5, clientId='besu/v20.10.0/linux-x86_64/oracle_openjdk-java-11', capabilities=[eth/62, eth/63, eth/64, IBF/1], port=30303, nodeId=0x45f5f4a243fe851b025d622140f92d645bc04a0eb67589c4d6a21a5f9f367e600637d83546c3cbf9ccfa2fae072a1fa08e236d222b3262a685c15225540df2ee}.
```
Your node will connect properly once your node has been added to the GBBP permissioning system.  

#### To connect, send Mark Waser the enode, public address and ip address shown when Besu is starting up ####

============================================================================

## OLD INSTRUCTIONS -- You probably do NOT want these ##

### Image for a GBA GBBP Node on a Raspberry Pi ###

The GBA GBBP node starts with a custom Ubuntu image for the Raspberry Pi that runs Ethereum clients as a boot service and automatically turns the Raspberry Pi 4 into a full Ethereum 1.0 node.  This image takes care of all the necessary steps, from setting up the environment to installing and running the Ethereum software as well as starting the blockchain synchronization.  The image also includes other components of the Ethereum ecosystem such as Status.im, Raiden, IPFS, Swarm and Vipnode. 

All you will need to do is edit a few customization files and then add the necessary GBA GBBP files.

We use a custom Ubuntu image, since the standard Raspbian Pi OS is still 32 bits and suffers from various memory issues when running Ethereum clients.

#### Main features ####
*    Based on Ubuntu 20.04 64bit
*    Automatic USB disk partitioning and formatting if USB disk is used (optional)
*    Adds swap memory (ZRAM kernel module + a swap file) based on Armbian work
*    Changes the hostname to something like “ethnode-e2a3e6fe” based on MAC hash
*    Runs software as a systemd service and starts syncing the Blockchain
*    Includes an APT repository for installing and upgrading Ethereum software
*    Includes a monitoring dashboard based on Grafana / Prometheus

#### Software included ####
*    Geth: 1.9.13 (official binary)
*    Parity: 2.7.2 (cross compiled)
*    Nethermind: 1.8.28 (cross compiled)
*    Hyperledger Besu: 1.4.4 (compiled)

#### Ethereum framework ####
*    Swarm: 0.5.7 (official binary)
*    Raiden Network: 0.200.0~rc1 (official binary)
*    IPFS: 0.5.0 (official binary)
*    Statusd: 0.52.3 (compiled)
*    Vipnode: 2.3.3 (official binary)

## INSTALLATION GUIDE AND USAGE ##
NOTE: This is currently the BLEEDING EDGE installation.  Proceed at your own risk of serious frustration.  ;-)

#### To create a GBBP MicroSD card (if you haven't bought one from the GBA and had it sent to you): ####
1. Download and install the appropriate version of Etcher from www.canakit.com/tools/etcher
2. Download the latest release of the RaspberryPi Ubuntu software from https://ethraspbian.com/downloads/ubuntu-20.04-preinstalled-server-arm64+raspi-eth1.img.zip.
3. Unzip the file.
3. Run Etcher and select the unzipped .img image file.
4. Attach your microSD card to your computer.  Etcher should detect it and select it automatically BUT ensure that the correct drive is selected.
5. Click flash.  Etcher will automatically (re)format the card before writing and verifying the image.

#### Modify the MicroSD card (this will not be necessary in the future as your wifi-parameters will be able to be updated via a thumb-drive)
1. You will see a new system-boot drive and a new USB drive.  The former is the Ubuntu /boot/firmware partition (the 1st partition
on the SD card) used by the Ubuntu boot process.  The latter will likely give messages that it needs to be formatted.  Do NOT do so. 
2. Read the README file on system-boot drive.
3. Modify the network-config file for your wifi.

#### It is recommended that your test your Raspberry Pi assembly with the NOOBS MicroSD card first. #### 

1. With the Raspberry Pi powered down, replace the NOOBS MicroSD card with the 256GB GBBP MicroSD card 

2. Power on the Raspberry Pi

The Ubuntu OS will boot up in less than one minute but you will need to wait approximately 10 minutes in order to allow the script to perform the necessary tasks to turn the device into an Ethereum node and reboot the Raspberry.

Currently, you will be running Geth as the default client syncing to the Ethereum main net

3. Log in

You can log in through SSH or using the console (if you have a monitor and keyboard attached)
```
User: ethereum
Password: ethereum
```
You will be prompted to change the password on first login, so you will need to login twice.

4. Getting console output

You can see what’s happening in the background by typing:
```
sudo tail -f /var/log/syslog
```
Congratulations. You are now running a full Ethereum node on your Raspberry Pi 4.

5. Syncing the Blockchain

Syncing to the Ethereum main net would take a few days depending on several factors but you could expect up to about 5-7 days -- but you don't want to do this.  Syncing to the GBBP is much faster.

6. Included are 3 monitoring dashboards based on Prometheus/Grafana in order to monitor the node and clients’ data. You can access through your web browser:
```
URL: http://your_raspberrypi_IP:3000
User: admin
Password: ethereum
```

7. Changing parameters

Clients’ config files are currently located in the /etc/ethereum/ directory. You can edit these files and restart the systemd service in order for the changes to take effect. 

Blockchain clients’ data is stored on the ethereum home account as follows (note the dot before the directory name):
  /home/ethereum/.geth or /home/ethereum/.besu
  
8.  Find your enode address and your public and private keys and save them in a safe place.  Import a new account into metamask using your private key.  If you are a validator, you will need this to vote on adding or removing validators.

9.  Switching clients

All clients run as a systemd service. This is important because in case of some problem arises the system will respawn the process automatically.

Currently the client Geth runs by default so, to switch to Besu, you need to stop and disable Geth.
```
sudo systemctl stop geth && sudo systemctl disable geth
```

Next, save the current Ethereum mainnet config files and then replace them with the GBBP config.toml & ibft2Genesis.json files.  You will also want to create a bob (or whatever name you choose) data directory and add the file static-nodes.json to it.

Eventually, you will run Besu as a system by enabling and starting with
```
 sudo systemctl enable besu && sudo systemctl start besu
```

For the time being, we will run it with the command line
```
bin/besu --data-path=bob --config-file=config.toml --genesis-file=ibft2Genesis.json --min-gas-price=0 --miner-enabled --miner-coinbase=0xC3D693fBE006154eF80C288DB527FaC4bd38ca09 --logging=debug
```

At first, you will see your node connect to the GBBP but then receive a request to disconnect because it is unknown
```
Received Wire DISCONNECT (UNKNOWN) from peer: PeerInfo{version=5, clientId='besu/v20.10.0/linux-x86_64/oracle_openjdk-java-11', capabilities=[eth/62, eth/63, eth/64, IBF/1], port=30303, nodeId=0x45f5f4a243fe851b025d622140f92d645bc04a0eb67589c4d6a21a5f9f367e600637d83546c3cbf9ccfa2fae072a1fa08e236d222b3262a685c15225540df2ee}.
```
Your node will connect properly once your node has been added to the GBBP permissioning system.
