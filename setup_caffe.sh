
apt-get install -y git
apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev
apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler
apt-get install -y python-numpy python-scipy python-matplotlib python-sklearn python-skimage python-h5py python-protobuf python-leveldb python-networkx python-nose python-pandas python-gflags Cython ipython
apt-get install -y cmake
apt-get install -y libatlas-base-dev
apt-get install -y python-pip
apt-get install -y rake
apt-get install -y gdb
apt-get install -y libclang-dev

pip install pygments
pip install django

apt-get install -y wget
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.0-28_amd64.deb -O cuda-repo.deb
dpkg -i cuda-repo.deb
rm cuda-repo.deb

apt-get update
apt-get install -y cuda-toolkit-6-5

sudo apt-get install -y dkms

# install cuda driver
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/346.89/NVIDIA-Linux-x86_64-346.89.run -O driver.run
chmod +x driver.run
sudo ./driver.run -s -N --dkms
rm -f driver.run

#
