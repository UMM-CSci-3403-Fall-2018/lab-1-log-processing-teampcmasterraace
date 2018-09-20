#!/bin/bash

#setup
file= $2
dir= $1
out= 'failed_login_data.txt'
cd $dir

#Create the output folder
touch $out

#Iterate over all files and lines
for file in *;
do
	grep -q 'Failed password for' $file | awk '/invalid user/ echo {"$1 $2 substr($3,0,2) $11 $13"} /Failed password for/ echo {"$1 $2 substr($3,0,2) $9 $11"}' > $out
done

