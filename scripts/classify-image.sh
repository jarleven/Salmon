#!/bin/bash

dryrun="YES"
dryrun="NOT"


rm -rf tensorflow-log.txt

SEARCH_FOLDER="/home/jarleven/crop/*.jpg"
MODELS="/home/jarleven/CUDA-OpenCV/CUDA8-Tensorflow/models"

        for f in $SEARCH_FOLDER
        do
                echo "Processing file $f"
                file=$(awk -F_ '{print $1}' <<< "$f")
                frame=$(awk -F_ '{print $2}' <<< "$f")
                # ipcam-7--00365.mp4_0154_crop_00001.jpg

	   	if [ "$dryrun" == "NOT" ]
	        then
			echo  "START $f (From file : $file  Frame num: $frame)" >> tensorflow-log.txt
			# RUN THE TENSORFLOW SCRIPT
			python $MODELS/tutorials/image/imagenet/classify_image.py --image_file $f >> tensorflow-log.txt
                	echo "STOP"  >> tensorflow-log.txt
			echo " "  >> tensorflow-log.txt
		else
			echo "    Dryrun"
		fi
	done



#python /home/tredea/github/models/tutorials/image/imagenet/classify_image.py --image_file bilde--2018-06-17_12-42-24--offset_61sec__5_ipcam-2--00558.mp4.jpg
