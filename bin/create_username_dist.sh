#!/bin/bash
dir=$1

#find $dir -maxdepth 1 -mindepth 1 -type d -printf '%f\n'


for f in $dir/*/failed_login_data.txt
do
done

#for f in `find $dir -maxdepth 1 -mindepth 1 -type d -printf '%f\n'`
#do
#	...$f...
#done

#find ... -exec rm \{\} ;

