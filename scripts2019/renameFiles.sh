#!/bin/bash

folder=$1 

# Naming convention
# syd__2019-05-31__14-15-00.mp4

# As created with "date +%Y-%m-%d__%H-%M-%S"
# date -d@`stat -c %Y testfile.txt` +%Y-%m-%d__%H-%M-%S

logfile=$(date +renameLog__%Y-%m-%d__%H-%M-%S.txt)

touch $logfile


echo "Log input output filename pair for future reference" >> $logfile

echo "Input folder ["$folder"]"
echo ""


for f in $folder*.mp4; do
    echo "processing file["$f"]"

    # Do some sanitycheck, only move files from 2018 without timestampwd filenames!
    if [[ $f == *"/ipcam-"* ]]; then
        
      # Get the seconds since Epoch of the file modification. Then create a filemane from that timestamp. 
      fdate=$(stat -c %Y $f)	# 2019-05-26 13:04:42.xxxxxx
      filename=$(date -d@"$fdate" +renamed__%Y-%m-%d__%H-%M-%S.mp4)

      echo "Filename out is ["$filename"]"
      fpath=$(dirname $f)
      echo "Path out is ["$fpath"]"
      fpath=$fpath"/"$filename
      echo "Filepath out is ["$fpath"]"

      mv $f $fpath

      echo "["$filename"]  <---  ["$f"]" >> $logfile
    fi
    echo ""


done

echo "cat "$logfile



