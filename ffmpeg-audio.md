#### Record audion on Raspberry Pi and send it to another ffmpeg instance for mixing with video



´´´console
ffmpeg -re \
       -f avfoundation -ar 44100 -ac 1 -f alsa -i hw:2 \
       -codec:v null \
       -codec:a aac -ab 128k -g 10 \
       -sdp_file saved_sdp_file \
       -f rtp rtp://192.168.1.171:7005


The SDP description have to be transfered manually!
scp saved_sdp_file user@192.168.1.171:~

´´´

This stream can be saved on a remote client
´´´console       
 ffmpeg -protocol_whitelist "file,rtp,udp" -i saved_sdp_file -strict -2 saved_audio_file.aac 
´´´



This ffmpeg instance runs on IP 192.168.1.171
´´´console
OVERLAY=/tmp/ramdisk/vi-beklager-teknisk-feil.png
PRIMARYINPUT="rtsp://192.168.1.87:554/user=admin&password=&channel=1&stream=0.sdp?real_stream"
YOUTUBEKEY=xxxx
´´´

Mix the RTP audio stream with the RTSP camera video feed.
´´´console
ffmpeg -thread_queue_size 1024 \
       -hwaccel cuvid -c:v h264_cuvid -deint 2 \
       -drop_second_field 1 -vsync 0 \
       -rtsp_transport tcp -i $PRIMARYINPUT \
       -f image2 -stream_loop -1 -r 2 -i "$OVERLAY" \
       -protocol_whitelist "file,rtp,udp" -i saved_sdp_file \
       -filter_complex "[0:v]hwdownload,format=nv12 [base]; [base][1:v] overlay=0 [marked]" \
       -map "[marked]:v" \
       -map "2:a" \
       -acodec copy \
       -vcodec h264_nvenc -b:v 25M -forced-idr 1 -force_key_frames "expr:gte(t,n_forced*4)" \
       -f flv "rtmp://x.rtmp.youtube.com/live2/$YOUTUBEKEY"

´´´
