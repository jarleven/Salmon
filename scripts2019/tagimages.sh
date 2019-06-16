#!/bin/bash


# ls ../hits/done_syd__2019-06-13__16-15-01/syd__2019-06-13__16-15-01.mp4_19556_crop_00048.jpg^


#Inference: 16.90 ms___---___FPS: 58.97 fps___---___score=0.8477___---___labels=great white shark, white shark, man-eater, man-eating shark, Carcharodon carcharias___---___file=syd__2019-06-09__16-15-01.mp4_4997_crop_00085.jpg


#Inference: 5.66 ms___---___FPS: 175.62 fps___---___score=0.2031___---___labels=coho, cohoe, coho salmon, blue jack, silver salmon, Oncorhynchus kisutch___---___file=syd__2019-06-13__11-30-01.mp4_18261_crop_00042.jpg


#done_syd__2019-06-13__16-15-01/syd__2019-06-13__16-15-01.mp4_2246_crop_00020.jpg

# split -n l/100 parts.txt rm x* parts.txt.

cd /media/jarleven/e0f04099-72b6-44ed-949c-6f95287f9cae/foreground/


list=$1





while read line; do
  echo "$line"
  f=$(awk -F "___---___" '{print $5}' <<< "$line" | awk -F "=" '{print $2}')

   echo "Tagging image - $f"
#   line=$(cat ../foreground/salmon22.txt | grep -F $f)
#   echo $line


    score=$(awk -F "___---___" '{print $3}' <<< "$line" | awk -F "=" '{print $2}')
    label=$(awk -F "___---___" '{print $4}' <<< "$line" | awk -F "=" '{print $2}')
    filename=$(awk -F ".mp4_" '{print $1".mp4"}' <<< "$f")
    folder=$(awk -F ".mp4_" '{print $1}' <<< "$f")

    offset=$(awk -F "_" '{print $6}' <<< "$f")
#    offset=$(awk -F "___---___" '{print $4}' <<< "$line" | awk -F "=" '{print $2}')

   echo "Score:"$score
   echo "Label:"$label
   echo "Filename:"$filename
   echo "Offset:"$offset
   echo "folder:"$folder
   mystring=""
   mystring+=$(printf '%s' "$label")$'\n'
   mystring+=$(printf '%s' "$score")$'\n'
   mystring+=$(printf '%s' "$filename")$'\n'
   mystring+=$(printf '%s' "$offset")$'\n'
   mystring+=$(printf '%s' "(c) Jarl Even Englund")$'\n'

    outfile="../tagged3/tagged_"$f
    infile="done_"$folder"/"$f

    echo $outfile
    echo $infile

    ffmpeg -i $infile -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -qscale:v 0 $outfile  < /dev/null

    # ~/ffmpeg/ffmpeg -y -hwaccel cuvid -i $infile -vf drawtext='fontsize=64:fontcolor=white@0.8:box=1:boxcolor=black@0.75:boxborderw=16:fontfile=OCRA.ttf:text='my_video':x=20:y=40' -qscale:v 0 $outfile  < /dev/null

#    ~/ffmpeg/ffmpeg -y -hwaccel cuvid -i $infile -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:fontfile=OCRA.ttf:" -qscale:v 0 $outfile  < /dev/null

done <$list

exit

while read p; do
  echo "$p"

#  cp $p ../hits/

done < $list_of_fils

exit



## ./configure --enable-cuda --enable-cuvid --enable-nvenc --enable-nonfree --enable-libnpp '--extra-cflags=-I/usr/local/cuda/include -I/path/to/ffnvcodec/include' --extra-ldflags=-L/usr/local/cuda/lib64
















for f in *.jpg
do
   echo "Tagging image - $f"
   line=$(cat ../foreground/salmon22.txt | grep -F $f)
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



