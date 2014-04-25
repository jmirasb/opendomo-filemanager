#!/bin/sh

mkdir -p pkg
rm pkg/*.tar.gz 2>/dev/null
PLUGIN="odfilemanager"
VERSION=`cat var/opendomo/plugins/odfilemanager.version`
USR="--owner 1000 --group 1000 --same-permissions"
EXCLUDE=' --exclude "*~" --exclude .svn --exclude README.md --exclude LICENCE --exclude odfilemanager.png'

rm -fr pkg/*.tar.gz
tar zcf  pkg/$PLUGIN-$VERSION.tar.gz usr var  $USR $EXCLUDE
