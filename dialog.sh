#!/bin/bash
function help {
  echo "Usage: dialog.sh filename"
  exit 1
}

if [ $# -lt 1 ] ; then
  help
fi

voices=('Amelie' 'Thomas')
voice=0
filename=''

while test $# -gt 0
do
  case "$1" in
    # Reverse voies.
    -r)
      voice=!$voice
      ;;
    # Define filename.
    *)
      filename=$1
      ;;
  esac
  shift
done

while read line
do
  echo "$line"
  say $line -v "${voices[$voice]}"
  voice=!$voice
done < $filename
