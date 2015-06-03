#!/bin/sh
#desc:Search files
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

## This script works in two different scenarios: 
## 1. No parameters, it will display the form with the search field, keywords, etc
## 2. With parameters, it will display the list witht the results
## In this way, we avoid the overhead of loading collections and keywords 
## for every search.

SEARCHPATH="$1"
STRING="$2"

if test -z "$1" || test $1 = "/"
then
	# No parameter specified: just show the search form
	SEARCHPATH="/"
	KEYWORDS="2014,2015,New year,Holidays,Birthday"

	echo "#> Search"
	echo "form:`basename $0`"
	echo "	drive	Path	text	$SEARCHPATH"
	echo "	string	Search string	text	$STRING"
	echo "	keywords	Keywords	list[,$KEYWORDS]	$KEYWORDSSELECTED"
	echo 
	echo "#> Search results"
	echo "list:`basename $0`"
	echo
else
	# With parameters, we just show the results:
	
	
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
		d="$SEARCHPATH"
		GREPQUERY="/media/$SEARCHPATH/.scanfile.txt"
	fi
	
	# Case 3: searching in a collection
	if test -f /home/$USER/collections/$SEARCHPATH.col 
	then
		source /home/$USER/collections/$SEARCHPATH.col 
		cd $LOCATION
		d=$LOCATION
		GREPQUERY=".scanfile.txt"
	fi
	
	echo "#> Search results"
	echo "list:`basename $0`"
	grep $STRING $GREPQUERY | awk '{print "\t-$d/" $3 "\t" $3 "\t" "file" "\t" $2 }'

fi
echo

