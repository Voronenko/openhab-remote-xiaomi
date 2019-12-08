#!/bin/sh

# tap0 | 1500 | 1573 | 192.168.1.246 | 255.255.255.0 | init
echo "$1 | $2 | $3 | $4 | $5 | $6"

OBTAINED_IP=$4

if ip link show tap0 | grep "master br0" ; then
    echo "Tap0 is already part of the bridge, skipping"
else
    echo "Adding Tap0 to bridge"
    ifconfig $1 $4 promisc up
    ip link set tap0 master br0
    ip addr add $OBTAINED_IP/32 dev br0
    ip route add 192.168.1.0/24 via $OBTAINED_IP dev br0    
fi

