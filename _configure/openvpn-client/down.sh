#!/bin/sh

if ip link show tap0 | grep "master br0" ; then
    echo "Unbinding interface from bridge"
    ip link set tap0 nomaster || true
else
    echo "Tap0 is not part of the bridge"
fi