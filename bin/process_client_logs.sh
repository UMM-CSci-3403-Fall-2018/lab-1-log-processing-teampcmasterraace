#!/bin/bash

#Setup 
dir=$1
out="failed_login_data.txt"
cd $dir
re="([A-Z][a-z]{2}) ([0-9]{1,2}) ([0-9][0-9]).* user ([a-z]+) from (.*) port"

re2="([A-Z][a-z]{2}) ([0-9]{1,2}) ([0-9][0-9]).* for ([a-z]+) from (.*) port"

#Create the output folder
touch $out
#Iterate over all files and lines
for file in *; do
    if [ -f "$file" ] && [ $file != $out ]; then
	cat $file | while read line
	do
		if [[ $line =~ $re ]]
		then
			month="${BASH_REMATCH[1]}"
			day="${BASH_REMATCH[2]}"
			hour="${BASH_REMATCH[3]}"
			user="${BASH_REMATCH[4]}"
			ip="${BASH_REMATCH[5]}"
			echo "$month $day $hour $user $ip" >> $out
		fi	

		if [[ $line =~ $re2 ]]
                then
                        month="${BASH_REMATCH[1]}"
                        day="${BASH_REMATCH[2]}"
                        hour="${BASH_REMATCH[3]}"
                        user="${BASH_REMATCH[4]}"
                        ip="${BASH_REMATCH[5]}"
                        echo "$month $day $hour $user $ip" >> $out
                fi

	done
    fi
done
