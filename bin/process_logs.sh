#!/bin/bash

#Author: SirLich (Liam Koehler)

TMP_DIR=`mktemp --directory`

for var in "$@"
do
    echo "$var"
done
