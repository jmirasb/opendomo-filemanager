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
	exit 0
fi
if touch $drive/.scanfile.pid
then
	# Indexing files 
	cd $drive
	mv .scanfile.txt .scanfile.old
	for FILENAME in `find ./ -not -name ".*" -type f `
	do
		MD5SUM=`md5sum $FILENAME | cut -f1 -d' '`
		SIZE=`wc -c $FILENAME | cut -f1 -d' '`
		echo "$MD5SUM $SIZE $FILENAME" >> .scanfile.txt
	done
	rm -fr .scanfile.pid .scanfile.old 

else
	echo "#ERROR Invalid privileges or readonly drive"
	exit 1
fi
