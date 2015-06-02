#!/bin/sh
#desc:Show file info
#package:odfilemanager
#type:local

# Copyright(c) 2015 OpenDomo Services SL. Licensed under GPL v3 or later

## This script has a double function. In the first place, it can be invoked
## to see the information related to the file in the interface. Additionally,
## it can be used by an Ajax call to get the necessary information to assemble
## all the options in the interface.

FILENAME="/media/$1"

echo "form:`basename $0`"
echo "	FILENAME filename	readonly	$FILENAME"
echo "actions:"
echo "	goback	Back"
echo
