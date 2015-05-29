#!/bin/sh
#desc: Dumps a drive index into SQLite DB
#type:local
#package: odfilemanager

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

drive="$1"
if test -z "$drive"
then
	echo "usage:`basename $0`  /path/to/drive"
	exit 1
fi

if test -d "$drive"; then
	cd $drive
else
	echo "#ERROR Path does not exist"
	exit 1 
fi

# If the drive is being scanned, abort
if test -f .scanfile.pid
then
	echo "#INFO Drive is being scanned"
	exit 0
fi
if test -f .scanfile.txt
then
	cat .scanfile.
else
	echo "#ERROR Drive was never indexed"
	exit 1
fi
