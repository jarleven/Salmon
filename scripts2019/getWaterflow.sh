#!/bin/bash

cd /home/jarleven/laksenArcive/NVE-data/

wget https://www2.nve.no/h/hd/plotreal/Q/0089.00001.000/doegndata.txt -O `date +"NVE-data__%Y-%m-%d__%H-%M-%S.txt"`


ls -1t NVE-data*.txt | head -1 |  xargs -I{} cp "{}" tmp.txt


printdate=0

for i in {0..5}
do
  printdate=$i
  DATE=$(date -d "-$printdate day" +"%d%m%Y")
  echo $DATE

  line=$(grep $DATE tmp.txt)

  echo $line

# Example 16062019 0.9788 19.4655 39.742 31.091 24.401
#            1        2      3      4      5      6

  flow=$(awk -F " " '{print $3}' <<< "$line")

  if [ -z "$flow" ]
  then
      echo "No flow data for "$DATE
  else
      echo "Found data"
      break
  fi
done
PRINTDATE=$(date -d "-$printdate day" +"%d. %B")
echo "Stasjon Hornindalsvatn "$PRINTDATE" : "$flow"m3/s"

echo "Stasjon Hornindalsvatn "$PRINTDATE" : "$flow"m3\/s" > /home/jarleven/Youtube/flow.txt

chown jarleven /home/jarleven/Youtube/flow.txt

