#!/bin/sh
#desc:Import files
#type:local
#package:odfilemanager

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

event="$1"
module="$2"
description="$3"
drive="$4"

#TODO: Read this path from a configuration drive
STORAGEDRIVE="/media/storage"

if test -z "$drive"
then
	echo "usage:`basename $0` event module description /path/to/drive"
	exit 1
fi

if test -d "$STORAGEDRIVE"; then
	cd $drive
	TIMESTAMP=`date +%Y.%m.%d`
	IMPORT="$STORAGEDRIVE/import/$TIMESTAMP"
	if mkdir -p $IMPORT 
	then

		for FILENAME in `find ./ -not -name ".*" -type f `
		do
			cp -p $FILENAME $IMPORT/
		done
		sync
		chown admin $IMPORT/*
		#TODO Check if there is a backup drive to make a second copy
		#TODO If it's specified in the configuration, delete the files 
		#TODO and unmount once files are secured
	else
		echo "#ERR Invalid import path"
		exit 2
	fi
else
	echo "#ERR Invalid storage drive"
	exit 3
fi

