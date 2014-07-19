#!/bin/sh
#desc: Scan a image drive, like a digital camera 

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
	mkdir -p $drive/.thumbnails/
	rm -fr .scanfile.txt 
	# Indexing files in background
	for file in `find -type f `; do bn=`basename $file`; convert -quiet -thumbnail 200 $file .thumbnails/$bn; identify $file >> .scanfile.txt done rm $drive/.scanfile.pid & 
else
	echo "#ERROR Invalid privileges or readonly drive"
	return 1
fi