# K80 GPU

# The NVIDIA datacenter drivers:
```bash
wget https://us.download.nvidia.com/tesla/460.32.03/NVIDIA-Linux-x86_64-460.32.03.run
wget https://us.download.nvidia.com/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run

# https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html
sudo sudo docker run --ipc=host -it  --gpus all  nvcr.io/nvidia/tensorrt:21.02-py3
```

# Inside Docker
```bash
apt-update
apt-get install ffmpeg libsm6 libxext6  -y

git clone https://github.com/ultralytics/yolov5
cd yolov5
pip install -r requirements.txt
```
