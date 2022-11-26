IP_LEVEL1_3=$1
IP_LEVEL4=$2

sed -i 's/BOOTPROTO/#BOOTPROTO/g'  /etc/sysconfig/network-scripts/ifcfg-ens33

cat << EOF >> /etc/sysconfig/network-scripts/ifcfg-ens33
BOOTPROTO="static"
PEERROUTES=yes
IPADDR=$IP_LEVEL1_3.$IP_LEVEL4
NETMASK=255.255.255.0
GATEWAY=$IP_LEVEL1_3.2
DNS1 = 8.8.8.8
DNS2 = 8.8.4.4
USERRCTL=no
NM_CONTROLLED=yes
EOF

systemctl restart network

