## -- PCI Passthrough settings ---
### Hardware, BIOS version and BIOS date
```
ProLiant DL380 Gen9
P89
10/16/2020
```


### cat /etc/default/grub
```
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
GRUB_TIMEOUT=5
#GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
#GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM="0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=console

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command `vbeinfo'
#GRUB_GFXMODE=640x480

# Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to Linux
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY="true"

# Uncomment to get a beep at grub start
#GRUB_INIT_TUNE="480 440 1"
```


### cat /etc/modules
```
# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.

vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
vendor-reset
```


### cat /etc/modprobe.d/blacklist.conf
```
blacklist radeon
blacklist nouveau
blacklist nvidia
blacklist snd_hda_intel

```


### cat /etc/vgpu_unlock/profile_override.toml
```
[profile.nvidia-65] # choose the profile you want here
num_displays = 1
display_width = 1920
display_height = 1080
max_pixels = 2073600

# Quadro P4000
pci_device_id = 0x1BB1
pci_id = 0x1BB111A3

```


### cat /etc/systemd/system/nvidia-sriov.service
```
[Unit]
Description=Enable NVIDIA SR-IOV
After=network.target nvidia-vgpud.service nvidia-vgpu-mgr.service
Before=pve-guests.service

[Service]
Type=oneshot
ExecStart=/usr/lib/nvidia/sriov-manage -e ALL

[Install]
WantedBy=multi-user.target

```


### cat /etc/modprobe.d/vfio.conf
```
# For vGPU this is different compared to PCI-Passthrough
#options vfio-pci ids=10de:1bb3

```


### Installed NVIDIA GPUs
```
88:00.0 0302: 10de:1bb3 (rev a1)
88:00.0 3D controller: NVIDIA Corporation GP104GL [Tesla P4] (rev a1)
```
