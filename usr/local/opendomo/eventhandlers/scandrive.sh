#!/bin/sh
#desc: Scan a generic drive

event="$1"
module="$2"
description="$3"
drive="$4"


if test -z "$drive"
then
	echo "usage:`basename $0` event module description /path/to/drive"
	exit 1
fi


if test -f $drive/.scanfile.pid
then
	return 0
fi
if touch $drive/.scanfile.pid
then
	# Indexing files in background
	find -type f > $drive/.scanfile.txt; rm $drive/.scanfile.pid & 
else
	echo "#ERROR Invalid privileges or readonly drive"
	return 1
fi
