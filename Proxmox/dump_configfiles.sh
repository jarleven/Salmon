#!/bin/bash

# https://gitlab.com/polloloco/vgpu-proxmox
# https://pve.proxmox.com/wiki/NVIDIA_vGPU_on_Proxmox_VE_7.x

## declare an array variable
declare -a arr=("/etc/default/grub"
                "/etc/modprobe.d/vfio.conf"
                "/etc/modules"
                "/etc/modprobe.d/blacklist.conf"
                "/etc/vgpu_unlock/profile_override.toml"
                )

## now loop through the above array
for i in "${arr[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
done
