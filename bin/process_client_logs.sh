#!/bin/bash

#Setup
dir=$1
out="failed_login_data.txt"
cd $dir
re="([A-Z][a-z]{2}) ([0-9]{1,2}) ([0-9][0-9]).* user ([a-z]+) from (.*) port"
rere="([A-Z][a-z]{2}) ([0-9]{1,2}) ([0-9][0-9]).* for ([a-z]+) from (.*) port"
#Create the output folder
touch $out

#Iterate over all files and lines
for file in *; do
        {$awk '{
           if (system(grep -q invalid "$file"))
                then
                        month = $1
                        day = $2
                        hour = substr($3, 0, 2)
                        user = $11
                        ip = $13
                        echo "$month $day $hour $user $ip" >> $out
           else
               month = $1
               day = $2
               hour = substr($3, 0, 2)
               user = $9
               ip = $11
               echo "$month $day $hour $user $ip" >> $out
               }'
       }
done
