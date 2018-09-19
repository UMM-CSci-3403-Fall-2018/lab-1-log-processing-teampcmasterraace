#!/bin/bash

#Setup
dir=$1

#Temp output. Used for concatinating log files together for proccessing.
touch $dir/temp_out

#The complete set of generated data, pre-wrapping.
touch $dir/data_out

#True final output location of the data generated in this script.
touch $dir/hours_dist.html

#Loop to wrap all un-proccesed data into a single file: temp_out
for file in $dir/*/failed_login_data.txt
do
	cat $file >> $dir/temp_out
done

awk '{print $3}' $dir/temp_out | #Pick the data we want. $3 in this context refers to the time-stamp data.
awk '{split($0,clock,":")} {print clock[1]}'| #Split the hour information off from the min/second data.
sort | #Sort, in preperation for the next process command.
uniq -c | #Count the now sorted lines. Returns a touple: $1 as the number of counted lines, and $2 as the (hour) data counted.
awk '{printf("data.addRow([\x27%s\x27, %s]);\n",$2 ,$1)}' >> $dir/data_out #Format the data and send to data_out

#Wraps the contents of data_out in the correct HEADER and FOOTER files.
./bin/wrap_contents.sh $dir/data_out html_components/hours_dist $dir/hours_dist.html

#Clean up temp-files
rm $dir/data_out
rm $dir/temp_out
