#!/bin/bash

folder="$1""ready_*"


process_folder=$(ls -t1 -d $folder | head -1)

# Will process the oldest folder named ready_foo in the path passed to the script.
# The folder will be renamed processed_foo when done
# We are assuming that the previous layer "background subtration" will name folders new_foo and rename them to ready_foo when done writing all the JPGs


if [ -z "$process_folder" ]
then
      echo "Nothing to do, exiting"
      exit
fi

echo "Will run Inception on  ["$process_folder"]"

pathname=$(dirname $process_folder)
foldername=$(basename $process_folder)
logname=$process_folder"/logfile.log"

touch $logname

echo $process_folder > $logname


# Run classify all the images in the folder
python3 ~/Salmon/EdgeTPU/classify_folder.py --model ~/EdgeTPU_Models/inception_v1_224_quant_edgetpu.tflite --labels ~/EdgeTPU_Models/imagenet_labels.txt --folder $process_folder --logfile $logname



mv $process_folder $pathname"/done_"${foldername/ready_/}

