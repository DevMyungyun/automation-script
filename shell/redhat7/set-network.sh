#!/bin/bash
DNS_1="8.8.8.8"
DNS_2="8.8.4.4"

# Options from Command
function usage()
{
    cat <<EOM
Usage: $0 [options] <url>
Options:
 -ND, --network-device  Specify which network device will be used
 -I, --ip-address       Specify which IP address will be configured
 -D1, --dns-1           Specify which DNS 1 address will be configured
 -D2, --dns-2           Specify which DNS 2 address will be configured
EOM

    exit 1
}

function set_options()
{
    # --options에는 short option을 지정한다
    # --longoptions에는 말그대로 long option을 지정한다
    # --name은 도움말에 출력할 프로그램 이름이다
    # -- 이후에는 사용자가 입력한 문자열이 입력된다
    arguments=$(getopt --options ND:I:D1:D2: \
                       --longoptions network-device:,ip-address:,dns-1,dns-2 \
                       --name $(basename $0) \
                       -- "$@")

    eval set -- "$arguments"

    while true
    do
        case "$1" in
            -ND | --network-device)
                NETWORK_DEVICE=$2
                shift 4
                ;;
            -I | --ip-address)
                IP_ADDRESS=$3
                shift 4
                ;;
            -D1 | --dns-1)
                DNS_1=$4
                shift 4
            ;;
            -D2 | --dns-2)
                DNS_2=$5
                shift 4
            ;;
            --)
                shift
                break
                ;;
            *)
                usage
                ;;
        esac
    done

    # 남아있는 인자 얻기, 남아있는 인자는 url이다
    shift $((OPTIND-1))
    url=$@
}

set_options "$@"

while getopts  ":net-device:ip:dns1:dns2:" option; do
  case $option in
    net-device ) NET_DEVICE=$OPTARG >&2
        echo "IP Address: $NET_DEVICE"
    ;;
    ip ) IP=$OPTARG >&2
        echo "IP Address: $IP"
    ;;
    dns1 ) DNS_1=$OPTARG
        echo "DNS1 address: $DNS_1"
    ;;
    dns2 ) DNS_2=$OPTARG
        echo "DNS2 address: $DNS_2"
    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
        echo -e "option requires an argument.\nUsage: $(basename $OPTARG) [-ND] [-I] [-D1] [-D2 arg]"
        exit 1
        ;;
  esac
done
shift "$(($OPTIND -1))"

echo $NETWORK_DEVICE
echo $IP_ADDRESS
echo $DNS_1
echo $DNS_2

sed -i 's/BOOTPROTO/#BOOTPROTO/g'  /etc/sysconfig/network-scripts/ifcfg-ens33

cat << EOF >> /etc/sysconfig/network-scripts/ifcfg-ens33
BOOTPROTO="static"
PEERROUTES=yes
IPADDR=$IP_LEVEL3.$IP_LEVEL4
NETMASK=255.255.255.0
GATEWAY=$IP_LEVEL1_3.2
DNS1 = $DNS_1
DNS2 = $DNS_2
USERRCTL=no
NM_CONTROLLED=yes
EOF

systemctl restart network

