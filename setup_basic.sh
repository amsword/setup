set -e
sudo apt-get update
sudo apt-get install -y \
    ipython \
    build-essential \
    clang \
    git \
    ipython \
    lsb-release \
    python-dev \
    python-pip \
    python-software-properties \
    python-opencv \
    rake \
    ruby-dev \
    silversearcher-ag \
    software-properties-common \
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
    python-opencv \
    ipython \
    libhdf5-serial-dev \
    cmake \
    libatlas-base-dev \
    python-pip \
    rake \
    gdb \
    bc \
    libclang-dev \
    tmux


sudo locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 
sudo dpkg-reconfigure locales

cp .tmux.conf ~/

sudo pip install -r requirements.txt

ipython profile create 
mkdir -p ~/.config/ipython/profile_default/
echo "c.InteractiveShell.autoindent = False" >> ~/.config/ipython/profile_default/ipython_config.py
