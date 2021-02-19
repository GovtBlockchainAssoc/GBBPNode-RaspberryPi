## the following script installs besu, sets it up to run the Government 
## Business Blockchain Platform, and configures a systemd service to
## start it on boot

## tested on Ubuntu server 20.04 64-bit
## this script needs sudo to run

apt update
apt upgrade -y
apt install unzip
apt install openjdk-11-jre-headless
wget -O /usr/local/besu.zip \
    https://dl.bintray.com/hyperledger-org/besu-repo/besu-20.10.4.zip
unzip /usr/local/besu.zip -x /usr/local
/usr/local/besu-20.10.4/bin/besu --help

wget -O /usr/local/besu-20.10.4/config.toml \
    https://raw.githubusercontent.com/GovtBlockchainAssoc/GBBPNode-RaspberryPi/main/config.toml

wget -O /usr/local/besu-20.10.4/ibft2Genesis.json \
    https://raw.githubusercontent.com/GovtBlockchainAssoc/GBBPNode-RaspberryPi/main/ibft2Genesis.json

wget -O /usr/local/besu-20.10.4/gbbp/static-nodes.json \
    https://raw.githubusercontent.com/GovtBlockchainAssoc/GBBPNode-RaspberryPi/main/static-nodes.json

wget -O /etc/systemd/system/gbbp.service \
    https://raw.githubusercontent.com/Skyler827/GBBPNode-RaspberryPi/main/gbbp.service

systemctl enable gbbp.service
systemctl start gbbp.service
