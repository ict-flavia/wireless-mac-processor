#! /bin/sh

if [ $# -lt 1 ]; then
	echo -e "usage: $0 <AP-SSID> <IP-ADDR>"
	exit
fi

essid=$1
ip_addr=$2

set -x

killall -9 wpa_supplicant
killall -9 udhcpc
echo "" > /etc/resolv.conf

#killall bytecode-manager
#rmmod b43
#sleep 1 
#insmod b43 qos=0
#sleep 1

/sbin/ifconfig wlan0 down
/sbin/ifconfig wlan0 up $ip_addr
/usr/sbin/iwconfig wlan0 essid $essid

#/etc/init.d/bytecode-manager start

set +x
