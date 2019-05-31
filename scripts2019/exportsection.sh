#!/bin/bash


# Print all but two first columns
# Get the title from our timestamp file

input="timestamps.txt"
prestart="10"
duration="30"

inpath="/media/jarleven/6d7e66e8-f56b-497c-91c4-dc3a4db5924f/laksen2019/"
outpath="/home/jarleven/VideoSnapshot/"


while IFS= read -r line
do
  echo "$line"
  echo ""
  echo ""
  sleep 1

#  title=`awk '{$1=$2=" "; print $0}' var="${line}"`
#  echo "Title is["$title"]"

  title=$(echo "$line" | awk '{print $1=$2=$3=" "; print $0}')

  # xargs does leading trailing whitespace removal
  title=$(echo $title | xargs)
  echo "Title is ["$title"]"

  # In bash, you can do pattern replacement in a string with the ${VARIABLE//PATTERN/REPLACEMENT} construct. Use just / and not // to replace only the first occurrence.
  titleff="${title// /_}"
  echo "Title is  ["$titleff"]"

  time=$(echo "$line" | awk '{print $1}')
  echo "Time is  ["$time"]"
  
  timeff="${time//_/:}"
  echo "Time is  ["$timeff"]"

  seconds=$(echo $timeff | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
  echo "Seconds is ["$seconds"]"

  if (( prestart > seconds )); then
    grabstart="0"
  else
    timeff=$(( seconds -10 ))
  fi

  echo "Seconds is ["$timeff"]"


  duration=$(echo "$line" | awk '{print $3}')
  echo "Duration is ["$duration"]"


  file=$(echo "$line" | awk '{print $2}')
  echo "File is  ["$file"]"

  fileff="${file/.mp4/}"

  outfile=$(echo $fileff"_"$time"_"$titleff."mp4")
  echo "Saving video as ["$outfile"]"

  ffmpeg -i $inpath$file -ss $timeff -t $duration -metadata title="$title" -c copy $outpath$outfile &

  wait $!

  # The & and the next line with "wait $!" is needed to make sure ffmpeg completes before we loop again

  echo "Next line"
  echo ""

done < "$input"


