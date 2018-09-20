#!/bin/bash

# Author Prince

#setup
directory=$1

#Goes inside the directories log files.
cd $directory/var/log

#Iterate over all files and lines
cat * | awk '/Failed password for invalid user/ {print $1 $2 substr($3,0,2) $11 $13}' | cat > $directory/failed_login_data.txt
cat * | awk '/Failed password/ && !/invalid/  {print $1 $2 substr($3,0,2) $9 $11}' | cat >> $directory/failed_login_data.txt
