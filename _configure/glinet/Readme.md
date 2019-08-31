For GLInet based routers https://www.gl-inet.com/


Copy to /usr/bin/vpn_reconnect

chmod +x /usr/bin/vpn_reconnect
Add it it at the end of /etc/rc.local, before exit

/usr/bin/vpn_reconnect &
