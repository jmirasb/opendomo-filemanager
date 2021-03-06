#!/bin/sh
#desc:Umount drive
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

DRIVE="/media/$1"
CONFFILE="$DRIVE/opendomo.cfg"
CONFDEVICE=`grep ^CONFDEVICE= $CONFFILE | sed 's/\"//g' | cut -f2 -d= `
SYSDEVICE=`grep ^SYSDEVICE= $CONFFILE | sed 's/\"//g' | cut -f2 -d= `
HOMEDEVICE=`grep ^HOMEDEVICE= $CONFFILE | sed 's/\"//g' | cut -f2 -d=`

# Check system device
if [ "$CONFDEVICE" = "1" ] || [ "$SYSDEVICE" = "1" ] || [ "$HOMEDEVICE" = "1" ]; then
    echo "#ERRO $DRIVE is a system device, can't be unmounted"
else
    # Unmount
    if
    sudo umount "$DRIVE"
    then
        echo "#INFO You can eject device"
    else
        echo "#ERRO Device is busy, wait a moment and try again"
    fi
fi
echo "actions:"
echo "	goback	Back"
echo
