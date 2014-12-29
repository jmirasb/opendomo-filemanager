#!/bin/sh
#desc:Search files
#package:odfilemanager
#type:local

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

SEARCHPATH="$1"
STRING="$2"

if test -z "$1" || test $1 = "/"
then
	# No parameter specified: just show the search form
	SEARCHPATH="/"

else
	# Case 1: searching in the entire library
	if test "$SEARCHPATH" = "/"
	then
		cd /media/
		GREPQUERY="/media/*/.scanfile.txt"
	fi

	# Case 2: searchpath is a drive name
	if test -d /media/$SEARCHPATH
	then
		cd /media/$SEARCHPATH
		GREPQUERY="/media/$SEARCHPATH/.scanfile.txt"
	fi
	
	# Case 3: searching in a collection
	if test -f /home/$USER/collections/$SEARCHPATH.col 
	then
		source /home/$USER/collections/$SEARCHPATH.col 
		cd $LOCATION
		GREPQUERY=".scanfile.txt"
	fi
	
	echo "#> Search results"
	echo "list:`basename $0`"
	grep $STRING $GREPQUERY | awk '{print "\t-" $d "/" $3 "\t" $3 "\t" "file" "\t" $2 }'

fi
echo
echo "#> Search"
echo "form:`basename $0`"
echo "	drive	Path	text	$SEARCHPATH"
echo "	string	Search string	text	$STRING"
echo
