#!/bin/sh
#desc:Generic script for scanning drives

if test -z "$1"
then
	echo "usage:`basename $0` /path/to/drive"
	exit 1
fi

if touch $1/.scanfile.txt
then
	cd $1	
	find -type f | tee $1/.scanfile.txt
	echo "#INFO Scan finished"
	echo "# `cat $1/.scanfile.txt | wc -l` files found"
else
	echo "#ERROR Impossible to scan this file"
fi