#!/bin/bash


# Test input parameters
# Does folders exist ?

folder=$1 
output=$2

# Naming convention
# syd__2019-05-31__14-15-00.mp4

# As created with "date +%Y-%m-%d__%H-%M-%S"
# date -d@`stat -c %Y testfile.txt` +%Y-%m-%d__%H-%M-%S

#logfile=$(date +renameLog__%Y-%m-%d__%H-%M-%S.txt)

#touch $logfile



echo "Input folder ["$folder"]"
echo ""


for f in $folder*.mp4; do

    name=$(basename $f .mp4)
    outfolder=$output"new_"$name"/"
    donefolder=$output"ready_"$name"/"
    datestring=$(date +%Y-%m-%d__%H-%M-%S)

    echo ""
    echo ""
    echo "processing file["$f"]"
    echo " Input folder  ["$folder"]"
    echo " Name exl .mp4 ["$name"]"
    echo " Outpath       ["$output"]"
    echo " Outfolder     ["$outfolder"]"
    echo " Donefolder    ["$donefolder"]"
    echo " Datestring    ["$datestring"]"

    echo ""
    echo ""

    
    # TODO what if path does not exist
    mkdir $outfolder

    logfile=$outfolder"/"$name"_bgsub.txt"
    touch $logfile
    echo "Log of background subtraction "$datestring >> $logfile

    #chmod a+x /home/jarleven/background_subtraction
    #export PATH="$PATH:/home/jarleven/"

 #   ( exec "~/background_subtraction $name $outfolder $logfile" )
#    background_subtraction $name $outfolder $logfile
 #   background_subtraktion $name $outfolder $logfile

    #/home/jarleven/opencv/samples/gpu

#    ~/background_subtraction $file $outfolder $logfile "testing"
    /home/jarleven/opencv/samples/gpu/a.out $f $outfolder $logfile
    echo ""

    # Rename the folder so we can start image classification from another process/shell or client

    mv $outfolder $donefolder 

done


