#!/bin/bash

for f in ./*.mp4; do
    # do some stuff here with "$f"
    # remember to quote it or spaces may misbehave
    echo $f

    string='My long string'
    if [[ $f == *"2019-05-26"* ]]; then
      echo "It's there!"
      continue
    fi

    string='My long string'
    if [[ $f == *"2019-05-27"* ]]; then
      echo "It's there!"
      continue
    fi

    string='My long string'
    if [[ $f == *"2019-05-28"* ]]; then
      echo "It's there!"
      continue
    fi
    


    infile=$f
    tmpname=$(basename $f .mp4)
    outfile=$tmpname"testing.mp4"

    echo "In  ["$infile"]"
    echo "Out   ["$outfile"]"
    sleep 2   
    
    ffmpeg  -i $infile -c copy -reset_timestamps 1 "../test/"$outfile &
    wait $!

done

