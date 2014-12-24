#!/bin/sh
#desc:Search files
#package:odfilemanager
#type:local

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

DRIVE="/media/$1"

if test -z "$1"
then
	# No parameter specified"
	echo "form:`basename $0`"
	echo "	drive	Path	text	$1"
	echo "	string	Search string	text	$2"

else
	STRING="$2"
	cd /media/$1
	echo "list:`basename $0`"
	for d in *
	do
		if test "$d" != "*"
		then
			grep $STRING .scanfile.txt | sed 's/^/\t-/'
		fi
	done
fi
echo

