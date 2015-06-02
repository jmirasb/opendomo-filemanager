#!/bin/sh
#desc: Dumps a drive index into SQLite DB
#type:local
#package: odfilemanager

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

drive="$1"
if test -z "$drive"
then
	echo "usage:`basename $0`  /path/to/drive"
	exit 1
fi

if test -d "$drive"; then
	cd $drive
else
	echo "#ERROR Path does not exist"
	exit 1 
fi

# If the drive is being scanned, abort
if test -f .scanfile.pid
then
	echo "#INFO Drive is being scanned"
	exit 0
fi
if ! test -f .scanfile.txt
then
	echo "#ERROR Drive was never indexed. Run scandrive.sh first"
	exit 1
fi

if ! test -f .scanfile.sqlite
then
	CREATESQL="CREATE TABLE files (id INTEGER PRIMARY KEY AUTOINCREMENT, md5 CHAR(32), size INTEGER, path TEXT UNIQUE);"
	echo $CREATESQL | sqlite3 .scanfile.sqlite
fi

TOTAL=`wc -l .scanfile.txt | cut -f1 -d' '`
CURRENT=0
while read -r FLINE
do
	let CURRENT=$CURRENT+1
	#TODO use AWK instead
	MD5SUM=`echo "$FLINE" | cut -f1 -d' '`
	SIZE=`echo "$FLINE" | cut -f2 -d' '`
	FILEPATH=`echo "$FLINE" | cut -f3- -d' '`
	echo "# Updating $FILEPATH ... ($CURRENT / $TOTAL)"
	echo "REPLACE INTO files (md5,size,path) VALUES ('$MD5SUM',$SIZE, '$FILEPATH');" | sqlite3 .scanfile.sqlite

done < .scanfile.txt

