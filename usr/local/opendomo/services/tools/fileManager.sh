#!/bin/sh
#desc:Browse files and folders
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

# First argument is a directory in /media
if test -z $1; then
    ROUTE="/"
else
    ROUTE="$1"
fi

# Checking route, if not valid force /
if ! test -d "/media/$ROUTE"; then
    echo "#ERR Invalid path [$ROUTE]"
    ROUTE="/"
fi

# Entering in route and see contents
cd "/media/$ROUTE"
if [ "$ROUTE" == "/" ]; then
    echo "#> Select drive"
	echo "list:`basename $0`	detailed selectable"
	DIRTYPE="drive"
else
    echo "#> Contents of [$ROUTE]"
	echo "list:`basename $0`	iconlist"	
	DIRTYPE="dir"
fi

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
echo "	searchFiles.sh	Search"
if test "$ROUTE" == "/"; then
	if test -x /usr/local/opendomo/umountDrive.sh; then
		echo "	umountDrive.sh	Disconnect drive"
	fi
else
	echo "	goback	Back"
	if test -x /usr/local/opendomo/deleteFiles.sh; then
		echo "	deleteFiles.sh	Delete"
	fi
	echo "	searchFiles.sh	Search"
fi
echo
