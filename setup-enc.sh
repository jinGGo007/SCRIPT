#!/bin/bash

sudo apt update
sudo apt install build-essential
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neurobin/ppa -y
sudo apt install shc
wget -O /usr/bin/shco https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/shco.sh ; chmod +x /usr/bin/shco ; mkdir /root/shc
cd
wget -O /usr/bin/enc https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/enc.sh ; chmod +x /usr/bin/enc 
clear
rm -f setup-enc.sh
