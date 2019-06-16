#!/bin/bash

cd /home/jarleven/Youtube

TODAY=$(date +"%Y-%m-%d")
TOMORROW=$(date -d "+1 day" +"%Y-%m-%d")

URL="http://api.sehavniva.no/tideapi.php?lat=61.902132&lon=5.984118&fromtime="$TODAY"T00%3A00&totime="$TOMORROW"T00%3A00&datatype=tab&refcode=msl&place=&file=&lang=nn&interval=10&dst=0&tzone=1&tide_request=locationdata"

wget $URL -O tides.xml




# <tide>
# <locationdata>
# <location name="MÅLØY" code="MAY" latitude="61.902132" longitude="5.984118" delay="0" factor="1.02" obsname="MÅLØY" obscode="MAY"/>
# <reflevelcode>MSL</reflevelcode>
# <data type="prediction" unit="cm">
# <waterlevel value="-83.1" time="2019-06-16T04:00:00+01:00" flag="low"/>
# <waterlevel value="58.0" time="2019-06-16T10:08:00+01:00" flag="high"/>
# <waterlevel value="-85.4" time="2019-06-16T16:21:00+01:00" flag="low"/>
# <waterlevel value="59.6" time="2019-06-16T22:30:00+01:00" flag="high"/>
# </data>
# </locationdata>
# </tide>

echo "---"
echo "["$URL"]"
echo "---"

grep "waterlevel value" tides.xml > tides.txt

sed -i 's/"/ /g' tides.txt
sed -i 's/+/ /g' tides.txt
sed -i 's/T/ /g' tides.txt
sed -i 's/:/ /g' tides.txt

#awk '{ print $3" " $6":"$7 }' tides.txt > tmp.txt

#awk '{printf "%1s\n", $3}' tides.txt > tmp.txt
awk '{printf("%15.1fcm %02d:%02d\n",$3,$6,$7)}' tides.txt > tmp.txt
mv tmp.txt tides.txt

# -83.1cm 04:00
#  58.0cm 10:08
# -85.4cm 16:21
#  59.6cm 22:30

sed -i '1s/^/  --- CLOCK DATA ---\n/' tides.txt


mv tides.txt dataOverlay.txt 
echo "---"
echo "---"
cat dataOverlay.txt
echo "---"
echo "---"

chown jarleven dataOverlay.txt

