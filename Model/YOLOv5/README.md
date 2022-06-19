# K80 GPU

#### The NVIDIA datacenter drivers:
```bash

sudo apt install -y build-essential

wget https://us.download.nvidia.com/tesla/460.32.03/NVIDIA-Linux-x86_64-460.32.03.run
wget https://us.download.nvidia.com/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run
chmod +x NVIDIA-Linux-x86_64-460.106.00.run
sudo ./NVIDIA-Linux-x86_64-460.106.00.run --no-x-check


# https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html
sudo sudo docker run --ipc=host -it  --gpus all  nvcr.io/nvidia/tensorrt:21.02-py3
```

#### Run the container
```bash

sudo docker run --ipc=host  --ulimit memlock=-1 --ulimit stack=67108864 -it  --gpus all  nvcr.io/nvidia/tensorrt:21.02-py3

```

#### Inside Docker
```bash

apt-update
#apt-get install ffmpeg libsm6 libxext6  -y
python -m pip install --upgrade pip

git clone https://github.com/ultralytics/yolov5
cd yolov5
pip install -r requirements.txt

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
