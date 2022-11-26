STATIC_IP_LEVEL3=0
STATIC_IP_LEVEL4=10

sudo apt-get upgrade -y
sudo apt-get install nmcli -y

# Check device name
nmcli connection show

# Create a Static connection
sudo nmcli con add type ethernet con-name 'static-ip' ifname enp0s3 ipv4.method manual ipv4.addresses 192.168.1.102/24 gw4 192.168.1.1

# Add DNS IP to static-ip
sudo nmcli con mod static-ip ipv4.dns 192.168.1.1

# Activate the Static connection
sudo nmcli con up id 'static-ip'