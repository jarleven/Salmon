
### Install dependencies
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

git config username and e-mail

### Restart

### Clone the OKdo C100 repository
```
git clone --recurse-submodules https://github.com/LetsOKdo/c100-bootupd.git

This will normally fail ....
```

### Clone the NVIDIA u-boot manually
```
cd ~/c100-bootupd
rm -rf u-boot/
git clone git://nv-tegra.nvidia.com/3rdparty/u-boot.git
```

### Copy the NVIDIA files to the c100-bootupd folder
* Driver Package (BSP): Jetson-210_Linux_R32.7.3_aarch64.tbz2
* Sample Root Filesystem: Tegra_Linux_Sample-Root-Filesystem_R32.7.3_aarch64.tbz2
* Driver Package (BSP) Sources: public_sources.tbz2

### Initialize Jetpack
```bash
./init-jetpack
```

### Connect the "FC REC" pin to ground and connect a Micro-USB to the Jetson Devboard
```bash
make flash
```




### Patch the Makefile
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


