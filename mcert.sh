#!/bin/bash

# Install OpenVPN
apt update
apt install -y openvpn
wget -q "https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/EasyRSA-3.0.8.tgz"
tar xvf EasyRSA-3.0.8.tgz
rm EasyRSA-3.0.8.tgz
mv EasyRSA-3.0.8 /etc/openvpn/server/easy-rsa
cp /etc/openvpn/server/easy-rsa/vars.example /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_COUNTRY\t"US"/set_var EASYRSA_REQ_COUNTRY\t"MY"/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_PROVINCE\t"California"/set_var EASYRSA_REQ_PROVINCE\t"WP"/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_CITY\t"San Francisco"/set_var EASYRSA_REQ_CITY\t"Kuala Lumpur"/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_ORG\t"Copyleft Certificate Co"/set_var EASYRSA_REQ_ORG\t"JINGGOVPN"/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_EMAIL\t"me@example.net"/set_var EASYRSA_REQ_EMAIL\t"johnlabu2801@gmail.com"/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_OU\t\t"My Organizational Unit"/set_var EASYRSA_REQ_OU\t\t"JINGGOVPN Server"/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_CA_EXPIRE\t3650/set_var EASYRSA_CA_EXPIRE\t3650/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_CERT_EXPIRE\t825/set_var EASYRSA_CERT_EXPIRE\t3650/g' /etc/openvpn/server/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_CN\t\t"ChangeMe"/set_var EASYRSA_REQ_CN\t\t"JINGGOVPN"/g' /etc/openvpn/server/easy-rsa/vars
cd /etc/openvpn/server/easy-rsa
./easyrsa --batch init-pki
./easyrsa --batch build-ca nopass
./easyrsa gen-dh
./easyrsa build-server-full server nopass
cd
mkdir /etc/openvpn/server
cp /etc/openvpn/server/easy-rsa/pki/issued/server.crt /etc/openvpn/server/server.crt
cp /etc/openvpn/server/easy-rsa/pki/ca.crt /etc/openvpn/server/ca.crt
cp /etc/openvpn/server/easy-rsa/pki/dh.pem /etc/openvpn/server/dh2048.pem
cp /etc/openvpn/server/easy-rsa/pki/private/server.key /etc/openvpn/server/server.key
wget -qO /etc/openvpn/server/server-udp-2200.conf "https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/server-udp-2200.conf"
wget -qO /etc/openvpn/server/server-tcp-1194.conf "https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/server-tcp-1194.conf"