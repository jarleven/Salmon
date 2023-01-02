#!/bin/bash

# FFMPEG 2
# sudo sshfs -o allow_other jarleven@192.168.1.150:/home/jarleven/streamout /mnt/storage


# FFMPEG 1
# sudo sshfs -o allow_other jarleven@192.168.1.140:/home/jarleven/streamout /mnt/storage
#


name="livestream"
projectd="/storage/detect"

echo "Starting"

while true
do


  for f in /storage/*.mp4; do 


	filename=$(basename -- "$f")
	extension="${filename##*.}"
	filename="${filename%.*}"

	logfile="/storage/"$filename".txt"


	# Test if we completed this date
	if test -f "$logfile"; then
		echo "$logfile exists."


		if [ -s $logfile ]
		then
		     echo "File is not empty"
		     continue
		else
		     echo "File is empty"
		fi

	fi
	echo ""


	touch $logfile

	start=`date +%s`
	
	abc=`date`

	fsize=`ls -ltr --block-size=M $f  | nawk '{print $5}'`

        echo ""
        #echo "#####  $abc processing $f file... [$fsize] Mbyte"
        echo "#####  $abc processing $f file... [$fsize] Mbyte"
	echo $projectd 
	echo ""

	start=`date +%s`

	
	python3 detect.py \
		--weights fiskAI_v3.engine \
		--nosave \
		--exist-ok \
		--name $name \
		--project $projectd \
		--conf-thres 0.4 \
		--vid-stride 5 \
		--source $f

	exitCode=$?

	end=`date +%s`

	runtime=$((end-start))

        echo "File $f $fsize MB processed in $runtime sec. Exit code $exitCode" >> logfile.txt
        echo "File $f $fsize MB processed in $runtime sec. Exit code $exitCode"


	if [ $exitCode -ne 0 ]; then
	    echo "Error"
	else
	    echo "File $f $fsize MB processed in $runtime sec. Exit code $exitCode" >> $logfile

	fi

  done

  echo "Sleeping a bit..."
  sleep 60

done


