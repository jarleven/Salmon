#!/bin/bash


syd () {
  ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -map 0 -f segment -strftime 1 -reset_timestamps 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "syd__%Y-%m-%d__%H-%M-%S.mp4" &
}

nord () {
  ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.87:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -map 0 -f segment -strftime 1 -reset_timestamps 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "nord__%Y-%m-%d__%H-%M-%S.mp4" &
      
}

if [ ! -f "./syd_*.mp4" ]; then
    echo "File not found!"
    syd
fi

sleep 60

if [ ! -f "./nord_*.mp4" ]; then
    echo "File not found!"
    nord
fi

sleep 60


while :
do


  lastfile=$(ls syd*.mp4 -t1 | head -n 1)
  #lastfile="./nord__2019-05-16__11-30-00.mp4"
  echo "Last recorded file is $lastfile"

  if test $(find "$lastfile" -mmin +16) ; then
            echo "File is old"
	    syd
            #ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -map 0 -f segment -strftime 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "syd__%Y-%m-%d__%H-%M-%S.mp4" &

        else
            echo "File is up to date"
        fi

  sleep 60

  lastfile=$(ls nord*.mp4 -t1 | head -n 1)
  #lastfile="./nord__2019-05-16__11-30-00.mp4"
  echo "Last recorded file is $lastfile"

  if test $(find "$lastfile" -mmin +16) ; then
            echo "File is old"
	    nord
            #ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.87:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -map 0 -f segment -strftime 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "nord__%Y-%m-%d__%H-%M-%S.mp4" &
        else
            echo "File is up to date"
        fi

  sleep 60

done



