apt update
DEBIAN_FRONTEND=noninteractive TZ=Europe/Oslo apt-get -y install tzdata
apt install -y build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev

git config --global http.sslverify false
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers
make install
cd -

git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg/
cd ffmpeg
#./configure --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --enable-static --disable-shared
./configure --enable-cuda-nvcc --enable-cuvid --enable-nvenc --enable-nvdec --enable-nonfree --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --enable-static --disable-shared

make -j 8
make install
cd -
