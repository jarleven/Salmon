#!/bin/bash

# OK 10. Jun 2019
# jarleven@CUDA:~$ Salmon/EdgeTPU/edgetpu_process.sh /home/jarleven/foreground/

#
# Salmon/EdgeTPU/edgetpu_process.sh /media/jarleven/e0f04099-72b6-44ed-949c-6f95287f9cae/foreground



# Test parameter in
# Does folder exist ?

# Do we have EdgeTPU
# Do we have the python script ?
# Do we have the model files nad the labels ?


folder="$1""ready_*"

scriptfolder=$(dirname "$0")
echo $scriptfolder

model=~/EdgeTPU_Models/inception_v1_224_quant_edgetpu.tflite
labels=~/EdgeTPU_Models/imagenet_labels.txt 






while true; do

    process_folder=$(ls -t1 -d $folder | head -1)

    # Will process the oldest folder named ready_foo in the path passed to the script.
    # The folder will be renamed processed_foo when done
    # We are assuming that the previous layer "background subtration" will name folders new_foo and rename them to ready_foo when done writing all the JPGs


    if [ -z "$process_folder" ]
    then
        echo "Nothing to do, exiting"
        sleep 11
        continue
    fi


    pathname=$(dirname $process_folder)
    foldername=$(basename $process_folder)
    logfile=$process_folder"/logfile_classification.txt"

    touch $logfile

    echo $process_folder > $logfile

    echo "Will run Inception on ["$process_folder"]"
    echo "Logging results to    ["$logfile"]"

    # Run classify all the images in the folder
    #python3 ~/Salmon/EdgeTPU/classify_folder.py --model ~/EdgeTPU_Models/inception_v1_224_quant_edgetpu.tflite --labels ~/EdgeTPU_Models/imagenet_labels.txt --folder $process_folder --logfile $logname

    python3 $scriptfolder/classify_folder.py --model $model --labels $labels --folder $process_folder --logfile $logfile


    # Rename the folder we processed
    mv $process_folder $pathname"/done_"${foldername/ready_/}

done


