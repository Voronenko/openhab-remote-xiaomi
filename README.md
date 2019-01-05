# openhab-remote-xiaomi
Notes on setup openhab  supporting receiving multicasts from remote xiaomi gateway endpoints

## Network setup

Xiaomi smarthome gateways after recent firmware update no longer provides REST interface for updates.
Instead, it provides updates purely in local network using multicast to group 224.0.0.50 and port 9898.

This requires us to 

a) Connect to remote site using L2 layer, using vpn that supports that scenario (for example openvpn)

b) As OpenHab does not support multicast listening on multiple interfaces, and 224.0.0.50 can't be routed
using igmpproxy, pimd or smcroute - the only choice is configuring Bridge Networking on opehab server,
combining local ethernet (eth0) together with VPN interface (tap0)

## Openhab Server - Bridge Networking 

Note, in some systems, like Raspbian necessary package might not be installed. Check additionally.

```sh

sudo apt-get install -y bridge-utils

```

`/etc/network/interfaces`

```conf

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

# The primary network interface - supress ip
auto eth0
iface eth0 inet manual

auto br0

iface br0 inet static

address 192.168.2.222
    netmask 255.255.255.0
    broadcast 192.168.2.0
    gateway 192.168.2.1
    dns-nameservers 8.8.8.8 
    bridge_ports eth0
    bridge_stp off
    bridge_fd 0
    bridge_maxwait 0

```

## Openhab Server - Openvpn Client

`/etc/openvpn/client.conf`

```conf

client

dev tap
;dev tun

;proto tcp
proto udp

remote your.openvpn.server 1194

resolv-retry infinite

nobind

# Downgrade privileges after initialization (non-Windows only)
;user nobody
;group nogroup

# Try to preserve some state across restarts.
persist-key
persist-tun

# SSL/TLS parms.
ca /etc/openvpn/client/ca.crt
cert /etc/openvpn/client/client.crt
key /etc/openvpn/client/client.key

# Set log file verbosity.
verb 3

# Silence repeating messages
;mute 20
```

## Openhab Server - Validating setup

```sh
sudo tcpdump -i br0 dst host 224.0.0.50 and port 9898
listening on br0, link-type EN10MB (Ethernet), capture size 262144 bytes
16:06:24.485583 IP 192.168.2.214.4321 > 224.0.0.50.9898: UDP, length 136
16:06:27.723873 IP 192.168.1.10.4321 > 224.0.0.50.9898: UDP, length 135
```

## Openhab Server - Persisting configuration changes

I am running home automation on simple Raspberry PI 3. It has one drawback - for 24/7 work termals are not good even with passive cooling. SD card potentially might die quite soon, hardware - depends on plate cooling quality. 

Thus I prefer to configure openhab via file configuration,
with set of deployment batches, that provision openhab server with updates. All configuration changes are stored in a private git repository.

Additionally, ansible plays are used for initial box configuration (zsh shell, docker daemon, prometheus exporters, openvpn configuration and so on)

This allows me

## Remote site - OpenVPN server

Ideally, you might have router that already supports L2 OpenVPN. Routers supporting custom firmwares (Padawan, Openwrt, Tomato - for sure), Microtics and so on.

If for any reason you don't have such router, this means you would need to place one more box on remote site (possible - the same raspberry pi) and install OpenVPN there.

