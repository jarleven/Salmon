#!/bin/bash

# Move files grabbed to our archive folder

# Files are on this format
#
#  syd__2019-05-29__01-00-00.mp4
# nord__2019-05-29__07-45-00.mp4

echo Script name: $0
echo $# arguments 

if [ "$#" -ne 1 ]; then 
    echo "illegal number of parameters"
    exit
fi

folder=$1

# Does the folder exist ?
if [[ ! -e $folder ]]; then
    echo "Source folder does not exist"
    exit
fi

cd $folder
cd "../Archive"

# Previous command ../Archive OK ?
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
    exit
fi


cd $folder

# Loop ove the last x to y days
for i in {1..30}
do
  echo $i" day(s) ago"

  datecode=$(date +"%Y-%m-%d" --date=$i" days ago")

  echo "Moving files ["$datecode"]"

  files="./*__"$datecode"__*.mp4"

  mkdir "../Archive/"$datecode

  # Previous command ../Archive OK ?
 # if [ $? -eq 0 ]; then
 #   echo "OK new target folder was created ../Archibe/"$datecode
 # else
 #   echo "Unable to create new destination folder"
 #   exit
 # fi


 
  for f in $files; do
      # do some stuff here with "$f"
      # remember to quote it or spaces may misbehave
      echo $f
#      echo `pwd`
      mv $f "../Archive/"$datecode"/"


  done
  sleep 3
done
