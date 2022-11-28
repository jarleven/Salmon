### Some notes about Docker (again)


### List all docker containers


sudo docker ps -a

-rm (Delete container after closing)
--name MyContainer (Give the container a name)

sudo docker attach MyContainer
sudo docker start MyContainer

### Delete all Docker containers
sudo docker system prune -a -f

### K80 and YOLOv7 / YOLOv5

```
## NVIDIA DRIVER HP DL380 Gen 9  / K80
#  Ubuntu 18.04
#  Ubuntu 20.04
# 
sudo add-apt-repository -y ppa:graphics-drivers/ppa
ubuntu-drivers devices
sudo apt install nvidia-driver-470


sudo apt install -y sshfs 
sudo mkdir /mnt/storage
sudo sshfs -o allow_other jarleven@192.168.1.199:/RAID/storage/2022/ /mnt/storage
#sudo sshfs -o allow_other jarleven@192.168.1.178:/home/jarleven/laksenArcive/Archive /mnt/storage
 


sudo docker pull nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
sudo docker run --shm-size 8G --gpus all -it -v /mnt/storage:/storage nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

# Tested 23.November 2022 with driver 470.141.03
sudo docker pull nvidia/cuda:11.4.0-cudnn8-devel-ubuntu20.04
sudo docker run --shm-size 8G --gpus all -it -v /mnt/storage:/storage nvidia/cuda:11.4.0-cudnn8-devel-ubuntu20.04
# 11.4.3 also available 27.11.2022


# 27. November 2022
sudo docker run --shm-size 8G --gpus all -it -v /mnt/storage:/storage nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04



apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive TZ=Europe/Oslo apt-get -y install tzdata

apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

# Not included in 20.04 image above
apt install -y git vim wget curl unzip 
apt install -y python3 python3-pip python3-openssl
python3 -m pip install --upgrade pip


git clone https://github.com/ultralytics/yolov5.git
cd yolov5/
sed -i 's/opencv-python/opencv-python-headless/g' requirements.txt
python3 -m pip install -r requirements.txt

python3 -m pip install nvidia-tensorrt==8.0.3.4 --index-url https://pypi.ngc.nvidia.com
python3 -m pip install nvidia-pyindex
python3 -m pip install onnx


# nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04
# Installs this 
#python3 -m pip install nvidia-tensorrt==8.4.3.1 --index-url https://pypi.ngc.nvidia.com


git clone https://github.com/WongKinYiu/yolov7
cd yolov7
python -m pip install -r requirements.txt
# python -m pip install opencv-python-headless  # ImportError: libGL.so.1: cannot open shared object file: No such file or directory



```

### NVIDIA GPU power management
```
sudo nvidia-smi -i 0 -pm ENABLED
Enabled persistence mode for GPU 00000000:01:00.0.

sudo nvidia-smi -i 0 -pl 100
Power limit for GPU 00000000:01:00.0 was set to 100.00 W from 149.00 W.

```


### List of NVIDA CUDA  containers
https://gitlab.com/nvidia/container-images/cuda/blob/master/doc/supported-tags.md
