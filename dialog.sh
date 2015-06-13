#!/bin/bash

voices=('Amelie' 'Thomas')
voice=0

if [ $# -ne 1 ] ; then
  echo "Usage: dialog.sh filename"
  exit 1
fi

while read line
do
  echo "$line ${voices[$voice]}"
  say $line -v "${voices[$voice]}"
  voice=!$voice
done < $1