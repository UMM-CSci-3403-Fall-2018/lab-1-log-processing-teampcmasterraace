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
done
