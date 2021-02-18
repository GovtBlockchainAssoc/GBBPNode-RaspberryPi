# GBBPNode-RaspberryPi

## Recommended hardware and setup ##
1.    Raspberry 4 (or later) with 4GB RAM (or more)
    	current recommended version is the CanaKit Raspberry Pi 4 4GB Starter Kit – 4GB RAM  
	available from Amazon.com for USD $99.99 (https://www.amazon.com/gp/product/B07V5JTMV9/ref=ppx_yo_dt_b_asin_title_o00_s00)  
	WARNING: Do NOT get a version without a fan!
2.    MicroSD Card (256 GB Class 10 minimun)  
	 * 256GB MicroSD cards pre-loaded with the GBBP Node software can be ordered at cost from https://www.gbaglobal.org/gbbp-sd/  
	 * If you wish to buy and set up your own, the GBA recommends a 256GB or larger card in the $25-35 range  
	  (e.g. https://www.amazon.com/Micro-Center-256GB-Adapter-Memory/dp/B07K81C9XN/ref=sr_1_7_sspa)  
	  WARNING: There are off-brand cards with 1TB storage at cheaper prices, but the reviews are terrible and they are NOT recommended
3.    30303 Port forwarding  
	* Find instructions for your router by Googling “port forwarding” followed by your ISP and/or router model.  
	* Check for success by pointing a web browser at http://portquiz.net:30303/  
*    (optional) USB keyboard, Monitor (or HDMI-equipped TV) and HDMI cable (micro-HDMI)
*    You will also (temporarily) need your usual computer (Windows, Mac or Linux)

## Assemble your Raspberry Pi ###
The instructions in the included Quick-Start Guide (https://www.canakit.com/pi) are good but the video at https://www.youtube.com/watch?v=7rcNjgVgc-I is excellent.  
First time assembly is likely to take half an hour but could be done in ten minutes once you know what you are doing.  

#### If you have a monitor and mouse, it is STRONGLY recommended that the provided NOOBS MicroSD card be used to test that the Raspberry Pi is functioning correctly  

## Install Ubuntu 20.04.02 on the MicroSD card
#### Follow these instructions from https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview
1.	Insert MicroSD card into the USB reader provided with your Raspberry Pi and then into your usual computer's USB port
2.	Download the Imager
3.	Run the Imager
4.	In the Imager, Choose OS, select Ubuntu then select from the next pop-up menu 
	```"Server 20.04.2 LTS (RPi 3/4/4000) 64-bit server OS with long-term support for arm64 architectures```
         (possibly the 5th entry down the list)
5.	In the Imager, select the SD card drive
6.	Click on “WRITE” and wait for the magic to happen… (This magic might take a few minutes)

#### Unless you have a wired Ethernet connection, configure your wireless information (network name/SSID & password) using the same tutorial
1. With the SD card still inserted in your laptop, open a file manager and locate the “system-boot” partition on the card. It contains initial configuration files that will be loaded during the first boot.
2. Edit the network-config file to add your Wi-Fi credentials. An example is already included in the file, you can simply adapt it.   
To do so, uncomment (remove the “#” at the beginning) and edit the following lines:
``` 
wifis:
  wlan0:
  dhcp4: true
  optional: true
  access-points:
    <wifi network name>:
      password: "<wifi password>" 
```
For example:
```
wifis:
  wlan0:
  dhcp4: true
  optional: true
  access-points:
    "home network":
      password: "123456789"
```
Note 1: The network name and password must be enclosed in quotation marks.  
Note 2: During the first boot, your Raspberry Pi will try to connect to this network. It will fail the first time around. Simply reboot sudo reboot and it will work.  
Note 3: There may be circumstances in the future where a static IP is helpful.  If so, follow the steps at the bottom of these instructions below.  

## Extract the MicroSD reader from your usual machine.  Extract the microSD card from the reader
## Insert the MicroSD card into your Raspberry Pi and power the Pi up. 

### If you don't have a keyboard, monitor and mouse (or want network access), you have two options 
1.  Install PuTTY (https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on your regular machine to ssh to a command line interface on your Pi (easiest)
2.  Follow the steps at the bottom of these instructions below to install a lightweight GUI and accessible via Windows Remote Desktop or VNC to connect to the Pi
* The default system name is ubuntu (you can either connect to this name or find the IP address on your network equipment and conect to that).

### If you are having problems connecting to your wi-fi
Follow one set of the instructions at https://smallbusiness.chron.com/run-command-startup-linux-27796.html to run the following command at boot up
```
sudo dhcpcd -4 
```
(if someone could tell me which method is best, I'll put that advice here)
##### If trying to use network access, often the Pi will connect about 25% of the time.  If this doesn't occur, you will either need to use a monitor and keyboard or use your standard non-Windows machine to edit the second partition of the microSD card (Windows WSL will not be able to read it -- though it is promised in the next version)

## Log into Ubuntu on your Raspberry Pi 
1. The default username is ubuntu and password is ubuntu
2. You will be prompted to change the password.  Write it down and store it in a safe place.
3. If you are connected remotely, the session will then close and you will have to reconnect.
4. Login with ubuntu as the username and the new password.

## Install the Java JDK ###
Issue the following commands from the command line:
```
sudo apt install openjdk-11-jre-headless
```
(click Y to proceed, should take about 60 seconds)
```
sudo apt install unzip
```
(should take about 10 seconds)
```
sudo apt update
```
(should take about 10 seconds)
```
sudo apt upgrade
```
(click Y to proceed, should take about 60 seconds)
```
sudo reboot
```
(should take about 60 seconds, remote sessions will need to reconnect)


## Install Besu 
1. Download the Besu packaged binaries from https://github.com/hyperledger/besu/releases.
2. Unpack the downloaded files and change into the besu-<release> directory.
3. Display Besu command line help to confirm installation:
```bin/besu --help```

## To complete and run your GBBP Node 
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


At first, you will see your node connect to the GBBP but then receive a request to disconnect because it is unknown
```
Received Wire DISCONNECT (UNKNOWN) from peer: PeerInfo{version=5, clientId='besu/v20.10.0/linux-x86_64/oracle_openjdk-java-11', capabilities=[eth/62, eth/63, eth/64, IBF/1], port=30303, nodeId=0x45f5f4a243fe851b025d622140f92d645bc04a0eb67589c4d6a21a5f9f367e600637d83546c3cbf9ccfa2fae072a1fa08e236d222b3262a685c15225540df2ee}.
```
Your node will connect properly once your node has been added to the GBBP permissioning system.
