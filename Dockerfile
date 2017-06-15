FROM nvidia/caffe


RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt-get install -y \
    bc \
    build-essential \
    cmake \
    gcc-5 \
    gdb \
    git \
    g++-5 \
    ipython \
    libatlas-base-dev \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libboost-all-dev \
    libhdf5-serial-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev \
    libhdf5-serial-dev \
    libclang-dev \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libperl-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    lua5.1 \
    lua5.1-dev \
    lsb-release \
    protobuf-compiler \
    python-dev \
    python3-dev \
    python-pip \
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
    python-software-properties \
    rake \
    ruby-dev \
    silversearcher-ag \
    software-properties-common \
    tmux

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 \
        60 --slave /usr/bin/g++ g++ /usr/bin/g++-5

RUN pip install \
        pyyaml \
        lmdb \
        pygments \
        django \
        Cython \

RUN locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 
RUN dpkg-reconfigure locales

# setup the git
RUN git config --global user.email "jianfengwang@outlook.com" && \
        git config --global user.name "Jianfeng Wang"

# setup the ipython configuration 
RUN ipython profile create 
RUN mkdir -p ~/.config/ipython/profile_default/
RUN echo "c.InteractiveShell.autoindent = False" >> ~/.config/ipython/profile_default/ipython_config.py

