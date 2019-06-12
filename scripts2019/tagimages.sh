#!/bin/bash





#Inference: 16.90 ms___---___FPS: 58.97 fps___---___score=0.8477___---___labels=great white shark, white shark, man-eater, man-eating shark, Carcharodon carcharias___---___file=syd__2019-06-09__16-15-01.mp4_4997_crop_00085.jpg

cd $1



for f in *.jpg
do
	echo "Removing password for pdf file - $f"
   line=$(cat ../foreground/salmon.txt | grep -F $f)
  echo $line


    score=$(awk -F "___---___" '{print $3}' <<< "$line" | awk -F "=" '{print $2}')
    label=$(awk -F "___---___" '{print $4}' <<< "$line" | awk -F "=" '{print $2}')
    filename=$(awk -F ".mp4_" '{print $1".mp4"}' <<< "$f")
    offset=$(awk -F "_" '{print $6}' <<< "$f")
#    offset=$(awk -F "___---___" '{print $4}' <<< "$line" | awk -F "=" '{print $2}')

   echo $score
   echo $label
   echo $filename
   echo $offset
   mystring=""
   mystring+=$(printf '%s' "$label")$'\n'
   mystring+=$(printf '%s' "$score")$'\n'
   mystring+=$(printf '%s' "$filename")$'\n'
   mystring+=$(printf '%s' "$offset")$'\n'

    outfile="tagged_"$f

    echo $outfile

    ffmpeg -i $f -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -qscale:v 0 $outfile  < /dev/null

done



