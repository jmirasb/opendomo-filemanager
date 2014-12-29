#!/bin/sh
#desc:Search files
#package:odfilemanager
#type:local

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

SEARCHPATH="$1"
STRING="$2"

if test -z "$1"
then
	# No parameter specified"
	SEARCHPATH="/"

else
	cd /media/$SEARCHPATH
	echo "#> Search results"
	echo "list:`basename $0`"
	for d in *
	do
		if test "$d" != "*" && test -f $d/.scanfile.txt 
		then
			grep $STRING $d/.scanfile.txt | awk '{print "\t" $3 "\t" $3 "\t" "file" "\t" $2 }'
		fi
	done
fi
echo
echo "#> Search"
echo "form:`basename $0`"
echo "	drive	Path	text	$SEARCHPATH"
echo "	string	Search string	text	$STRING"
echo
