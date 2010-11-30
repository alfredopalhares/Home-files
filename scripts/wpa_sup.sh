#!/bin/sh
# Simple script that connects o a wireless network

#define the interface
ETH=wlan0
CFG=/home/masterkorp/scripts/ismai.cfg

# terminate current network
wpa_cli terminate

# Connect the the network
sleep 5
wpa_supplicant -B -d -Dwext -i $ETH -c $CFG

sleep 5
# kill any other DHCP services
dhcpcd -x $ETH 

# Start new dhcp request
dhcpcd $ETH
