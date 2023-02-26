## NVIDIA GRID / vGPU


* https://gitlab.com/polloloco/vgpu-proxmox
* https://images.nvidia.com/content/pdf/grid/guides/GRID-vGPU-User-Guide.pdf



#### cat /etc/vgpu_unlock/profile_override.toml
```
[profile.nvidia-65] # choose the profile you want here
num_displays = 1
display_width = 1920
display_height = 1080
max_pixels = 2073600
pci_device_id = 0x1BB1
pci_id = 0x1BB111A3
```


There is a Tesla P4 in the host, emmulating a Quadro P4000
```
  Model:	NVIDIA Quadro P4000
  Device Id:	10DE 1BB1
  Subsystem Id:	10DE 11A3

  pci_device_id = 0x1BB1
  pci_id = 0x1BB111A3

  https://www.techpowerup.com/vgabios/234590/234590
```

There is a Tesla P4 in the host, emmulating a GTX 1070
```
Manufacturer:	NVIDIA
Model:	GTX 1070
Device Id:	10DE 1B81
Subsystem Id:	10DE 119D

pci_device_id = 0x1B81
pci_id = 0x1B81119D
```


https://parsec.app/
https://vb-audio.com/Cable/


Moonlight
ThightVNC


https://www.michaelstinkerings.org/using-vgpu-unlock-with-proxmox-7/

