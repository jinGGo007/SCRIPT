#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

MYIP=$(wget -qO- icanhazip.com);
echo "Checking Vps"
sleep 2
clear

#Welcome Note
echo -e "============================================="
echo -e " ${green} WELCOME TO JINGGO SCRIPT${NC}"
echo -e "============================================="
sleep 2

#Install Update
echo -e "============================================="
echo -e " ${green} UPDATE && UPGRADE PROCESS${NC}"
echo -e "============================================="
apt -y update 
apt install -y bzip2 gzip coreutils screen curl
apt install -y dos2unix && dos2unix running
sleep 2
clear

# Disable IPv6
echo -e "============================================="
echo -e " ${green} DISABLE IPV6${NC}"
echo -e "============================================="
sleep 2
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
echo -e "net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sleep 2
clear

#license
echo -e "============================================="
echo -e " ${green} SCRIPT LICENSE${NC}"
echo -e "============================================="
sleep 2
read -p "SILA MASUKKAN LESEN SCRIPT: " pwd
if test $pwd == "jinggo007"; then
echo "Password Accepted!"
else
echo "Password Incorrect!"
rm -f setup.sh
sleep 2
exit
fi
clear

# Subdomain Settings
echo -e "============================================="
echo -e "${green} DOMAIN INPUT${NC} "
echo -e "============================================="
sleep 2
mkdir /etc/v2ray
mkdir /etc/xray
mkdir /var/lib/premium-script;
clear
echo -e ""
echo -e "${green}MASUKKAN DOMAIN ANDA YANG TELAH DI POINT KE IP ANDA${NC}"
read -rp "    Enter your Domain/Host: " -e host
ip=$(wget -qO- ipv4.icanhazip.com)
host_ip=$(ping "${host}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')
if [[ ${host_ip} == "${ip}" ]]; then
	echo -e ""
	echo -e "${green}HOST/DOMAIN MATCHED..INSTALLATION WILL CONTINUE${NC}"
	echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
    echo "$host" >> /etc/v2ray/domain
    echo "$host" > /root/domain
	sleep 2
	clear
else
	echo -e "${green}HOST/DOMAIN NOT MATCHED..INSTALLATION WILL TERMINATED${NC}"
	echo -e ""
    rm -f setup.sh
    exit 1
fi
sleep 1


#install ssh ovpn
echo -e "============================================="
echo -e " ${green} INSTALLING SSH && OVPN && WS ${NC}"
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/V5/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
sleep 2
clear

#install Xray
echo -e "============================================="
echo -e " ${green} INSTALLING XRAY${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/XRAY/install-xray.sh && chmod +x install-xray.sh && screen -S v2ray ./install-xray.sh
sleep 2
clear

#install trgo
echo -e "============================================="
echo -e " ${green} INSTALLING TRGO${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/SCRIPT/main/TRGO/trgo.sh && chmod +x trgo.sh && screen -S v2ray ./trgo.sh
sleep 2
clear

#install ohp
echo -e "============================================="
echo -e " ${green} INSTALLING OHP${NC} "
echo -e "============================================="
sleep 2
wget https://raw.githubusercontent.com/jinGGo007/PRIVATE/main/OHP/ohp.sh && chmod +x ohp.sh && ./ohp.sh
sleep 2
clear

rm -f /root/ssh-vpn.sh
rm -f /root/ohp.sh

clear
echo " "
echo "INSTALLATION COMPLETE!!"
echo " "
echo "====================== JINGGO AUTOSCRIPT VERSION 6 =======================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 442"  | tee -a log-install.txt
echo "   - Stunnel4                : 444, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - SSH WS/OVPN WS          : 2082, 2095"  | tee -a log-install.txt
echo "   - DROPBEAR OHP            : 8010"  | tee -a log-install.txt
echo "   - OPENVPN OHP             : 8000"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 5443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 6443"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 7443"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 8443"  | tee -a log-install.txt
echo "   - XRAY DIRECT             : 6769"  | tee -a log-install.txt
echo "   - XRAY VLESS GRPC         : 6969"  | tee -a log-install.txt
echo "   - Trojan                  : 9443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/MALAYSIA (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +8" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Dev/Main                : Horas/MD"  | tee -a log-install.txt
echo "   - Modded by               : JINGGO007"  | tee -a log-install.txt
echo "   - Telegram                : t.me/jinggo007"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "========================== SCRIPT BY JINGGO007 =====================" | tee -a log-install.txt
echo ""
sleep 1
rm -f setup.sh
read -n 1 -r -s -p $'Press any key to reboot...\n';reboot
