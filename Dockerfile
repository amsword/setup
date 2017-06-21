FROM bvlc/caffe:gpu

WORKDIR /app
ADD requirements.txt /app
ADD .tmux.conf /app
ADD .vimrc_plugin /app
RUN apt-get update && apt-get install -y \
        bc \
        build-essential \
        cmake \
        gdb \
        git \
        ipython \
        libboost-all-dev \
        libleveldb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        libhdf5-serial-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        liblmdb-dev \
        libclang-dev \
        libncurses5-dev \
        libgnome2-dev \
        libgnomeui-dev \
        libgtk2.0-dev \
        libbonoboui2-dev \
        libcairo2-dev \
        libx11-dev \
        libxpm-dev \
        libxt-dev \
        lsb-release \
        lua5.1 \
        lua5.1-dev \
        libperl-dev \
        python-dev \
        python-pip \
        protobuf-compiler \
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
        python3-dev \
        ipython \
        libhdf5-serial-dev \
        cmake \
        libatlas-base-dev \
        rake \
        ruby-dev \
        silversearcher-ag \
        software-properties-common \
        tmux

RUN pip install -r requirements.txt

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y gcc-5 g++-5 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 \
        60 --slave /usr/bin/g++ g++ /usr/bin/g++-5

# remove the older vim and we will install a newer one
RUN apt-get remove -y vim vim-runtime gvim

# install the latest vim to support the YCM
RUN git clone https://github.com/vim/vim.git && \
    cd vim/src && \
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp \
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
                --enable-python3interp \
                --enable-perlinterp \
                --enable-luainterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim80 && \
    make install && \
    update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1 && \
    update-alternatives --set editor /usr/bin/vim && \
    update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1 && \
    update-alternatives --set vi /usr/bin/vim && \

RUN cp /app/.tmux.conf ~/

RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

RUN cp /app/.vimrc_plugin $HOME/.vimrc && \
    vim +PluginInstall +qall

RUN rm /app/* -rf
CMD ["sleep", "infinity"]
