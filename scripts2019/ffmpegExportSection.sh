#!/bin/bash


# Print all but two first columns
# Get the title from our timestamp file

input="timestamps.txt"
prestart="10"
duration="180"

inpath="/media/jarleven/6d7e66e8-f56b-497c-91c4-dc3a4db5924f/laksen2019/"
outpath="/home/jarleven/VideoSnapshot/"

input=$1
inpath=$2


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
  echo "Framenum is  ["$timeff"]"

  seconds=$(echo $timeff | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
  echo "Seconds is ["$seconds"]"

  if (( prestart > seconds )); then
    grabstart="0"
  else
    timeff=$(( seconds -10 ))
  fi

  echo "Seconds is ["$timeff"]"

  # TODO. skipped the duration from the input
  #duration=$(echo "$line" | awk '{print $3}')
  echo "Duration is ["$duration"]"


  file=$(echo "$line" | awk '{print $2}')
  echo "File is  ["$file"]"

  fileff="${file/.mp4/}"

  outfile=$(echo $fileff"_"$time"_"$titleff."mp4")
  echo "Saving video as ["$outfile"]"

  if [ -f $inpath$file ]; then
    echo "Input file found"
    if [ ! -f $outpath$outfile ]; then
      echo "Cerate new output file"
      sleep 5 
 #    echo "ffmpeg -i $inpath$file -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -ss $timeff -t $duration -metadata title="$title" -c copy $outpath$outfile"
   #   ffmpeg -i $inpath$file -ss $timeff -t $duration -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -metadata title="$title" -c copy $outpath$outfile &
  # 02.June 2019
  #    ffmpeg -i $inpath$file -ss $timeff -t $duration -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -metadata title="$title" -an $outpath$outfile < /dev/null &

   textkamera=$(awk -F "__" '{print $1}' <<< "$file")
   textdate=$(awk -F "__" '{print $2}' <<< "$file")
   texttime=$(awk -F "__" '{print $3}' <<< "$file" | awk -F "-" '{print $1":"$2":"$3}' | awk -F "." '{print $1}')
   

   textdatetime=$(echo $textdate" "$texttime)
   touch ./dataOverlay.txt
   echo "Eidselva "$title" kamera "$textkamera  > ./dataOverlay.txt
   echo $textdatetime >> ./dataOverlay.txt
   cat ./dataOverlay.txt
   sleep 1


#  input.mp4 -i image.png \
# -filter_complex "[0:v][1:v] overlay=25:25:enable='between(t,0,20)'" \
# -pix_fmt yuv420p -c:a copy \
# output.mp4
   pngImg=$(find /home/jarleven/VideoSnapshot/$file*)
   echo "PNG image is "$pngImg

   rm tmp.mp4 
   echo "FFMPEG export section"
   ffmpeg -loglevel panic -i $inpath$file -ss $timeff -t $duration -vf drawtext="textfile=./dataOverlay.txt:fontcolor=white:fontsize=20:x=10:y=30:" -metadata title="$title" -an "tmp.mp4" < /dev/null &
   wait $!

   # 1280x720       1280    299x299 crop   1280 -299 -25 = 956
   echo "FFMPEG make PIP"
   ffmpeg -loglevel panic -i "tmp.mp4" -i $pngImg -filter_complex "[0:v][1:v] overlay=956:25:enable='between(t,0,8)'" -metadata title="$title" -an $outpath$outfile < /dev/null &
   wait $!

   sleep 1 
 
   youtubeTitle=$(echo $textdatetime" Autodetektert")
   echo "Youtube upload"
   python /home/jarleven/upload_video.py --file="$outpath$outfile" --title="$youtubeTitle" --description="Eidselva Autodetektert, SimpleCV, CUDA, Tensorflow, Google Coral TPU" --keywords="Fishing,Salmon,AI,CUDA,Tensorflow,TPU,Coral"  --category="28" --privacyStatus="public" &
   wait $!

 
  else
      echo "Video already created "$outfile
    fi
  fi

  # The & and the next line with "wait $!" is needed to make sure ffmpeg completes before we loop again

  echo "Next line"
  echo ""

done < "$input"


