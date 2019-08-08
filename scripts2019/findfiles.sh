#!/bin/bash

# cd $1

cd /media/jarleven/e0f04099-72b6-44ed-949c-6f95287f9cae/foreground/

# TODO
#  Input parameter
#  Output dir

find . -name "*classification.txt" -exec cat {} \; > inference.txt

rm -f tmp.txt
rm -f tmp2.txt
rm -f parts.txt.*
rm hits.txt
rm slices.txt

touch tmp.txt
touch tmp2.txt

cat inference.txt | grep -i salmon > tmp.txt
cat inference.txt | grep -i shark >> tmp.txt
cat inference.txt | grep -i sturgeon >> tmp.txt
cat inference.txt | grep -i goldfish >> tmp.txt


#                                                                                             Probability is 0.5
awk -F "___---___"  '{print $3 " "  $5}' tmp.txt  | awk -F "=" '{print $2 " "$3} ' | awk '$1 > 0.5  {print $3;}' > tmp2.txt

# tmp2.txt contain all the filenames we are interedted in


# Create a list of the Tensorflow process done filtering out the filenames we are interested in

#           MATCHLIST INPUT
grep -Fw -f tmp2.txt tmp.txt > hits.txt


# Splitt the list in equal parts. 
split -n l/10 hits.txt parts.txt.

# Make a list of all the filenames containing the the sliced lists
ls -1 parts.txt.* > slices.txt

rm -rf ../tagged
mkdir ../tagged


# Start the tagging on 100 proceses. (Maybee N threads -1 ?)
while read line; do
  echo "$line"
  x-terminal-emulator -e /home/jarleven/Salmon/scripts2019/tagimages.sh $line

done < slices.txt
