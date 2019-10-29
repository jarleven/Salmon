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

echo ""
echo ""
echo $scriptfolder

model=~/EdgeTPU_Models/inception_v1_224_quant_edgetpu.tflite
labels=~/EdgeTPU_Models/imagenet_labels.txt 






while true; do

    process_folder=$(ls -t1 -d $folder 2>/dev/null | head -1)

    # Will process the oldest folder named ready_foo in the path passed to the script.
    # The folder will be renamed processed_foo when done
    # We are assuming that the previous layer "background subtration" will name folders new_foo and rename them to ready_foo when done writing all the JPGs




    if [ -z "$process_folder" ]
    then
        echo -n "Nothing to do, wait a bit  -  "
        sleep 30
        continue
    fi

    echo " Process folder [$process_folder]"


    pathname=$(dirname $process_folder)
    foldername=$(basename $process_folder)

    outputfolder=${foldername/ready_/readytmp_}
    outputpath=$pathname"/"$outputfolder

    echo "Process folder $process_folder "
    echo "Outputfolder $outputpath"
    echo "Pathname $pathname"
    echo "Foldername $foldername"
    echo "Moving like this : $process_folder"/" $pathname"/"$outputfolder"


    echo "The proc folder " $process_folder
    mv $process_folder"/" $outputpath

    if [ $? -ne 0 ] ; then
       echo "fatal error moving the folder, racecondition"
       sleep 2
       continue
    else
       echo "success moving $process_folder"
    fi


    sleep 2

    process_folder=$outputpath

    # Now the readytmp is used.
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

    outputfolder=${foldername/readytmp_/done_}
    outputpath=$pathname"/"$outputfolder

    echo "Process folder $process_folder "
    echo "Outputfolder $outputpath"
    echo "Pathname $pathname"
    echo "Foldername $foldername"
    echo "Moving like this : $process_folder"/" $pathname"/"$outputfolder"

    sleep 2

if [ -d "$outputpath" ]; then
  # Take action if $DIR exists. #
  echo "This folder have already been created  $outputpath    ..."
  echo "Delete it !"
  rm -rf $outputpath
  sleep 2
fi




    mv $process_folder"/" $outputpath


    sleep 2 


done


