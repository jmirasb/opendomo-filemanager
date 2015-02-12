#!/bin/sh
#desc:Setup drive
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

DRIVE="/media/$1"

if test -z "$1" || ! test -d "$DRIVE"; then
	echo "#ERR Invalid selection"
	echo
	exit 1
fi

if ! test -z "$2"; then
	echo "LABEL='$2'" > $DRIVE/opendomo.cfg
	DISKTYPE=""
	test "$3" = "on" && DISKTYPE="$DISKTYPE image"
	test "$4" = "on" && DISKTYPE="$DISKTYPE music"
	echo "DISKTYPE='$DISKTYPE'" >> $DRIVE/opendomo.cfg
	echo "AUTOIMPORT='$5'" >> $DRIVE/opendomo.cfg
	echo "AUTOCLEANUP='$6'" >> $DRIVE/opendomo.cfg
fi

if test -f  $DRIVE/opendomo.cfg; then
	source $DRIVE/opendomo.cfg
fi

echo "#> Setup drive"
echo "form:setupDrive.sh"
echo "	drive	Drive	hidden	$1"
echo "	label	Label	text	$LABEL"
echo "	scimg	Scan for images	list[on,off] switch	$IMAGE"
echo "	scmusic	Scan for music	list[on,off] switch	$MUSIC"
echo "	import	Import automatically	list[on,off] switch	$IMPORT"
echo "	cleanup	Empty drive after import	list[on,off] switch	$CLEANUP"
echo
