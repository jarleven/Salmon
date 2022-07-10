apt update
#apt-get install ffmpeg libsm6 libxext6  -y
python -m pip install --upgrade pip
python -m pascal-voc-writer

git clone https://github.com/ultralytics/yolov5
cd yolov5
pip install -r requirements.txt

python -m pip install opencv-python-headless  # ImportError: libGL.so.1: cannot open shared object file: No such file or directory
