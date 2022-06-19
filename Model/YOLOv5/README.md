# K80 GPU

#### The NVIDIA datacenter drivers:
```bash

sudo apt install -y build-essential

wget https://us.download.nvidia.com/tesla/460.32.03/NVIDIA-Linux-x86_64-460.32.03.run
wget https://us.download.nvidia.com/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run
chmod +x NVIDIA-Linux-x86_64-460.106.00.run
sudo ./NVIDIA-Linux-x86_64-460.106.00.run --no-x-check



sudo apt update
sudo apt upgrade -y
sudo apt install -y curl vim git

curl https://get.docker.com | sh && sudo systemctl --now enable docker

# Test Docker
sudo docker run hello-world

# Add the NVIDIA Toolkit to the APT sources list
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add - \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
      
sudo apt update

sudo apt install -y nvidia-docker2
sudo systemctl restart docker

# Test the NVIDIA Container Toolkit
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi







# https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html
sudo sudo docker run --ipc=host -it  --gpus all  nvcr.io/nvidia/tensorrt:21.02-py3
```

#### Run the container
```bash

sudo docker run --ipc=host  --ulimit memlock=-1 --ulimit stack=67108864 -it  --gpus all  nvcr.io/nvidia/tensorrt:21.02-py3

```

#### Inside Docker
```bash

apt update
#apt-get install ffmpeg libsm6 libxext6  -y
python -m pip install --upgrade pip

git clone https://github.com/ultralytics/yolov5
cd yolov5
pip install -r requirements.txt



wget https://github.com/jarleven/Salmon/raw/master/Model/YOLOv5/fiskAI_v3.pt
scp jarleven@192.168.1.199:/RAID/storage/2022/2022-06-15/CAM2__2022-06-15__16-30-01.mp4 .

python export.py --device 0 --weights fiskAI_v3.pt --include engine

python detect.py \
	--weights fiskAI_v3.engine \
	--conf-thres 0.4 \
	--source CAM2__2022-06-15__16-30-01.mp4

```

# FFMPEG
```bash

apt update
DEBIAN_FRONTEND=noninteractive TZ=Europe/Oslo apt-get -y install tzdata
apt install -y build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev

git config --global http.sslverify false
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers
make install
cd -

git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg/
cd ffmpeg
#./configure --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --enable-static --disable-shared
./configure --enable-cuda-nvcc --enable-cuvid --enable-nvenc --enable-nvdec --enable-nonfree --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --enable-static --disable-shared

make -j 8
make install
cd -

```
