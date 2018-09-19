#!/bin/bash

#Setup
dir=$1

#Temp output. Used for concatinating log files together for proccessing.
touch $dir/temp_out

#The complete set of generated data, pre-wrapping.
touch $dir/data_out

#True final output location of the data generated in this script.
touch $dir/username_dist.html

#Loop to wrap all un-proccesed data into a single file: temp_out
for file in $dir/*/failed_login_data.txt
do
	cat $file >> $dir/temp_out
done

#Process temp_out, and send results to data_out
awk '{print $4}' $dir/temp_out | #Pick the data we want. $4 in this context refers to the username data.
sort | #Sort, in preperation for the next process command.
uniq -c | #Count the now sorted lines. Returns a touple with $1 the number of counted lines, and $2 the (username) data counted.
awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}' >> $dir/data_out #Process the data into the required format, and send to data_out

#Wraps the contents of data_out in the correct HEADER and FOOTER files.
./bin/wrap_contents.sh $dir/data_out html_components/username_dist $dir/username_dist.html

#Clean up temp-files
rm $dir/out
rm $dir/temp_out
