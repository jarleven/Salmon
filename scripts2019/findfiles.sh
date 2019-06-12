#!/bin/bash


# find . -name "*classification.txt" -exec cat {} \; > inference.txt
rm salmon.txt
cat inference.txt | grep -i salmon > salmon.txt
cat inference.txt | grep -i shark >> salmon.txt
cat inference.txt | grep -i sturgeon >> salmon.txt




awk -F "___---___"  '{print $3 " "  $5}' salmon.txt  | awk -F "=" '{print $2 " "$3} ' | awk '$1 > 0.5  {print $3;}' > laksebilder.txt
awk -F "." '{print "done_"$1"/"$1"."$2".jpg"}' laksebilder.txt > filer.txt

