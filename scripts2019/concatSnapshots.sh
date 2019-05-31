#!/bin/bash


# Print all but two first columns
# Get the title from our timestamp file

input="timestamps.txt"
input="timestamps_debug.txt"

combinetime="30"


sort -b -k2,2 -k1,1 $input | uniq > sorted.txt

input="sorted.txt"

echo "99_99_99 zzz__9999-99-99__99-99-99.mp4 99 endmarker" >> $input


prevfile=""
prevtime="0"

kombinetime="0"
kombineline=""



lastline=""

touch longfile.txt
echo "" > longfile.txt 

while IFS= read -r line
do
  echo "$line"


  file=$(echo "$line" | awk '{print $2}')
  echo "File     ["$file"]"


  dur=$(echo "$line" | awk '{print $3}')
  echo "duration ["$dur"]"


  time=$(echo "$line" | awk '{print $1}')
  echo "Time     ["$time"]"
  
  seconds=$(echo $time | awk -F"_" '{ print ($1 * 3600) + ($2 * 60) + $3 }')
  echo "Seconds  ["$seconds"]"

  title=$(echo "$line" | awk '{print $1=$2=$3=" "; print $0}')

  # xargs does leading trailing whitespace removal
  title=$(echo $title | xargs)
  echo "Title    ["$title"]"

  if [ "$file" == "$prevfile" ]; then
    echo "         SAME FILE:"
    echo "           prevtime" $prevtime
    
    delta=$(($seconds-$prevtime))
    echo "           Time delta "$delta
    
    if (( delta > combinetime )); then
      echo "           Timegap, make new file"
        saveline="True"
    else
      echo "           Combine to same file"
      if (( kombinetime == "0" )); then
        kombineline=$prevline
   
      fi

      kombinetime=$(($kombinetime+$delta))
      echo "            Time to add is ["$kombinetime"]"
      saveline="False"


    fi

  else
        saveline="True"

  fi



  

  
  if [ "$saveline" == "True" ]; then

    echo ""
    

    if (( kombinetime > "0" )); then

       echo "SAVING combined file"   
       file=$(echo "$kombineline" | awk '{print $2}')
       echo "  File            ["$file"]"


       dur=$(echo "$kombineline" | awk '{print $3}')
       echo "  First duration  ["$dur"]"
       kombinetime=$(($kombinetime+$dur))
       echo "  Total duration  ["$kombinetime"]"

       time=$(echo "$kombineline" | awk '{print $1}')
       echo "  Timestamp       ["$time"]"
   
       title=$(echo "$kombineline" | awk '{print $1=$2=$3=" "; print $0}')



       # xargs does leading trailing whitespace removal
       title=$(echo $title | xargs)
       echo "  Title           ["$title"]"


       echo $time" "$file" "$kombinetime" "$title>> longfile.txt
       kombinetime=0
  
 
    else
      echo "SAVING single file"
      echo $prevline >> longfile.txt
    fi
 
  fi

  prevfile=$file
  prevtime=$seconds
  prevline=$line


  echo ""


done < "$input"

