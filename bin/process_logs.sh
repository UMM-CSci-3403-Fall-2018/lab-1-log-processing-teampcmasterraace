#!/bin/bash

#Author: SirLich (Liam Koehler)

TMP_DIR=`mktemp --directory`

for file in "$@"
do
    tar -xzf $file
done
