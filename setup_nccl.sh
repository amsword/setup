sudo apt install build-essential devscripts debhelper
git clone --branch v2.3.5-5 https://github.com/NVIDIA/nccl.git
cd nccl

make pkg.debian.build -j
cd build/pkg/deb/
# the star will expand the two deb. one is for nccl runtime and the other is
# for dev
sudo dpkg -i *


