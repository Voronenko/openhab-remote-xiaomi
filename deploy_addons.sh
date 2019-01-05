#!/bin/sh

OPENHABIAN=${1-openhabianpi}

scp -r addons openhabian@$OPENHABIAN:/usr/share/openhab2
