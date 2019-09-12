#!/bin/bash


#live=$1
live=true
prob="0.7"
#prob=$2

MINHITS=1


HISTORYLOG="/home/jarleven/LaksenLive/history2.txt"
OUTPUTFOLDER="/home/jarleven/VideoSnapshot_Sep_2019/"

INPUTFOLDER="/media/jarleven/e0f04099-72b6-44ed-949c-6f95287f9cae/AutoForegroundSeptember2019"

echo ""
echo ""
echo "Probability : $prob"
echo "Minimumhits : $MINHITS"
echo "History logfile : [$HISTORYLOG]"
echo " "

echo "Input folder : [$INPUTFOLDER]"

echo "Output folder : [$OUTPUTFOLDER]"
echo ""
echo ""

#exit
sleep 10


mkdir $OUTPUTFOLDER

touch $HISTORYLOG


find . -name "logfile_classification.txt" -print | sort -nr > inference_log_all2.txt


while read p; do
     lines=$(cat $p | wc -l)

     echo "$p   lines $lines"

     grep -E 'salmon|shark|sturgeon' $p > tmpA.txt


     awk -F "___---___"  '{print $3 " "  $5}' tmpA.txt  | awk -F "=" '{print $2 " "$3} ' | awk -v prob1=$prob '$1 > prob1  {print $3" "$1}' > tmpA2.txt
     lines=$(cat tmpA2.txt | wc -l)

#     hit=$(cat tmpA2.txt | head -1)

#     echo $hit
     if [ "$lines" -ge "$MINHITS" ];then
       echo "We have multiple hits, proably interesting";

       while read hit; do

       if [ ! -z "$hit" ]
       then
 #     echo "No fish found in this file"
 #    else
      
        echo "Found fish in $lines lines, report it"
        echo "Working on line ["$hit"]"



        # syd__2019-06-21__05-30-01.mp4_8702_crop_00065.jpg

        # Messy calculation to get the time of the hit. Time + frame offset
        probability=$(awk '{print $2}' <<< "$hit")
        tileimg=$(awk '{print $1}' <<< "$hit")

        filename=$(awk -F "mp4" '{print $1"mp4"}' <<< "$hit")
#        echo "filename ["$filename"]"

        a=$(awk -F "d__" '{print $2}' <<< "$hit" | awk -F "_crop" '{print $1}')
        b=$(awk -F ".mp4_" '{print $1}' <<< "$a")
        offset=$(awk -F ".mp4_" '{print $2}' <<< "$a")

        date=$(awk -F "__" '{print $1}' <<< "$b")

        time=$(awk -F "__" '{print $2}' <<< "$b")
        time2=$(awk -F "-" '{print $1":"$2":"$3}' <<< "$time")

        seconds=$(expr $offset / 25)
#        echo "Seconds ="$seconds      

        starttime="$date $time2"

        fishtime=$(date -d "$starttime $seconds sec" "+%Y-%m-%d %H:%M:%S")

        offsetmin=$(date -d "0 $seconds sec" "+%M:%S")


#        echo "Intime "$starttime
#        echo "Time "$time2
#        echo "Offs "$offset" frames   "$seconds"s   "$offsetmin" min:sec"
#        echo "Fish "$fishtime



         ffmpegoffset=$(date -d "0 $seconds sec" "+%H_%M_%S")

        logfish=$(echo $ffmpegoffset" "$filename" 30 Autodetektert")
         
        echo "Logging as [$logfish]"

          if grep -Fxq "$logfish" $HISTORYLOG
          then
              echo "Already found"
          else
              # code if not found
              echo "not found. LOGGING"
              if [[ "$live" = "true" ]]
              then
                  echo " ---------------------------------------------- LOGGING -----------------------------"

                  echo "looking for $tileimg"


                 tilefolder=$(awk -F "." '{print "done_"$1}' <<< "$tileimg")
                 echo "Tileimage folder [$tilefolder]"

                 tileimgabspath="$INPUTFOLDER/$tilefolder/$tileimg"
                 ls -al $tileimgabspath
                  
                  echo "Copy file  $tileimgabspath"
                  cp $tileimgabspath $OUTPUTFOLDER



                  sed -i "1s/^/$logfish\n/" $HISTORYLOG

              else
                  echo "DRYRUN !"

              fi
         fi

      fi
done <tmpA2.txt


   fi


done <inference_log_all2.txt

