#!/bin/sh
# Simple script that connects o a wireless network

#define the interface
eth=wlan0
cfg=/home/masterkorp/scripts/ismai.cfg

# terminate current network
wpa_cli terminate

# Connect the the network
sleep 5
wpa_supplicant -B -d -Dwext -i $eth -c $cfg

sleep 5
# kill any other DHCP services
dhcpcd -x $eth 

# Start new dhcp request
dhcpcd $eth
