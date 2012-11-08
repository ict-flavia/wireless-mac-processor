#! /bin/sh

if [ $# -lt 1 ]; then
	echo -e "usage: $0 <AP-SSID> <IP>"
	exit
fi
essid=$1
ip=$2
set -x

killall -9 wpa_supplicant
killall -9 udhcpc
echo "" > /etc/resolv.conf

echo "ctrl_interface=/var/run/wpa_supplicant
	network={  
        ssid=\"$essid\"
        scan_ssid=1
        key_mgmt=NONE
        }" > wpa_supp.conf
                        
wpa_supplicant -i wlan0 -c wpa_supp.conf &

hostname=$(cat /etc/config/system | grep hostname | awk '{ print $3}');
echo $hostname
udhcpc -i wlan0 -H w$hostname
/sbin/ifconfig wlan0 $ip
#/etc/init.d/bytecode-manager start

set +x
