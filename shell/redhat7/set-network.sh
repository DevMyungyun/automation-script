#!/bin/bash
STATIC_IP=$1
GATEWAY_IP=$2
NETWORK_DEVICE=$3
DNS_1="8.8.8.8"
DNS_2="8.8.4.4"

sudo sed -i 's/BOOTPROTO/#BOOTPROTO/g'  /etc/sysconfig/network-scripts/ifcfg-$NETWORK_DEVICE

sudo cat << EOF >> /etc/sysconfig/network-scripts/ifcfg-$NETWORK_DEVICE
BOOTPROTO="static"
PEERROUTES=yes
IPADDR=$STATIC_IP
NETMASK=255.255.255.0
GATEWAY=$GATEWAY_IP
DNS1 = $DNS_1
DNS2 = $DNS_2
USERRCTL=no
NM_CONTROLLED=yes
EOF

sudo systemctl restart network

