#!/bin/sh
#desc: Scan a image drive, like a digital camera 
#type:local
#package: odfilemanager

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

event="$1"
module="$2"
description="$3"
drive="$4"

# Old thumbnail system
CONVERTOPTIONS="-quiet -thumbnail 200"
# New system: square-shaped 200px centered image
CONVERTOPTIONS="-quiet -thumbnail 200x200^ -gravity center -extent 200x200"

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
	cd $drive
	rm -fr .scanpictures.txt 
	# Indexing files in background
	for file in  `find ./ -not -name ".*" -type f `
	do 
		if identify $file >> .scanpictures.txt 
		then
			bn=`basename $file`; 
			convert $CONVERTOPTIONS $file .thumbnails/$bn; 
		fi
	done 
	rm $drive/.scanfile.pid 
else
	echo "#ERROR Invalid privileges or readonly drive"
	return 1
fi