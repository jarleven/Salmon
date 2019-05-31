#!/bin/bash

# Move files grabbed to our archive folder

# Files are on this format
#
#  syd__2019-05-29__01-00-00.mp4
# nord__2019-05-29__07-45-00.mp4

for i in {1..10}
do
   echo $i" day(s) ago"
   sleep 3

  datecode=$(date +"%Y-%m-%d" --date=$i" days ago")

  echo "Moving files ["$datecode"]"

  files="./*__"$datecode"__*.mp4"

  mkdir "../Archive/"$datecode

  for f in $files; do
      # do some stuff here with "$f"
      # remember to quote it or spaces may misbehave
      echo $f
      mv $f "../Archive/"$datecode"/"


  done
done
