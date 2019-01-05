#!/bin/sh

OPENHABIAN=${1-openhabianpi}

scp -r html openhabian@$OPENHABIAN:/etc/openhab2/
scp -r icons openhabian@$OPENHABIAN:/etc/openhab2/
scp -r items openhabian@$OPENHABIAN:/etc/openhab2/
scp -r persistence openhabian@$OPENHABIAN:/etc/openhab2/
scp -r rules openhabian@$OPENHABIAN:/etc/openhab2/
scp -r scripts openhabian@$OPENHABIAN:/etc/openhab2/
scp -r services openhabian@$OPENHABIAN:/etc/openhab2/
scp -r sitemaps openhabian@$OPENHABIAN:/etc/openhab2/
scp -r sounds openhabian@$OPENHABIAN:/etc/openhab2/
scp -r things openhabian@$OPENHABIAN:/etc/openhab2/
scp -r transform openhabian@$OPENHABIAN:/etc/openhab2/
