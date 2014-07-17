#!/bin/sh
#desc:Search files
#package:odfilemanager
#type:local

DRIVE="/media/$1"

if test -z "$1"
then
	# No parameter specified"
	echo "form:`basename $0`"
	echo "	string	Search string	text"

else
	STRING="$1"
	cd /media/
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

