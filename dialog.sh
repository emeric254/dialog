#!/bin/bash

# that function write to the standart output a help message of the script usage
function help {
  echo "Usage: $0 filename"
  echo 'Please also verify that you have a voice synthesizer installed like (say) or (espeak)'
  exit 1
}

# that function verify that an output command exist
function verifyOuput {
  return [ `which say 2>/dev/null` ] || [ `which espeak 2>/dev/null` 
}

# that function does the audio output
# requires as parameters "text", "voicename"
function processOutput {
  if [ `which say 2>/dev/null` ]
  then
    say $line -v "${voices[$voice]}"
  else
    if [ `which espeak 2>/dev/null` ]
    then
      espeak -v "${voices[$voice]}" $line
    fi
  fi
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
    processOutput $line "${voices[$voice]}"
    voice=!$voice
  done < $filename
}


if [ $# -lt 1 ] && [ !verifyOutput ]
then
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
