### Some notes about Docker (again)


### K80 and YOLOv7 / YOLOv5

```
# Ubuntu 18.04  
sudo apt update && sudo apt upgrade -y

wget https://us.download.nvidia.com/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run
chmod +x NVIDIA-Linux-x86_64-460.106.00.run
sudo ./NVIDIA-Linux-x86_64-460.106.00.run --no-x-check

sudo apt install -y sshfs 
sudo mkdir /mnt/storage
sudo sshfs -o allow_other jarleven@192.168.1.199:/RAID/storage/2022/ /mnt/storage
#sudo sshfs -o allow_other jarleven@192.168.1.165:/home/jarleven/laksenArcive/Archive /mnt/storage
 

sudo docker pull nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
sudo docker run --shm-size 8G --gpus all -it -v /mnt/storage:/storage nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04


apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive TZ=Europe/Oslo apt-get -y install tzdata

apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git vim wget unzip



curl https://pyenv.run | bash

# Load pyenv automatically by adding
# the following to ~/.bashrc:

echo -e 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc 
echo -e 'eval "$(pyenv init -)"' >> ~/.bashrc 
echo -e 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc 

exec "$SHELL" # Or just restart your terminal

# TODO. Could need a cleanup but works for installing Python 3.7.13 as default Python version
pyenv install --list | grep " 3\.[678]"   # List versions available
pyenv install -v 3.7.13

pyenv versions

eval "$(pyenv virtualenv-init -)"

pyenv global 3.7.13

python -m pip install --upgrade pip


git clone https://github.com/WongKinYiu/yolov7
cd yolov7
python -m pip install -r requirements.txt
python -m pip install opencv-python-headless  # ImportError: libGL.so.1: cannot open shared object file: No such file or directory

#git clone https://github.com/ultralytics/yolov5.git
#cd yolov5/
#python -m pip install -r requirements.txt
#python -m pip install opencv-python-headless  # ImportError: libGL.so.1: cannot open shared object file: No such file or directory


python -m pip install nvidia-tensorrt==8.0.3.4 --index-url https://pypi.ngc.nvidia.com
python -m pip install nvidia-pyindex
python -m pip install onnx




```
