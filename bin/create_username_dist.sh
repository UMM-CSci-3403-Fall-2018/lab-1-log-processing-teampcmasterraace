#!/bin/bash
dir=$1
touch temp_output
touch out
touch $dir/username_dist.html

for file in $dir/*/failed_login_data.txt
do
	echo
	echo "Handling: $file"
	cat $file >> temp_output
done

awk '{print $4}' $file | sort | uniq -c | awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}' >> out
./bin/wrap_contents.sh out html_components/username_dist $dir/username_dist.html


