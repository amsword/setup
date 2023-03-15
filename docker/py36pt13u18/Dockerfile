FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

WORKDIR /app
ADD requirements.txt /app
ADD .tmux.conf /app

RUN apt-get update && apt-get install -y \
        bc \
        build-essential \
        cmake \
        curl \
        devscripts \
        gdb \
        git \
        gfortran \
        gvfs-bin \
        libboost-all-dev \
        libleveldb-dev \
        libnotify4 \
        libopenblas-dev \
        libclang-dev \
        libncurses5-dev \
        libbonoboui2-dev \
        libcairo2-dev \
        libgnome2-dev \
        libgnomeui-dev \
        libgtk2.0-dev \
        libx11-dev \
        libxpm-dev \
        libxt-dev \
        less \
        lsb-release \
        libperl-dev \
        libhdf5-serial-dev \
        cmake \
        libatlas-base-dev \
        rake \
        ruby-dev \
        silversearcher-ag \
        software-properties-common \
        wget \
        tmux

ENV STAGE_DIR=/root/gpu/install \
    CUDNN_DIR=/usr/local/cudnn \
    CUDA_DIR=/usr/local/cuda-10.0
ENV OFED_VERSION=4.2-1.2.0.0

RUN mkdir -p $STAGE_DIR
RUN apt-get -y update && \
    apt-get -y install \
      build-essential \
      autotools-dev \
      rsync \
      curl \
      wget \
      jq \
      openssh-server \
      openssh-client \
      sudo \
    # Needed by OpenMPI
      cmake \
      g++ \
      gcc \
    # ifconfig
      net-tools && \
    apt-get autoremove

# Install Mellanox OFED user-mode drivers and its prereqs
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    # For MLNX OFED
        dnsutils \
        pciutils \
        ethtool \
        lsof \
        python-libxml2 \
        quilt \
        libltdl-dev \
        dpatch \
        autotools-dev \
        graphviz \
        autoconf \
        chrpath \
        swig \
        automake \
        libgfortran3 \
        tcl \
        libnl-3-200 \
        libnl-route-3-200 \
        libnl-route-3-dev \
        libnl-utils \
        gfortran \
        tk \
        bison \
        flex \
        libnuma1 \
        checkinstall && \
    apt-get -y autoremove && \
    # libnl1 is not available in ubuntu16 so build from source
    wget -q -O - http://www.infradead.org/~tgr/libnl/files/libnl-1.1.4.tar.gz | tar xzf - && \
    cd libnl-1.1.4 && \
    ./configure && \
    make && \
    checkinstall -D --showinstall=no --install=yes -y -pkgname=libnl1 -A amd64 && \
    cd .. && \
    rm -rf libnl-1.1.4 && \
    wget -q -O - http://www.mellanox.com/downloads/ofed/MLNX_OFED-$OFED_VERSION/MLNX_OFED_LINUX-$OFED_VERSION-ubuntu16.04-x86_64.tgz | tar xzf - && \
    cd MLNX_OFED_LINUX-$OFED_VERSION-ubuntu16.04-x86_64/DEBS && \
    for dep in libibverbs1 libibverbs-dev ibverbs-utils libmlx4-1 libmlx5-1 librdmacm1 librdmacm-dev libibumad libibumad-devel libibmad libibmad-devel; do \
        dpkg -i $dep\_*_amd64.deb; \
    done && \
    cd ../.. && \
    rm -rf MLNX_OFED_LINUX-*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O anaconda.sh && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

ENV PATH="/opt/conda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/conda/lib:${LD_LIBRARY_PATH}"

RUN conda install -y python=3.6

RUN conda install -y \
        python=3.6 \
        libprotobuf \
        boost \
        gflags \
        glog \
        opencv \
        lmdb \
        mkl-include \
        leveldb && \
    pip install --upgrade pip ipython && \
    pip install --upgrade -r requirements.txt

ENV TORCH_CUDA_ARCH_LIST=3.5;5.0+PTX;6.0;6.1;7.0;7.5
RUN conda install -y pytorch=1.3 torchvision cudatoolkit=10.1 -c pytorch


RUN cd /app && \
        git clone https://github.com/pytorch/vision.git && \
        cd vision && \
        FORCE_CUDA=1 python setup.py install

# install nccl for gpu parallel
#RUN git clone https://github.com/NVIDIA/nccl.git && \
        #cd nccl && make src.build && \
        #make pkg.debian.build && \
        #cd .. && rm -rf nccl


RUN cd /app && \
    git clone https://github.com/amsword/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install

RUN cd /app && \
    git clone https://www.github.com/nvidia/apex && \
    cd apex && \
    python setup.py install --cuda_ext --cpp_ext

RUN touch /etc/skel/.bashrc

ADD id_rsa /app
ADD id_rsa.pub /app

#RUN mkdir ~/.ssh/ -p && \
    #cp /app/config /root/.ssh/
#RUN mkdir ~/.ssh/ -p && cp /app/id_rsa ~/.ssh/ && \
    #cp /app/id_rsa.pub ~/.ssh/ && \
    #cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys && \
    #cp /app/config /root/.ssh/

#RUN apt-get install -y openssh-server

RUN echo "alias ll='ls -alF'" >> /etc/skel/.bashrc


# higher version of mpi is requried by horovod
RUN mkdir /tmp/openmpi && \
    cd /tmp/openmpi && \
    wget https://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-4.0.0.tar.gz && \
    tar zxf openmpi-4.0.0.tar.gz && \
    cd openmpi-4.0.0 && \
    ./configure --enable-orterun-prefix-by-default && \
    make -j $(nproc) all && \
    make install && \
    ldconfig && \
    rm -rf /tmp/openmpi

# install horovod
#RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \
    #HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_PYTORCH=1 pip install --no-cache-dir horovod && \
    #ldconfig
RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \
    HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_PYTORCH=1 python -m pip install --no-cache-dir \
    git+https://github.com/horovod/horovod.git@910333f428e91c4cdca634864398f0952067f2a8 && \
    ldconfig

#RUN apt-get update && apt-get install -y \
        #infiniband-diags

#RUN apt-get install iperf

RUN cd /app && \
    wget https://azcopyvnext.azureedge.net/release20190703/azcopy_linux_amd64_10.2.1.tar.gz -O a.tar.gz && \
    tar xvzf a.tar.gz && \
    cp azcopy_linux_amd64_10.2.1/azcopy /usr/bin/ && \
    rm -rf a.tar.gz azcopy_linux_amd64_10.2.1

#RUN rm /app/* -rf
RUN rm -rf /var/lib/apt/lists/*

# make this folder accessible
RUN chmod 777 /app
RUN echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config
#RUN chmod 777 ~/.ssh
RUN echo "root:Docker!" | chpasswd

#ENTRYPOINT service ssh restart && /bin/bash
CMD ["sleep", "infinity"]
