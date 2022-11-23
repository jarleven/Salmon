#!/bin/bash


sudo apt install -y linux-headers-$(uname -r)
sudo apt install -y build-essential libglvnd-dev pkg-config
wget https://us.download.nvidia.com/tesla/470.161.03/NVIDIA-Linux-x86_64-470.161.03.run

https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux


#wget https://us.download.nvidia.com/tesla/460.32.03/NVIDIA-Linux-x86_64-460.32.03.run
#wget https://us.download.nvidia.com/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run
#chmod +x NVIDIA-Linux-x86_64-460.106.00.run
#sudo ./NVIDIA-Linux-x86_64-460.106.00.run --no-x-check


## 23.11.2022 
## NVIDIA DRIVER HP DL380 Gen 9  / K80
#  Ubuntu 18.04
# 
sudo add-apt-repository -y ppa:graphics-drivers/ppa
ubuntu-drivers devices
sudo apt install nvidia-driver-470


sudo apt update
sudo apt upgrade -y
sudo apt install -y curl vim git screen sshfs
sudo apt install -y build-essential

sudo mkdir /mnt/storage
sudo sshfs -o allow_other jarleven@192.168.1.199:/RAID/storage/2022/ /mnt/storage

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
sudo docker run --rm --gpus all nvidia/cuda:11.0.3-base nvidia-smi

# ####
# NVIDIA Tesla K80 / Works with YOLOv5 ( 2022 July 5th )
# On Ubuntu 20.04.4 LTS \n \l
# NVIDIA-SMI 470.129.06   Driver Version: 470.129.06   CUDA Version: 11.4
# sudo docker run --gpus all -it -v /mnt/storage:/storage nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
#


# ####
# NVIDIA Tesla K80 / Works with YOLOv5 ( 2022 July 5th )
# On Ubuntu 20.04.4 LTS \n \l
# NVIDIA-SMI 470.129.06   Driver Version: 470.129.06   CUDA Version: 11.4
# sudo docker run --gpus all -it -v /mnt/storage:/storage nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
#




# ####
# ubuntu-drivers devices
# WARNING:root:_pkg_get_support nvidia-driver-390: package has invalid Support Legacyheader, cannot determine support level
# == /sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0 ==
# modalias : pci:v000010DEd0000102Dsv000010DEsd0000106Cbc03sc02i00
# vendor   : NVIDIA Corporation
# model    : GK210GL [Tesla K80]
# driver   : nvidia-driver-470 - distro non-free recommended
# driver   : nvidia-driver-390 - distro non-free
# driver   : nvidia-driver-450-server - distro non-free
# driver   : nvidia-driver-418-server - distro non-free
# driver   : nvidia-driver-470-server - distro non-free
# driver   : xserver-xorg-video-nouveau - distro free builtin
