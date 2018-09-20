#!/bin/bash

#Author: SirLich (Liam Koehler)

#Setup
content=$1
wrapper=$2
target=$3
footer=${wrapper}_footer.html
header=${wrapper}_header.html

#Create
cat $header $content $footer > $target
