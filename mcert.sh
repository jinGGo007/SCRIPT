#!/bin/bash

# Install OpenVPN
apt update
apt install -y openvpn
wget -q "https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/EasyRSA-3.0.8.tgz"
tar xvf EasyRSA-3.0.8.tgz
rm EasyRSA-3.0.8.tgz
mv EasyRSA-3.0.8 /etc/openvpn/easy-rsa
cp /etc/openvpn/easy-rsa/vars.example /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_COUNTRY\t"US"/set_var EASYRSA_REQ_COUNTRY\t"MY"/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_PROVINCE\t"California"/set_var EASYRSA_REQ_PROVINCE\t"WP"/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_CITY\t"San Francisco"/set_var EASYRSA_REQ_CITY\t"Kuala Lumpur"/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_ORG\t"Copyleft Certificate Co"/set_var EASYRSA_REQ_ORG\t"JINGGOVPN"/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_EMAIL\t"me@example.net"/set_var EASYRSA_REQ_EMAIL\t"jinggovpn@gmail.com"/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_OU\t\t"My Organizational Unit"/set_var EASYRSA_REQ_OU\t\t"JINGGOVPN Server"/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_CA_EXPIRE\t3650/set_var EASYRSA_CA_EXPIRE\t3650/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_CERT_EXPIRE\t825/set_var EASYRSA_CERT_EXPIRE\t3650/g' /etc/openvpn/easy-rsa/vars
sed -i 's/#set_var EASYRSA_REQ_CN\t\t"ChangeMe"/set_var EASYRSA_REQ_CN\t\t"JINGGOVPN"/g' /etc/openvpn/easy-rsa/vars
cd /etc/openvpn/easy-rsa
./easyrsa --batch init-pki
./easyrsa --batch build-ca nopass
./easyrsa gen-dh
./easyrsa build-server-full server nopass

cd
mkdir /etc/openvpn/server
cp /etc/openvpn/easy-rsa/pki/issued/server.crt /etc/openvpn/server/
cp /etc/openvpn/easy-rsa/pki/ca.crt /etc/openvpn/server/
cp /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn/server/
cp /etc/openvpn/easy-rsa/pki/private/ca.key /etc/openvpn/server/
cp /etc/openvpn/easy-rsa/pki/private/server.key /etc/openvpn/server/

# generate key for tls-auth
openvpn --genkey --secret /etc/openvpn/server/ta.key

# generate server-tcp.conf
cat > /etc/openvpn/server/server-tcp-1194.conf <<-END
port 1194
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
verify-client-cert none
username-as-common-name
server 10.6.0.0 255.255.0.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
keepalive 5 30
cipher none
ncp-disable
auth none
comp-lzo
persist-key
persist-tun
status openvpn-tcp.log
verb 3
END

# generate server-udp.conf
cat > /etc/openvpn/server/server-udp-2200.conf <<-END
port 2200
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
verify-client-cert none
username-as-common-name
server 10.7.0.0 255.255.0.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
keepalive 5 30
cipher none
ncp-disable
auth none
comp-lzo
persist-key
persist-tun
status openvpn-udp.log
verb 3
explicit-exit-notify
END
