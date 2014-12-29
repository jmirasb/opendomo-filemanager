#!/bin/sh
#desc:Manage collections
#package:odfilemanager
#type:local

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

## The way OpenDomoOS organizes files is by using what we call collections. A 
## collection is a group of files with something in common. This can be a topic,
## a file type, a privacy or protection level, etc



CONFIGPATH="/etc/opendomo/collections"

test -d $CONFIGPATH || mkdir -p $CONFIGPATH

