#!/bin/sh
#desc: Scan a generic drive
#type:local
#package: odfilemanager

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

event="$1"
module="$2"
description="$3"
drive="$4"


if test -z "$drive"
then
	echo "usage:`basename $0` event module description /path/to/drive"
	exit 1
else
	/usr/local/opendomo/bin/scandrive.sh $drive
fi
