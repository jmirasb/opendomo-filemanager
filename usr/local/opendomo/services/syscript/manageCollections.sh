#!/bin/sh
#desc:Manage collections
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

## The way OpenDomoOS organizes files is by using what we call collections.  
## A collection is a group of files with something in common. This can be a 
## topic, a file type, a privacy or protection level, etc
##
## Collections are stored in the owner's home folder, since they are a private 
## way of organization. However, if the user wants to share a collection, it 
## can be copied into somebody else's home folder as well.
##
## Some examples of collections can be:
## - Music playlists: the best of 80s, Vivaldi, Beethoven, etc.
## - Picture galleries: summer of 2010 holidays, birthday, new year, etc. 
## - Backups from old drives: files were not processed individually yet
## - Document archives: material from Master's degree, old translations, etc.

CONFIGPATH="/home/$USER/collections"

test -d $CONFIGPATH || mkdir -p $CONFIGPATH

cd $CONFIGPATH

if ! test -z "$2"; then
	#More than one parameter, we are saving a location data
	test -z "$CODE" && CODE=`echo $2 | sed 's/[^a-z0-9]//gi'`
	echo "CODE='$1'" > $CONFIGPATH/$CODE.col
	echo "NAME='$2'" >> $CONFIGPATH/$CODE.col
	echo "TYPE='$3'" >> $CONFIGPATH/$CODE.col
	echo "LOCATION='$4'" >> $CONFIGPATH/$CODE.col
	echo "CRITICITY='$5'" >> $CONFIGPATH/$CODE.col
fi


echo "#> Manage collections"
echo "list:manageCollections.sh"
for c in *.col; do
	if test -f "$c"; then
		source ./$c
		echo "	-$c	$NAME	$TYPE	$LOCATION"
	fi
done
if test -z "$NAME"; then
	echo "#INFO No collections were found."
fi
echo

if ! test -z $1; then
	source $CONFIGPATH/$1
fi

echo "#> Edit"
echo "form:manageCollections.sh"
echo "	code	code	hidden	$CODE"
echo "	name	Name	text	$NAME"
echo "	type	Type	list[gallery,library,playlist]	$TYPE"	
echo "	location	Location	text	$LOCATION"
echo "	criticity	Criticity	list[normal,high,maximum]	$CRITICITY"
echo
