## Build eMMC image for OKdo C100 Jetson Nano
* https://github.com/LetsOKdo/c100-bootupd


### Install dependencies not included in Ubuntu 18.04
```
#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
sudo apt install -y git

sudo apt install -y build-essential
sudo apt install -y bison flex
sudo apt install -y qemu-user-static
sudo apt install -y gcc-aarch64-linux-gnu
```

### GIT configure name and e-mail
```
git config --global user.name "Jack Shitt" && git config --global user.email "jack.shitt@yahoo.com"
```

### Restart

### Clone the OKdo C100 repository
```
git clone --recurse-submodules https://github.com/LetsOKdo/c100-bootupd.git

This will normally fail ....
```

### Download the NVIDIA Jetson Linux R32.7.3 files
```bash
cd ~/c100-bootupd

wget --https-only -nv --show-progress --progress=bar:force:noscroll https://developer.nvidia.com/downloads/remetpack-463r32releasev73t210jetson-210linur3273aarch64tbz2 -O Jetson-210_Linux_R32.7.3_aarch64.tbz2
wget --https-only -nv --show-progress --progress=bar:force:noscroll https://developer.nvidia.com/downloads/remeleasev73t210tegralinusample-root-filesystemr3273aarch64tbz2 -O Tegra_Linux_Sample-Root-Filesystem_R32.7.3_aarch64.tbz2
wget --https-only -nv --show-progress --progress=bar:force:noscroll https://developer.nvidia.com/downloads/remack-sdksjetpack-463r32releasev73sourcest210publicsourcestbz2 -O public_sources.tbz2
```

### Clone the NVIDIA u-boot manually (Really needed ?)
```
cd ~/c100-bootupd
rm -rf u-boot/
git clone git://nv-tegra.nvidia.com/3rdparty/u-boot.git
```

### Copy the NVIDIA files to the c100-bootupd folder
* Driver Package (BSP): Jetson-210_Linux_R32.7.3_aarch64.tbz2
* Sample Root Filesystem: Tegra_Linux_Sample-Root-Filesystem_R32.7.3_aarch64.tbz2
* Driver Package (BSP) Sources: public_sources.tbz2

### Patch the Makefile
Issue with the list of extensions and don't reuse system.img
```Diff
diff --git a/Makefile b/Makefile
index 4092d17..0f37007 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,9 @@ build-signed: replace-u-boot
 # Flash
 #
 Linux_for_Tegra/bootloader/t210ref/p3450-0000/u-boot.bin: $(U-BOOT)
-	cp u-boot/u-boot{,.bin,.dtb,-dtb.bin} Linux_for_Tegra/bootloader/t210ref/p3450-0000
+	cp u-boot/u-boot.bin Linux_for_Tegra/bootloader/t210ref/p3450-0000
+	cp u-boot/u-boot.dtb Linux_for_Tegra/bootloader/t210ref/p3450-0000
+	cp u-boot/u-boot-dtb.bin Linux_for_Tegra/bootloader/t210ref/p3450-0000
 
 .PHONY: replace-u-boot
 replace-u-boot: Linux_for_Tegra/bootloader/t210ref/p3450-0000/u-boot.bin
@@ -86,7 +88,7 @@ replace-u-boot: Linux_for_Tegra/bootloader/t210ref/p3450-0000/u-boot.bin
 .PHONY: flash
 flash: replace-u-boot
 	cd Linux_for_Tegra && \
-	sudo ./flash.sh -r jetson-nano-emmc mmcblk0p1
+	sudo ./flash.sh jetson-nano-emmc mmcblk0p1
```

### Initialize Jetpack
```bash
./init-jetpack
```

### Connect the "FC REC" pin to ground and connect a Micro-USB to the Jetson Devboard
```bash
make flash
```







