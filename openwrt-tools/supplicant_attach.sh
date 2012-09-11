#! /bin/sh

if [ $# -lt 1 ]; then
	echo -e "usage: $0 <AP-SSID>"
	exit
fi
essid=$1

set -x

killall -9 wpa_supplicant
killall -9 udhcpc
echo "" > /etc/resolv.conf

#killall bytecode-manager
#rmmod b43
#sleep 1 
#insmod b43 qos=0
#sleep 1

#iwconfig wlan0 essid $essid

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

#/etc/init.d/bytecode-manager start

set +x
