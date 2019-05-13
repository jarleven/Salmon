

rtsp://192.168.1.10:554/user=admin&password=&channel=0&stream=0.sdp?real_stream

rtsp://192.168.1.116:554/user=admin&password=&channel=1&stream=0.sdp?

rtsp://192.168.1.10:554/user=admin&password=&channe1=1&stream=1.sdp?

rtsp://192.168.1.10:554//11


ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -y -f image2 -qscale 0 -frames 1 /home/jarleven/test.jpeg


https://ffmpeg.zeranoe.com/forum/viewtopic.php?t=4259


Save/copy stream to file (OK )
ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -acodec copy -vcodec copy c:/abc.mp4

Stream #0:0: Video: h264 ([33][0][0][0] / 0x0021), yuv420p, 1280x720, q=2-31, 25 fps, 25 tbr, 90k tbn, 90k tbc
	

avconv -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -c copy -map 0 -f segment -segment_time 300 -segment_format mp4 "capture-%03d.mp4"
avconv -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -c copy -map 0 -f segment -segment_time 120 -segment_format mp4 "capture-%03d.mp4"
I would advise that you want to use -segment_atclocktime 1 if the application is for "CCTV". As this will try to split based on the wall clock and not time since recording began. 



ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -vf "select=gt(scene\,0.003),setpts=N/(25*TB)" output.avi



ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -vf output1.avi


http://www.hkvstar.com/technology-news/tutorial-how-to-config-security-ip-camera.html


Hi3518C telnet
http://www.openipcam.com/forum/index.php?topic=865.0

http://marcusjenkins.com/hacking-cheap-ebay-ip-camera/


http://askubuntu.com/questions/519088/has-anybody-got-access-to-a-h264-stream-of-an-ip-cam-over-simplecvb

avconv -i rtsp://IPADDRESS:554/h264 -f image2 -r 1 -updatefirst 1 /path/to/img.jpg

avconv -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream"  -f image2 -r 1 -updatefirst 1 img.jpg




avconv -i rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp? -f image2 -r 1 -updatefirst 1 img.jpg



avconv -i rtsp://admin:@192.168.1.10:554/ch0_0.h264 -f image2 -r 1 -updatefirst 1 img.jpg



ffmpeg -i rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp? -c copy -map 0 -f segment -segment_time 300 -segment_format mp4 "capture-%03d.mp4"



ffmpeg -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp? " -c:v copy -t 120 stream.mp4

rtsp://admin@192.168.1.10:554/h264



ffmpeg -ss 2 -i rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp? -y -f image2 -qscale 0 -frames 1 /home/jarleven/test.jpeg



ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -y -f image2 -qscale 0 -frames 1 /home/jarleven/test.jpeg




ffmpeg -rtsp_transport tcp -stimeout 50000000 -i "rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?real_stream" -acodec copy -vcodec copy c:/abc.mp4

