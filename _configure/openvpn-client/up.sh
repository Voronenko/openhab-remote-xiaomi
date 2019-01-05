#!/bin/sh

if ip link show tap0 | grep "master br0" ; then
    echo "Tap0 is already part of the bridge, skipping"
else
    echo "Adding Tap0 to bridge"
    ip link set tap0 master br0    
fi
