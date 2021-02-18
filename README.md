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

### Extract the MicroSD reader from your usual machine.  Extract the microSD card from the reader
## Insert the MicroSD card into your Raspberry Pi and power the Pi up. 

#### If you don't have a keyboard, monitor and mouse (or want network access), you have two options 
1.  Install PuTTY (https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on your regular machine to ssh to a command line interface on your Pi (easiest)
2.  Follow the steps at the bottom of these instructions below to install a lightweight GUI and accessible via Windows Remote Desktop or VNC to connect to the Pi
* The default system name is ubuntu (you can either connect to this name or find the IP address on your network equipment and conect to that).

#### If you are having problems connecting to your wi-fi
##### If trying to use network access, often the Pi will connect about 25% of the time allowing you to complete these instructions that way.  
##### If this doesn't occur, you will either need to use a monitor and keyboard or use your standard non-Windows machine to edit the second partition of the microSD card 
##### (Windows WSL will not be able to read it -- though it is promised in the next version of WSL and may be available now vai the Insiders Preview)
Follow one set of the instructions at https://smallbusiness.chron.com/run-command-startup-linux-27796.html to run the following command at boot up
```
sudo dhcpcd -4 
```
(if someone could tell me which method is best, I'll put that advice here)

## Log into Ubuntu on your Raspberry Pi 
1. The default username is ubuntu and password is ubuntu
2. You will be prompted to change the password.  Write it down and store it in a safe place.
3. If you are connected remotely, the session will then close and you will have to reconnect.
4. Login with ubuntu as the username and the new password.

## Install the Java JDK 
Issue the following commands from the command line:
```
sudo apt install openjdk-11-jre-headless
```
. . . (click Y to proceed, should take about 60 seconds)
```
sudo apt install unzip
```
 . . . (should take about 10 seconds)
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
Issue the following commands from the command line:
```
wget https://dl.bintray.com/hyperledger-org/besu-repo/besu-20.10.4.zip
```
	- (should take about 10 seconds)
```
unzip besu-20.10.4.zip
```
		- (should take 10 seconds)
```
cd besu-20.10.4/
bin/besu --help
```
 - should show output of help, this is to make sure everything is ok to this point)


## Finish loading the GBBP Node software
Issue the following commands from the command line:
```
wget https://raw.githubusercontent.com/GovtBlockchainAssoc/GBBPNode-RaspberryPi/main/config.toml
```
	[should take 1 second]
```
wget https://raw.githubusercontent.com/GovtBlockchainAssoc/GBBPNode-RaspberryPi/main/ibft2Genesis.json
```
	[should take 1 second]
```
mkdir gbbp
cd gbbp
wget https://raw.githubusercontent.com/GovtBlockchainAssoc/GBBPNode-RaspberryPi/main/static-nodes.json
```
	[should take 1 second]
```
cd ..
```
## Run Besu to initialize your GBBP Node configuration
Issue the following commands from the command line:
```
bin/besu --data-path=gbbp --config-file=config.toml --genesis-file=ibft2Genesis.json --min-gas-price=0 --miner-enabled --miner-coinbase=0xC3D693fBE006154eF80C288DB527FaC4bd38ca09 --logging=debug
```
After several seconds and several screenfuls, you will see HELLO, connect and disconnect messages in blue followed by endless waiting messages
```
Ctrl-C
```
this stops the execution of the Besu node and stops the scrolling so you can review it for the details needed to join the blockchain

## Find and upload  your GBBP Node configuration
1.  About 25 lines above the hello messages, find the folowing information lines
2021-02-18 09:41:24.182-05:00 | main | INFO  | DefaultP2PNetwork | Enode URL  
enode://8fe8ba6f6da225d6aec4ec06983607c9f5d6d86daa760277dace8acf62529a04448c1a68ff9f69c49d0cb1685ff5b93052d2e157acbb3240af5485f9f9796317@127.0.0.1:30303
2021-02-18 09:41:24.183-05:00 | main | INFO  | DefaultP2PNetwork | Node address 0xd4e26b34de495b4bab2de440202b16d40b21ed1e
2. Issue the following command from the command line to get your public ip address
```
wget  dig +short myip.opendns.com @resolver1.opendns.com
```
3. Enter you enode, ip address and node address in the spreadsheet at  
https://docs.google.com/spreadsheets/d/1BWuOzJKzfT9JG4MKBb8oNN365Wee8dWZLN3oVxbytDE/edit#gid=0

