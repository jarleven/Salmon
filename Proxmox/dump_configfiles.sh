#!/bin/bash

# https://gitlab.com/polloloco/vgpu-proxmox
# https://pve.proxmox.com/wiki/NVIDIA_vGPU_on_Proxmox_VE_7.x

FILENAME="pci-passthrough-config.md"

echo "## -- PCI Passthrough settings ---" > $FILENAME
echo "### Hardware, BIOS version and BIOS date" >> $FILENAME
echo "\`\`\`" >> $FILENAME
dmidecode -s system-product-name  >> $FILENAME
dmidecode -s bios-version  >> $FILENAME
dmidecode -s bios-release-date  >> $FILENAME
echo "\`\`\`" >> $FILENAME

echo "" >> $FILENAME
echo "" >> $FILENAME


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
   echo "### cat $i" >> $FILENAME
   echo "\`\`\`" >> $FILENAME
   cat "$i" >> $FILENAME
   echo "\`\`\`" >> $FILENAME

   echo "" >> $FILENAME
   echo "" >> $FILENAME
done

echo "### Installed NVIDIA GPUs" >> $FILENAME
echo "\`\`\`" >> $FILENAME
lspci -n | grep -i 10DE >> $FILENAME
lspci | grep -i NVIDIA  >> $FILENAME
echo "\`\`\`" >> $FILENAME

cat $FILENAME
echo ""