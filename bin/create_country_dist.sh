#!/bin/bash

#Author SirLich (Liam Koehle)
#GitHub: https://github.com/SirLich

#Setup
dir=$1
touch $dir/temp_out
touch $dir/data_out
touch $dir/country_dist.html

for file in $dir/*/failed_login_data.txt
do
	cat $file >> $dir/temp_out
done

awk '{ print $5}' $dir/temp_out |
	sort |
	join -1 1 -2 1 etc/country_IP_map.txt - |
	awk ' { print $2}' |
	uniq -c |
	awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}' |
	sort >> $dir/data_out

  ./bin/wrap_contents.sh $dir/data_out html_components/country_dist $dir/country_dist.html

  rm $dir/data_out
  rm $dir/temp_out
