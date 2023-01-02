#!/bin/bash



#¤d="2019-09-03"
p="/storage"
projectd=$p"/2022_DESEMBER/"

# # Declare an array of string with type
# declare -a StringArray=("2019-09-23" "2019-09-25" "2019-09-27" "2019-09-29"                     )
 
# # Iterate the string array using for loop
# for d in ${StringArray[@]}; do
#    echo $d


# slightly malformed input data
input_start=2022-11-1
input_end=2023-1-1

# After this, startdate and enddate will be valid ISO 8601 dates,
# or the script will have aborted when it encountered unparseable data
# such as input_end=abcd
startdate=$(date -I -d "$input_start") || exit -1
enddate=$(date -I -d "$input_end")     || exit -1

d="$startdate"
while [ "$d" != "$enddate" ]; do 
  echo $d

  FILE=$projectd$d"_logfile.txt"
  ACTIVE=$projectd$d"_activefile.txt"

  SOURCEDIR=$p"/"$d
  if [[ -d "$SOURCEDIR" ]]
  then
    echo "$SOURCEDIR exists on your filesystem."
  else
    echo "----------- NO SOURCE FOLDER -----------"

    d=$(date -I -d "$d + 1 day")
    continue
  fi



  # Test if we completed this date
  if test -f "$FILE"; then
    echo "$FILE exists."
    d=$(date -I -d "$d + 1 day")

    continue
  fi


  # Test if this date is being worked on by another worker
  if test -f "$ACTIVE"; then
    echo "$ACTIVE exists."

    # 60s*60m*24h=86400s
    FILEAGE=$(($(date +%s) - $(date -r $ACTIVE +%s)))
    WAITTIME=36400
    echo "Files is seconds old "$FILEAGE
    if [ $FILEAGE -gt $WAITTIME ]; then
        echo "stuff with your 1day-old "$ACTIVE
        ls -alh $ACTIVE
    else
        echo " --- New "$ACTIVE
        ls -alh $ACTIVE

        echo "File created seconds ago " $FILEAGE "Waiting for other job remaning " $(($WAITTIME - $FILEAGE))

        d=$(date -I -d "$d + 1 day")
        continue
    fi
  fi
  touch $ACTIVE



  rm -f logfile.txt
  touch logfile.txt

  startscript=`date +%s`


  COUNTER=0
  TOTAL=`ls -1 $p/$d/*.mp4 | wc -l`


  for f in $p/$d/*.mp4; do 
        let COUNTER=COUNTER+1

	start=`date +%s`
	
	abc=`date`

	fsize=`ls -ltr --block-size=M $f  | nawk '{print $5}'`

        echo ""
        #echo "#####  $abc processing $f file... [$fsize] Mbyte"
        echo "#####  $abc processing $f file... $COUNTER of $TOTAL  [$fsize] Mbyte"
	echo $projectd 
	echo ""

	start=`date +%s`

	
	python3 detect.py \
		--weights fiskAI_v3.engine \
		--nosave \
		--exist-ok \
		--name $d \
		--project $projectd \
		--conf-thres 0.4 \
		--vid-stride 5 \
		--source $f

	exitCode=$?

	end=`date +%s`

	runtime=$((end-start))

        echo "File $f $fsize MB processed in $runtime sec. Exit code $exitCode" >> logfile.txt
        echo "File $f $fsize MB processed in $runtime sec. Exit code $exitCode"




  done

  rt=$((end-startscript))
  runtime=`date -u -d @${rt} +"%H:%M:%S"`

  echo "Date processed in $runtime sec" >> logfile.txt
  echo "Date processed in $runtime sec"

  cp logfile.txt $projectd$d"_logfile.txt"
  rm $ACTIVE


# increment date

  d=$(date -I -d "$d + 1 day")





done
# python3 detect.py --weights fiskAI_v3.engine --nosave --exist-ok --name testName --project /storage/2022_NOVEMBER/ --conf-thres 0.4 --source /storage/CAM2__2022-06-15__16-30-01.mp4



