STATIC_IP=$0
GATEWAY_IP=$1
DNS_IPS=$2
NETWORK_DEVICE=$3

echo "Specified Arguments >>>>>>>>>>>>>>>>"
echo "STATIC_IP         : $STATIC_IP"
echo "GATEWAY_IP        : $GATEWAY_IP"
echo "NETWORK_DEVICE    : $NETWORK_DEVICE"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ""
echo ""

sudo apt-get update && apt-get upgrade -y
sudo apt-get install net-tools network-manager -y
sudo systemctl start NetworkManager.service 
sudo systemctl enable NetworkManager.service

# Check device name
nmcli connection show

# Create a Static connection
sudo nmcli con add type ethernet con-name "static-ip" ifname $NETWORK_DEVICE ipv4.method manual ipv4.addresses "$STATIC_IP/24" gw4 $GATEWAY_IP

# Add DNS IP to static-ip
sudo nmcli con mod static-ip ipv4.dns $GATEWAY_IP

# Activate the Static connection
sudo nmcli con up id "static-ip"