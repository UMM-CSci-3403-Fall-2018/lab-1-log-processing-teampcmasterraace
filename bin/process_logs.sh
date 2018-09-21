#!/bin/bash

#Author: SirLich (Liam Koehler)
#GitHub: https://github.com/SirLich

#Create temp directory
TMP_DIR=`mktemp --directory`

#Loop over all args
for file in "$@"
do
  name="$(basename $file _secure.tgz)"
  mkdir $TMP_DIR/$name
  tar -xzf $file -C $TMP_DIR/$name

  #Generated logs
  ./bin/process_client_logs.sh $TMP_DIR/$name
done

#Process the generated logs
./bin/create_username_dist.sh $TMP_DIR
./bin/create_hours_dist.sh $TMP_DIR
./bin/create_country_dist.sh $TMP_DIR
./bin/assemble_report.sh $TMP_DIR

#Copy back to working dir
cp $TMP_DIR/failed_login_summary.html .

#Cleanup
rm $TMP_DIR -rf
