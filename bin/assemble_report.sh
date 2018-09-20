#!/bin/bash

#Author SirLich (Liam Koehle)
#GitHub: https://github.com/SirLich

#Setup
dir=$1
touch $dir/data_out
touch $dir/failed_login_data.html

#concat files
cat $dir/country_dist.html $dir/hours_dist.html $dir/username_dist.html >> $dir/data_out

#Wrap
./bin/wrap_contents.sh $dir/data_out html_components/summary_plots $dir/failed_login_summary.html

#cleanup
rm $dir/data_out
