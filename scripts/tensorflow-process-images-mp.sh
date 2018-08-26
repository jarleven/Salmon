#!/bin/bash

START=$(date +%s.%N)


# Run one time first to download the model (TODO up for improvement!)
python3 /home/jarleven/models/tutorials/image/imagenet/classify_image.py


N=6

# The folder to process TODO send as parameter
SEARCH_FOLDER="/home/jarleven/cropped/*.jpg"

# Delete empty files 
find /home/jarleven/cropped/*.txt -type f  -empty -delete

# All lines should contain a score, if not something went wrong
# cat *.txt | grep -v "score ="

# Number of instanses to run of classify_image.py
N=6

i=0
for f in $SEARCH_FOLDER
do
        echo $f

	((i=i%N)); ((i++==0)) && wait

	FILE=$f".txt"      
	if [ ! -f  $FILE ]; then
		python3 /home/jarleven/models/tutorials/image/imagenet/classify_image.py --image_file $f > $FILE &
		let i=i+1
	fi		
done

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)
echo "Time spent" $DIFF
echo "Done"

