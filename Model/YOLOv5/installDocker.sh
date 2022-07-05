#!/bin/bash


#wget https://us.download.nvidia.com/tesla/460.32.03/NVIDIA-Linux-x86_64-460.32.03.run
#wget https://us.download.nvidia.com/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run
#chmod +x NVIDIA-Linux-x86_64-460.106.00.run
#sudo ./NVIDIA-Linux-x86_64-460.106.00.run --no-x-check



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
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

# ####
# NVIDIA Tesla K80 / Works with YOLOv5 ( 2022 July 5th )
# On Ubuntu 20.04
# NVIDIA-SMI 460.106.00   Driver Version: 460.106.00   CUDA Version: 11.2
# sudo docker run --gpus all -it -v /mnt/storage:/storage nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
#

