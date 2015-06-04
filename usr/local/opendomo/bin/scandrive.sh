#!/bin/sh
#desc: Scan a generic drive
#type:local
#package: odfilemanager

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

## This script walks the given drive and creates a text based index file 
## with the md5 hash, size and relative path of each file. 

drive="$1"

if test -z "$drive"
then
	echo "usage:`basename $0`  /path/to/drive"
	exit 1
fi

# Instead of /var/.../run, we place the PID file in the drive itself to know if the drive is busy
if test -f $drive/.scanfile.pid
then
	exit 0
fi
if touch $drive/.scanfile.pid
then
	# Indexing files 
	cd $drive
	#mv .scanfile.txt .scanfile.old
	find . \( ! -regex '.*/\..*' \) -type f  > .scanfile.tmp
	TOTAL=`wc -l .scanfile.tmp | cut -f1 -d' '`
	CURRENT=0
	while read -r FILENAME
	do
		let CURRENT=$CURRENT+1
		echo "# Indexing $FILENAME ... ($CURRENT / $TOTAL)"
		# If the file is not in the index ...
		if ! grep -q "$FILENAME" .scanfile.txt
		then
			# ... we add it!
			MD5SUM=`md5sum "$FILENAME" | cut -f1 -d' '`
			SIZE=`wc -c "$FILENAME" | cut -f1 -d' '`
			echo "$MD5SUM|$SIZE|$FILENAME" >> .scanfile.txt
		fi
	done < .scanfile.tmp
	rm -fr .scanfile.pid 

else
	echo "#ERROR Invalid privileges or readonly drive"
	exit 1
fi
