#!/bin/bash

#Author: SirLich (Liam Koehler)

TMP_DIR=`mktemp --directory`
echo $TMP_DIR
for file in "$@"
do
  name="$(basename $file _secure.tgz)"
  echo $name
  mkdir $TMP_DIR/$name
  tar -xzf $file -C $TMP_DIR/$name
  ./bin/process_client_logs.sh $TMP_DIR/$name
done

./bin/create_username_dist.sh $TMP_DIR
./bin/create_hours_dist.sh $TMP_DIR
./bin/create_country_dist.sh $TMP_DIR

./bin/assemble_report.sh $TMP_DIR

cp $TMP_DIR/failed_login_summary.html .

rm $TMP_DIR -rf
