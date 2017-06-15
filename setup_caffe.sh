set -e
sudo apt-get update
sudo apt-get install -y \
    git \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libboost-all-dev \
    libhdf5-serial-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev \
    protobuf-compiler \
    python-numpy \
    python-scipy \
    python-matplotlib \
    python-sklearn \
    python-skimage \
    python-h5py \
    python-protobuf \
    python-leveldb \
    python-networkx \
    python-nose \
    python-pandas \
    python-gflags \
    ipython \
    libhdf5-serial-dev \
    cmake \
    libatlas-base-dev \
    python-pip \
    rake \
    gdb \
    bc \
    libclang-dev

sudo pip install pygments
sudo pip install django
sudo pip install Cython

