!#/bin/bash




rm -rf ../hits
mkdir ../hits

while read p; do
  echo "$p"

  cp $p ../hits/

done <filer.txt
