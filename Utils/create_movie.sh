#!/bin/bash


FOLDER="2022-06-17"
OUTFOLDER="/mnt/storage/Youtube"

ls *.txt

#cp ./full/* ./small/

cd /mnt/storage/Exported/$FOLDER

for (( c=1; c<=2; c++ ))
do  
   echo "Welcome $c times"
   cd /mnt/storage/Exported/$FOLDER


   CAM=$c

   mystring="Eidselva kamera #"$CAM" "$(date +%d.%m.%Y  -d $FOLDER)
   title="Eidselva kamera #"$CAM" Autodetektert "$(date +%d.%m.%Y  -d $FOLDER)
   filename="$OUTFOLDER/cam"$CAM"_autodet_"$(date +%Y-%m-%d  -d $FOLDER)".mp4"
   description="Autodetektert kamera #"$CAM

   echo ""
   echo ""
   echo $mystring
   echo $title
   echo $filename
   echo $description
   echo ""
   echo ""
   echo ""

   sleep 3

   rm -f mylist.txt
   for f in *.jpg; do echo "file '$f'" >> mylist.txt; done
   #for f in *.jpg; do echo "--file '$f'" >> mylist.txt; done

   cat mylist.txt | grep "CAM"$CAM | grep -v "_.jpg" > onelist.txt

   sed -i 's/$/\nduration 0.9/' onelist.txt

   cat onelist.txt

   ffmpeg -f concat -i onelist.txt -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -metadata title="$title" -c:v libx264 -r 30 -pix_fmt yuvj422p $filename < /dev/null

   pwd
   echo "UPLOAD .....["$filename"]" 
   sleep 2

   cd ~
   python3 upload_video.py	--file=$filename \
				--title="$title" \
				--description="$description" \
				--keywords="salmon,eidselva" \
				--category="22" \
				--noauth_local_webserver \
				--privacyStatus="public" 
done
