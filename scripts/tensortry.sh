#!/bin/bash

filename="$1"
#filename="tensorflow-log.txt"

outdir="/home/jarleven/TFFILES"
outlog="/home/jarleven/tensortry-log.txt"

mkdir $outdir

if [ $# -ne 0 ] ; then
	filename=$1
	echo "$filename to process is"
fi

#declare -a arr=("salmon" "shark" "whale" "fish")
declare -a arr=("salmon" "shark" )


SCORELIM=10000

fileprocessing=""
mystring=""



COUNTER=0
while read -r line
do
    name="$line"

    key=$(awk '{print $1}' <<< "$line")

    if [ "$key" == "START" ]
    then
	    fileprocessing=$(awk '{print $2}' <<< "$line")

    elif [ "$key" == "STOP" ]
    then
	if [ "$mystring" != "" ]
	then
		echo "      $fileprocessing" 
		echo -e "      $mystring"
		

		outfile=$(basename $fileprocessing)
		echo -e "      $outfile"
		#printf "%s" "$mystring"

		#cp "$fileprocessing" "$outdir/$outfile"
		ffmpeg -i $fileprocessing -vf drawtext="text='$mystring':fontcolor=white:fontsize=20:x=10:y=40:" -qscale:v 0 "$outdir/$outfile" < /dev/null
                echo "$fileprocessing" >> $outlog
                echo -e "$mystring" >> $outlog
						 

		let COUNTER=COUNTER+1

	fi
    	    #echo "    The file is --- $fileprocessing"
	#echo "    The string is "
	#echo " "
	#echo " "
        mystring=""

	:
    elif [ "$key" == "" ]
    then
	#echo "Emtyp line ------------------"
	:
    else
	#echo "    keep it --- $line   from file $fileprocessing"

	## now loop through the above array
	for i in "${arr[@]}"
	do
		if [[ $line = *$i* ]]; then

			score=$(awk -F"." '{print $2}' <<< "$line")
			score=$(awk -F")" '{print $1}' <<< "$score")
			score=$((10#$score))
			echo "      SCORE [$score]"

			if [ "$score" -gt "$SCORELIM" ]; then

		  #echo "    keep it --- $line   from file $fileprocessing"
		  #mystring="$mystring  ------ $line ---\\\n"
		  #mystring=$(printf "%s    -----   {NL}" $linei
		  	  #echo "$line"
			  mystring+=$(printf '%s' "$line")$'\n'
			fi
  		  fi
		#echo "$i"
	   # or do whatever with individual element of the array
	done




    fi


    #echo "Name read from file - $name"




done < "$filename"
