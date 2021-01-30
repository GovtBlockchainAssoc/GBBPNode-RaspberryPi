# GBBPNode-RaspberryPi
Image for a GBA GBBP Node on a Raspberry Pi

Ethereum on ARM for Raspberry Pi 4 is a custom Linux image for the device that runs Ethereum clients as a boot service and automatically turns the Raspberry Pi 4 into a full Ethereum 1.0 node. Images take care of all the necessary steps, from setting up the environment to installing and running the Ethereum software as well as starting the blockchain synchronization.  The image also includes other components of the Ethereum ecosystem such as Status.im, Raiden, IPFS, Swarm and Vipnode as well as GBA customizations.

Since Raspbian OS is still 32 bits, it is necessary to switch to a native 64 bits OS (Ubuntu 20.04) to handle various memory issues.

Main features
    Based on Ubuntu 20.04 64bit
    Automatic USB disk partitioning and formatting if USB disk is used
    Adds swap memory (ZRAM kernel module + a swap file) based on Armbian work
    Changes the hostname to something like “ethnode-e2a3e6fe” based on MAC hash
    Runs software as a systemd service and starts syncing the Blockchain
    Includes an APT repository for installing and upgrading Ethereum software
    Includes a monitoring dashboard based on Grafana / Prometheus

Software included
    Geth: 1.9.13 (official binary)
    Parity: 2.7.2 (cross compiled)
    Nethermind: 1.8.28 (cross compiled)
    Hyperledger Besu: 1.4.4 (compiled)

Ethereum framework
    Swarm [14]: 0.5.7 (official binary)
    Raiden Network [15]: 0.200.0~rc1 (official binary)
    IPFS [16]: 0.5.0 (official binary)
    Statusd [17]: 0.52.3 (compiled)
    Vipnode [18]: 2.3.3 (official binary)

Recommended hardware and setup
    Raspberry 4-4GB (recommended version is the CanaKit Raspberry Pi 4 4GB Starter Kit – 4GB RAM which can be purchased from Amazon.com for USD $99.99
         (https://www.amazon.com/gp/product/B07V5JTMV9/ref=ppx_yo_dt_b_asin_title_o00_s00).  WARNING: Do NOT get a version without a fan!
    MicroSD Card (256 GB Class 10 minimun)
    30303 Port forwarding (If you don’t know how to do this, google “port forwarding” followed by your ISP and/or router model. Check with http://portquiz.net:30303/)
    USB keyboard, Monitor and HDMI cable (micro-HDMI) (Optional)
    
INSTALLATION GUIDE AND USAGE
NOTE: This is currently the BLEEDING EDGE installation.  Proceed at your own risk of serious frustration.  ;-)

It is recommended that your test your Raspberry Pi assembly with the NOOBS MicroSD card first.

1.- With the Raspberry Pi powered down, replace the NOOBS MicroSD card with the 256GB MicroSD card with the GBA software 

2.- Power on the Raspberry Pi

The Ubuntu OS will boot up in less than one minute but you will need to wait approximately 10 minutes in order to allow the script to perform the necessary tasks to turn the device into an Ethereum node and reboot the Raspberry.

Currently, you will be running Geth as the default client syncing to the Ethereum main net

3.- Log in

You can log in through SSH or using the console (if you have a monitor and keyboard attached)

User: ethereum
Password: ethereum

You will be prompted to change the password on first login, so you will need to login twice.

4.- Getting console output

You can see what’s happening in the background by typing:

sudo tail -f /var/log/syslog

Congratulations. You are now running a full Ethereum node on your Raspberry Pi 4.

Syncing the Blockchain

Syncing to the Ethereum main net would take a few days depending on several factors but you can expect up to about 5-7 days.  Syncing to the GBBP is much faster.

Included are 3 monitoring dashboards based on Prometheus/Grafana in order to monitor the node and clients’ data. You can access through your web browser:

URL: http://your_raspberrypi_IP:3000
User: admin
Password: ethereum

5.  Switching clients

All clients run as a systemd service. This is important because in case of some problem arises the system will respawn the process automatically.

Currently Geth runs by default so, to switch to other clients (from Geth to Besu), you need to stop and disable Geth first and enable and start Besu:
  sudo systemctl stop geth && sudo systemctl disable geth
  sudo systemctl enable besu && sudo systemctl start besu

6. Changing parameters

Clients’ config files are currently located in the /etc/ethereum/ directory. You can edit these files and restart the systemd service in order for the changes to take effect. GBBP Besu config files are stored in the /etc/besu/backup.
Blockchain clients’ data is stored on the ethereum home account as follows (note the dot before the directory name):
  /home/ethereum/.geth or /home/ethereum/.besu
