#!/bin/bash

echo

content=$1
wrapper=$2
target=$3

footer=${wrapper}_footer.html
header=${wrapper}_header.html

cat $header $content $footer > ./$target
