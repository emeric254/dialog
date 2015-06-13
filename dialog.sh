#!/bin/bash

# that function write to the standart output a help message of the script usage
function help {
  echo "Usage: dialog.sh filename"
  exit 1
}

# that function does the audio output
# requires as parameters "text", "voicename"
function say {
#    say $line -v "${voices[$voice]}"
     echo "-"
}

# that function does all core features
# requires as parameters "filename", "voices", "voice"
function readDialog {
  filename=$1
  voices=$2
  voice=$3
  while read line
  do
    echo "$line"
    say $line "${voices[$voice]}"
    voice=!$voice
  done < $filename
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

if [ -f $filename ]
then
  readDialog $filename $voices $voice
else
  help
fi
