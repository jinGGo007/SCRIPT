#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

cekxray="$(openssl x509 -dates -noout < /etc/v2ray/v2ray.crt)"                                      
expxray=$(echo "${cekxray}" | grep 'notAfter=' | cut -f2 -d=)

echo -e  "           AUTOSCRIPT LITE VERSION MODDED BY JINGGO007" | lolcat
echo -e  " "
echo -e  " ${green}EXP DATE CERT XRAY    :${NC} $expxray"
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}MAIN MENU${NC} "                                       
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " "
echo -e  " [  1 ] SSH & OPENVPN" 
echo -e  " [  2 ] V2RAY VMESS" 
echo -e  " [  3 ] V2RAY VLESS" 
echo -e  " [  4 ] TROJAN GFW" 
echo -e  " [  5 ] XRAY VLESS DIRECT"  
echo -e  " [  6 ] XRAY VLESS GRPC" 
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════ "
echo -e  " ${green}SYSTEM MENU${NC} "       
echo -e  " ═════════════════════════════════════════════════════════════════ "                            
echo -e  "  "
echo -e  " [  7 ] ADD/CHANGE DOMAIN VPS"
echo -e  " [  8 ] CHANGE PORT SERVICE"
echo -e  " [  9 ] CHANGE DNS SERVER"
echo -e  " [ 10 ] RENEW V2RAY CERTIFICATION"
echo -e  " [ 11 ] WEBMIN MENU"
echo -e  " [ 12 ] CHECK RAM USAGE"
echo -e  " [ 13 ] REBOOT VPS"
echo -e  " [ 14 ] SPEEDTEST VPS"
echo -e  " [ 15 ] DISPLAY SYSTEM INFORMATION"
echo -e  " [ 16 ] INFO SCRIPT"
echo -e  " [ 17 ] CHECK SERVICE ERROR"
echo -e  "  "
echo -e  " ═════════════════════════════════════════════════════════════════" 
echo -e  " ${green}[  0 ] EXIT MENU${NC}  "
echo -e  " ═════════════════════════════════════════════════════════════════"
echo -e  "  "
echo -e "\e[1;31m"
read -p  "     Please select an option :  " menu
echo -e "\e[0m"
 case $menu in
   1)
   mssh
   ;;
   2)
   mvmess
   ;;
   3)
   mvless
   ;;
   4)
   mtrojan
   ;;
   5)
   mxray
   ;;
   6)
   mgrpc
   ;;
   7)
   add-host
   ;;
   8)
   change
   ;;
   9)
   mdns
   ;;
   10)
   recert-v2ray
   ;;
   11)
   wbmn
   ;;
   12)
   ram
   ;;
   13)
   reboot
   ;;
   14)
   speedtest
   ;;
   15)
   info
   ;;
   16)
   about
   ;;
   17)
   checksystem
   ;;
   0)
   sleep 0.5
   clear
   exit
   clear
   ;;
   *)
   echo -e "ERROR!! Please Enter an Correct Number"
   sleep 1
   clear
   menu
   ;;
   esac
