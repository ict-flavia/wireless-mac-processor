#! /bin/sh

if [ $# -lt 1 ]; then
	echo -e "usage: $0 <AP-SSID> <IP-ADDR> <RATE> <FIXED> <POWER>"
	exit
fi

essid=$1
ip_addr=$2
rate=$3
fixed=$4
power=$5

dev='wlan0'


#set -x

killall -9 wpa_supplicant
killall -9 udhcpc
echo "" > /etc/resolv.conf

#killall bytecode-manager
#rmmod b43
#sleep 1 
#insmod b43 qos=0
#sleep 1

/sbin/ifconfig $dev down
/sbin/ifconfig $dev up $ip_addr
/usr/sbin/iwconfig $dev essid $essid

#/etc/init.d/bytecode-manager start

if [ $rate -ne 0 ]; then
        if [ $fixed -eq 1 ]; then
                /usr/sbin/iwconfig $dev rate $rate'M' fixed
        else
                /usr/sbin/iwconfig $dev rate $rate'M'
        fi
fi

if [ $power -ne 0 ]; then
        /usr/sbin/iwconfig $dev txpower $power'dbm'
fi


#set +x
