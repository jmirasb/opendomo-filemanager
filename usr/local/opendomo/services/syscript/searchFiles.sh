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



if test -z "$1" || test $1 = "/"
then
	# No parameter specified: just show the search form
	
	#FIXME Beware spaces!!
	KEYWORDS="2014 2015 New+year Holidays Birthday"

	echo "#> Search"
	echo "form:`basename $0`"
	echo "	string	Search	text	$1"
	echo "	drive	Path	hidden	$SEARCHPATH"	
	echo 
	echo "#> Search results"
	echo "list:searchResults"
	echo "#LOADING Loading results..."	
	echo
	echo "#> Keywords"
	echo "list:keywords	selectable"
	for kw in $KEYWORDS; do
		echo "	$kw	$kw	keyword"
	done
	if test -f /home/$USER/collections/; then
		echo "#> Collections"
		echo "list:collections	selectable"
		for kl in /home/$USER/collections/*.col; do
			echo "	$cl	$cl	collection"
		done	
	fi
	echo
else
	# With parameters, we just show the results:
	
	STRING="$1"
	
	if test -z "$2"; then
		SEARCHPATH="*"
	else
		SEARCHPATH="$2"
	fi	
	
	# searchpath is a drive name or "*"
	#GREPQUERY="/media/$SEARCHPATH/.scanfile.txt"

	# Case 3: searching in a collection
	#if test -f /home/$USER/collections/$SEARCHPATH.col 
	#then
	#	source /home/$USER/collections/$SEARCHPATH.col 
	#	cd $LOCATION
	#	d=$LOCATION
	#	GREPQUERY=".scanfile.txt"
	#fi
	
	echo "#> Search results"
	echo "list:`basename $0`"
	cd /media/
	for d in $SEARCHPATH; do
		grep $STRING /media/$d/.scanfile.txt | awk -F "|" '{print "\t-$d/" $3 "\t" $3 "\t" "file" "\t" $2 }'
	done

fi
echo

