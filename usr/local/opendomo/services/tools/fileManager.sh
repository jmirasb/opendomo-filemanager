#!/bin/sh
#desc:Browse files
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

# First argument is a directory in /media
if test -z "$1"; then
    ROUTE="/"
else
    ROUTE="$1"
fi

# Checking route, if not valid force /
if ! test -d "/media/$ROUTE"; then
    echo "#ERR Invalid path [$ROUTE]"
    ROUTE="/"
fi

list_drives() {
    echo "#> Select drive"
	echo "list:`basename $0`	detailed selectable"
	DIRTYPE="drive"
	cd /media/
	for drive in * ; do
		LABEL=""
		if test -f /media/$drive/opendomo.cfg; then
			source /media/$drive/opendomo.cfg
		fi
		test -z "$LABEL" && LABEL=$drive
		echo "	-/$drive	$LABEL	drive	$drive"
	done
	
	echo "actions:"
	echo "	searchFiles.sh	Search"
	if test -x /usr/local/opendomo/umountDrive.sh; then
		echo "	umountDrive.sh	Disconnect drive"
		echo "	setupDrive.sh	Setup drive"
	fi
}

list_path_contents() {
	ROUTE=$1
	DRIVE=`echo $1 | cut -f2 -d'/'`
	DIRTYPE="dir"
	
	cd "/media/$ROUTE"	

	test -d "/media/$DRIVE/.thumbnails" && CLASS="indexed imagedir"
	
    echo "#> Contents of [$ROUTE]"
	echo "list:`basename $0`	iconlist $CLASS"	
	for i in *; do
		if test "$i" != "*"; then
			e=`echo "$i" | cut -f2 -d.`
			dn=`echo "$i" | sed 's/^.\///'`
			bn=`basename "$i"`

			if test -d "$i" 
			then
				# See folders
				if test "$ROUTE" != "/"; then
					echo "	-$ROUTE/$dn	$i	$DIRTYPE"
				else
					if test "$dn" != "lost+found"
					then
						echo "	-/$dn	$i	$DIRTYPE"
					fi
				fi
			else
				# See files
				if test "$e" = "$EXT" || test -z "$EXT" ; then
					case "$e" in
						jpg|jpeg|png|gif)
							type="file image"
						;;
						avi|mpeg|mpg|mov|mp4|mjpg|webm|ogg)
							type="video"
						;;
						txt|me|ME)
							type="file text"
						;;
						htm|html)
							type="file html"
						;;
						*)
							type="file"
						;;
					esac
					if ! test -z "$PREFIX"; then
						dn=`echo "$dn" | grep "^$PREFIX"`
					fi
					if ! test -z "$SUFFIX"; then
						dn=`echo "$dn" | grep "$SUFFIX"`
					fi
					if ! test -z "$dn"; then
						echo "	-$ROUTE/$dn	$i	$type	"
					fi
				fi
			fi
		else
			echo "#WARN This location is empty"
		fi
	done	
	
	echo "actions:"
	echo "	goback	Back"
	if test -x /usr/local/opendomo/deleteFiles.sh; then
		echo "	deleteFiles.sh	Delete"
	fi
	echo "	searchFiles.sh	Search"		
	echo
	echo "#> Upload file"
	echo "form:uploadFile.sh	foldable"
	echo "	path	path	hidden	$1"
	echo "	file	file	File	uploadingfile.tmp"
	echo
}

if [ "$ROUTE" == "/" ]; then
	list_drives
else
	list_path_contents "$ROUTE"
fi

echo
