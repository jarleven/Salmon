#!/bin/bash

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
