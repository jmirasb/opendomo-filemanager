#!/bin/sh
#desc: Find duplicates 
#type:local
#package: odfilemanager

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

drive="$1"

if test -z "$drive"
then
	echo "usage:`basename $0` /path/to/drive"
	exit 1
fi

echo "#ERROR Under construction"
echo
