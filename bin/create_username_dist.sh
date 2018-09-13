#!/bin/bash
dir=$1
touch $dir/temp_output
touch $dir/out
touch $dir/username_dist.html

for file in $dir/*/failed_login_data.txt
do
	cat $file >> $dir/temp_output
done

awk '{print $4}' $file | sort | uniq -c | awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}' >> $dir/out
./bin/wrap_contents.sh $dir/out html_components/username_dist $dir/username_dist.html
rm $dir/out
rm $dir/temp_output


