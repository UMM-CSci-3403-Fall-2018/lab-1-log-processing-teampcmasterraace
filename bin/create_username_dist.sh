#!/bin/bash
dir=$1
touch temp_output

for file in $dir/*/failed_login_data.txt
do
	echo
	echo "Handling: $file"
	cat $file >> temp_output
done

awk '{print $4}' $file | sort | uniq -c | awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}'


