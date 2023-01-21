## Proxmox... trials and tribulations



#### Restart the pvedaemon (webservice ++)
```bash

systemctl restart pveproxy.service pvedaemon.service
```
### Network configuration
```bash
cat /etc/hosts

127.0.0.1 localhost.localdomain localhost
192.168.100.2 hostname.gruppe1.com hostname

# The following lines are desirable for IPv6 capable hosts

::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
```


```bash
cat /etc/network/interfaces

auto lo
iface lo inet loopback

iface eno1 inet manual

auto vmbr0
iface vmbr0 inet static
        address 192.168.1.211/24
        gateway 192.168.1.1
        bridge-ports eno1
        bridge-stp off
        bridge-fd 0

iface eno2 inet manual

iface eno3 inet manual

iface eno4 inet manual
```

### Grub (HP Proliant DL380 Gen9)

#### update-grub
```bash
cat /etc/default/grub

# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
GRUB_TIMEOUT=5
#GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on vfio_iommu_type1.allow_unsafe_interrupts=1"
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

### PCI passthrough DL-380 Gen9 with NVIDIA Tesla K80

```bash
lspci | grep -i nvidia
lscpi -n

# The -n options shows the numeric ID's for the PCI device
```


```bash
cat /etc/modprobe.d/vfio.conf

options vfio-pci ids=10de:102d disable_vga=1
```

### PCI passthrough DL-360p Gen8 with NVIDIA Tesla P4
```bash
cat /etc/modprobe.d/vfio.conf

options vfio-pci ids=10de:1bb3 disable_vga=1
```

```bash
cat /etc/modules

vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
vendor-reset
```

```bash
cat /etc/modprobe.d/blacklist.conf

blacklist radeon
blacklist nouveau
blacklist nvidia
blacklist snd_hda_intel
```


```bash
lspci | grep NVIDIA

86:00.0 3D controller: NVIDIA Corporation GK210GL [Tesla K80] (rev a1)
87:00.0 3D controller: NVIDIA Corporation GK210GL [Tesla K80] (rev a1)
```

### SPICE
```bash

Virt viewer

Windows client
https://virt-manager.org/download/

sudo apt install -y virt-viewer

```



### Guest config files (Created in GUI - modified on the commandline)
```bash
cat /etc/pve/qemu-server/107.conf

agent: 1
args: -machine max-ram-below-4g=1G,kernel_irqchip=on
balloon: 0
bios: ovmf
boot: order=scsi0;ide2;net0
cores: 4
efidisk0: VMRAID:vm-107-disk-0,efitype=4m,pre-enrolled-keys=1,size=4M
hostpci0: 0000:86:00,pcie=1
ide2: local:iso/ubuntu-18.04.6-live-server-amd64.iso,media=cdrom,size=969M
machine: pc-q35-5.2
memory: 16192
meta: creation-qemu=6.2.0,ctime=1669200580
name: K80
net0: virtio=7E:09:B4:30:3A:19,bridge=vmbr0,firewall=1
numa: 0
ostype: l26
scsi0: VMRAID:vm-107-disk-1,size=120G,ssd=1
scsihw: virtio-scsi-pci
smbios1: uuid=2df19427-871d-4453-92cc-602ce49dd383
sockets: 2
vmgenid: a23bfba1-22e4-4830-a14f-c1feee5a0dd8
```


```bash
cat /etc/pve/qemu-server/108.conf

agent: 1
args: -machine max-ram-below-4g=1G,kernel_irqchip=on
balloon: 0
bios: ovmf
boot: order=scsi0;ide2;net0
cores: 3
hostpci0: 0000:87:00.0,pcie=1
ide2: local:iso/ubuntu-22.04.1-live-server-amd64.iso,media=cdrom,size=1440306K
machine: pc-q35-5.2
memory: 16000
meta: creation-qemu=6.2.0,ctime=1669545525
name: k80-i2
net0: virtio=7E:53:78:8E:96:37,bridge=vmbr0,firewall=1
numa: 0
ostype: l26
scsi0: VMRAID:vm-108-disk-0,size=100G,ssd=1
scsihw: virtio-scsi-pci
smbios1: uuid=207f730b-9438-4754-8136-b49027e69d93
sockets: 2
vmgenid: 2f4856f4-1028-4d05-bf59-6f839277e895
```

```bash
cat /etc/pve/qemu-server/102.conf

agent: 1
balloon: 0
bios: ovmf
boot: order=sata0;ide2;net0
cores: 4
efidisk0: local-lvm:vm-102-disk-0,efitype=4m,pre-enrolled-keys=1,size=4M
hostpci0: 0000:07:00,pcie=1,x-vga=1
ide2: local:iso/virtio-win-0.1.229.iso,media=cdrom,size=522284K
machine: pc-q35-7.1
memory: 32000
meta: creation-qemu=7.1.0,ctime=1673954583
name: GPUWin
net0: virtio=02:E7:FC:90:CF:DE,bridge=vmbr0,firewall=1
numa: 0
ostype: win11
sata0: local-lvm:vm-102-disk-1,size=100G,ssd=1
scsihw: virtio-scsi-single
smbios1: uuid=0d8d4b9c-7b49-41bb-b6a4-c277eb8e0fa9
sockets: 2
tpmstate0: local-lvm:vm-102-disk-2,size=4M,version=v2.0
vga: virtio
vmgenid: 5b7bedb9-2cf9-4f30-bed2-feb23fb52e01
```



### Craft Computing vGPU / PCI Passthrough
```
Use ANY Headless GPU for Gaming in a Virtual Machine! : https://youtu.be/-34tu7uXCI8

Proxmox GPU Virtualization Tutorial with Custom Profiles thanks to vGPU_Unlock-RS : https://www.youtube.com/watch?v=jTXPMcBqoi8

https://www.michaelstinkerings.org/using-vgpu-unlock-with-proxmox-7/


https://gitlab.com/polloloco/vgpu-proxmox

```
