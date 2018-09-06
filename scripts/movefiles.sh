#§/bn/bash

find  /media/tredea/4ae385b1-aa64-462f-8e40-093a1233a92c/Laksen/IPCam/Live2/*.mp4 -type f -mmin +1440 -print0 | while read -d $'\0' file
do
	date=$(stat -c %y $file | awk -F" " '{print $1}')
	echo $date "   " $file
	mkdir -p /media/tredea/4ae385b1-aa64-462f-8e40-093a1233a92c/Laksen/IPCam/$date
	mv $file  /media/tredea/4ae385b1-aa64-462f-8e40-093a1233a92c/Laksen/IPCam/$date/
done

