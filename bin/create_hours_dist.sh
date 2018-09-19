#!/bin/bash

#Setup
dir=$1
touch $dir/temp_output
touch $dir/out
touch $dir/hours_dist.html

for file in $dir/*/failed_login_data.txt
do
	cat $file >> $dir/temp_output
done

awk '{print $3}' $dir/temp_output | awk '{split($0,clock,":")} {print clock[1]}'| sort | uniq -c | awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}' >> $dir/out
./bin/wrap_contents.sh $dir/out html_components/hours_dist $dir/hours_dist.html
rm $dir/out
rm $dir/temp_output
