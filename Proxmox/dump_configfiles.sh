#!/bin/bash

# https://gitlab.com/polloloco/vgpu-proxmox
# https://pve.proxmox.com/wiki/NVIDIA_vGPU_on_Proxmox_VE_7.x

touch pci-passthrough-config.txt

## declare an array variable
declare -a arr=("/etc/default/grub"
                "/etc/modules"
                "/etc/modprobe.d/blacklist.conf"
                "/etc/vgpu_unlock/profile_override.toml"
                "/etc/systemd/system/nvidia-sriov.service"
                "/etc/modprobe.d/vfio.conf"
                )

## now loop through the above array
for i in "${arr[@]}"
do
   echo "### cat $i" >> pci-passthrough-config.txt
   cat "$i" >> pci-passthrough-config.txt
   # or do whatever with individual element of the array
   echo "" >> pci-passthrough-config.txt
   echo "" >> pci-passthrough-config.txt
   echo "" >> pci-passthrough-config.txt
done

echo "Installed NVIDIA GPUs" >> pci-passthrough-config.txt
lspci -n | grep -i 10DE >> pci-passthrough-config.txt
lspci | grep -i NVIDIA  >> pci-passthrough-config.txt

cat pci-passthrough-config.txt
