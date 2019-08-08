#!/bin/bash


syd () {
  ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -map 0 -f segment -strftime 1 -reset_timestamps 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "syd__%Y-%m-%d__%H-%M-%S.mp4"
}

nord () {
  ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.87:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -an -f segment -strftime 1 -reset_timestamps 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "nord__%Y-%m-%d__%H-%M-%S.mp4"
      
}

# 07.07.2019 -an   for ignore audio

# 07.07.2019
#  ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.87:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -c copy -map 0 -f segment -strftime 1 -reset_timestamps 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "nord__%Y-%m-%d__%H-%M-%S.mp4"



#if [ ! -f "./syd_*.mp4" ]; then
#    echo "File not found!"
#    syd
#fi

#sleep 60
#
#if [ ! -f "./nord_*.mp4" ]; then
#    echo "File not found!"
#    nord
#fi

#sleep 60

STREAM="rtsp://192.168.1.87:554/user=admin&password=&channel=0&stream=0.sdp?real_stream"
FILE="nord__%Y-%m-%d__%H-%M-%S.mp4"

while :
do


  lastfile=$(ls nord*.mp4 -t1 | head -n 1)
  echo "Last recorded file is $lastfile"
  date


  ffmpeg -loglevel panic -thread_queue_size 512 -threads 3 -rtsp_transport tcp -stimeout 50000000 -i "$STREAM" -vcodec copy -an -map 0 -f segment -strftime 1 -reset_timestamps 1 -segment_time 900 -segment_atclocktime 1 -segment_format mp4 "$FILE" < /dev/null &
  wait $!
  sleep 1


done



