STATIC_IP=$1
GATEWAY_IP=$2
DNS_1=$3
DNS_2=$4
NETWORK_DEVICE=$5

echo "Specified Arguments >>>>>>>>>>>>>>>>"
echo "STATIC_IP         : $STATIC_IP"
echo "GATEWAY_IP        : $GATEWAY_IP"
echo "NETWORK_DEVICE    : $NETWORK_DEVICE"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ""
echo ""

sudo mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.org
sudo cat > /etc/netplan/00-installer-config.yaml << EOF
network:
    version: 2
    renderer: networkd
    ethernets:
        $NETWORK_DEVICE:
            addresses:
                - "$STATIC_IP/24"
            nameservers:
                addresses: [$DNS_1, $DNS_2]
            routes:
                - to: default
                  via: $GATEWAY_IP
EOF

sudo netplan apply 