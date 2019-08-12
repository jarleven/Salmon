# ffmpeg used to capture RTSP stream

### Deshake
https://www.ffmpeg.org/ffmpeg-filters.html#deshake
```
ffmpeg -i input.mp4 -vf deshake output.mp4
```


```
sudo apt install libimage-exiftool-perl
```


### RTSP directly live on youtube
```
ffmpeg -f lavfi -i anullsrc -rtsp_transport udp -i "rtsp://192.168.1.10:554/user=admin&password=&channel=0&stream=0.sdp?real_stream" -tune zerolatency -vcodec libx264 -t 12:00:00 -pix_fmt + -c:v copy -c:a aac -strict experimental -f flv rtmp://x.rtmp.youtube.com/live2/xxxx-xxxx-xxxx-xxxx
```

### NVIDIA CUDA/cuvid HW accelrated
```
./ffmpeg -y -hwaccel cuvid -thread_queue_size 512 -vsync 0 -rtsp_transport tcp -i "rtsp://192.168.1.10:554/user=admin&password=&channel=0&stream=0.sdp?real_stream"        -r 24 -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2        -i /dev/zero -acodec aac -ab 128k -strict experimental -s 1280x960        -vcodec h264_nvenc         -f flv "rtmp://x.rtmp.youtube.com/live2/xxxx-xxxx-xxxx-xxxx"
```
