#!/bin/bash

: '
  A few comments about the failing nature of the tests for this function:

  Our code was written based on the specifications listed in the README.MD file.
  Our code was tested in an enviroment based on the specifications listed in the README.MD file.
  Our code was NOT build to withstand wish-washy and false specifications.

  >>> The specifications are wrong <<<

  Wrong number one:

    Claim:
      "This script takes a directory as a command line argument and does all its work in that directory.
      That directory is assumed to contain the un-tarred and un-gzipped log files for a single client,
      but we dont know in advance how many files there are or what theyre called."

    Reality:
      The log files are contained within a nested directory structure: var/log/*,
      Looping through the supplied directory for files (as the specification suggests) will reveal no files.

  Wrong number two:
    Claim:
      "The secure files contain a wide variety of entries documenting numerous different events,
      but we only care about two particular kinds of lines."

    Reality:
      You also capture a third line type, which appears in test_sorted.txt as:
        "Jul 13 02 db2inst1 121.88.249.94"
      This is incorectly captured from the line:
        "Jul 13 02:14:02 discovery sshd[4312]: Invalid user db2inst1 from 121.88.249.94"
'

#Setup
dir=$1
re="([A-Z][a-z]{2}) ([0-9]{1,2}) ([0-9][0-9]).* user ([a-z]+) from (.*) port"
re2="([A-Z][a-z]{2}) ([0-9]{1,2}) ([0-9][0-9]).* for ([a-z]+) from (.*) port"
cd $dir
touch failed_login_data.txt

#Iterate over all files & all lines
for file in var/log/*; do
	cat $file | while read line
	do

    #Check for login-type 1
		if [[ $line =~ $re ]]
		then
			month="${BASH_REMATCH[1]}"
			day="${BASH_REMATCH[2]}"
			hour="${BASH_REMATCH[3]}"
			user="${BASH_REMATCH[4]}"
			ip="${BASH_REMATCH[5]}"

      #append to file
			echo "$month $day $hour $user $ip" >> failed_login_data.txt
		fi

    #Check for login-type 2
		if [[ $line =~ $re2 ]]
    then
      month="${BASH_REMATCH[1]}"
      day="${BASH_REMATCH[2]}"
      hour="${BASH_REMATCH[3]}"
      user="${BASH_REMATCH[4]}"
      ip="${BASH_REMATCH[5]}"

      #append to file
      echo "$month $day $hour $user $ip" >> failed_login_data.txt
    fi
	done
done
