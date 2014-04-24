#!/bin/sh
#desc:Browse files and folders
#package:odfilemanager
#type:local

# Copyright(c) 2011 OpenDomo Services SL. Licensed under GPL v3 or later

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
else
    echo "#> Contents of [$ROUTE]"
fi

echo "list:`basename $0`	iconlist selectable"
for i in *; do
    if test "$i" != "*"; then
        e=`echo "$i" | cut -f2 -d.`
        dn=`echo "$i" | sed 's/^.\///'`
        bn=`basename "$i"`

        if test -d "$i"; then
            # See folders
            if test "$ROUTE" != "/"; then
                echo "	-$ROUTE/$dn	$i	dir"
            else
                echo "	-/$dn	$i	dir"
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
if test -x /usr/local/opendomo/deleteFiles.sh; then
    echo "	deleteFiles.sh	Delete"
fi
if test -x /usr/local/opendomo/umountDrive.sh; then
    if test "$ROUTE" == "/"; then
        echo "	umountDrive.sh	Disconnect drive"
    fi
fi
echo
