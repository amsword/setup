#FROM nvidia/cuda:10.1-cudnn8-devel-ubuntu18.04
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

WORKDIR /app
ADD requirements.txt /app
ADD .tmux.conf /app

ENV STAGE_DIR=/root/gpu/install \
    CUDNN_DIR=/usr/local/cudnn \
    CUDA_DIR=/usr/local/cuda-10.1 \
    OPENMPI_VERSIONBASE=4.0
ENV OPENMPI_VERSION=${OPENMPI_VERSIONBASE}.0
ENV OPENMPI_STRING=openmpi-${OPENMPI_VERSION} \
    OFED_VERSION=4.4-1.0.0.0

ARG DEBIAN_FRONTEND=noninteractive

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
    # No longer in 'minimal set of packages'
      sudo \
    # Needed by OpenMPI
      cmake \
      g++ \
      gcc \
    # ifconfig
      net-tools && \
    apt-get autoremove

WORKDIR $STAGE_DIR

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
        tk8.5 \
        tcl8.5 \
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
    rm -rf /var/lib/apt/lists/* && \
    # libnl1 is not available in ubuntu16 so build from source
    wget -q -O - http://www.infradead.org/~tgr/libnl/files/libnl-1.1.4.tar.gz | tar xzf - && \
    cd libnl-1.1.4 && \
    ./configure && \
    make && \
    checkinstall -D --showinstall=no --install=yes -y -pkgname=libnl1 -A amd64 && \
    cd .. && \
    rm -rf libnl-1.1.4 && \
    wget -q -O - http://www.mellanox.com/downloads/ofed/MLNX_OFED-$OFED_VERSION/MLNX_OFED_LINUX-$OFED_VERSION-ubuntu18.04-x86_64.tgz | tar xzf - && \
    cd MLNX_OFED_LINUX-$OFED_VERSION-ubuntu18.04-x86_64/DEBS && \
    for dep in libibverbs1 libibverbs-dev ibverbs-utils libmlx4-1 libmlx5-1 librdmacm1 librdmacm-dev libibumad libibumad-devel libibmad libibmad-devel; do \
        dpkg -i $dep\_*_amd64.deb; \
    done && \
    cd ../.. && \
    rm -rf MLNX_OFED_LINUX-*

RUN wget -q -O - https://download.open-mpi.org/release/open-mpi/v4.0/${OPENMPI_STRING}.tar.gz | tar -xzf - && \
    cd ${OPENMPI_STRING} && \
    ./configure --prefix=/usr/local/${OPENMPI_STRING} && \
    make -j"$(nproc)" install && \
    rm -rf $STAGE_DIR/${OPENMPI_STRING} && \
    ln -s /usr/local/${OPENMPI_STRING} /usr/local/mpi && \
    # Sanity check:
    test -f /usr/local/mpi/bin/mpic++

# Update environment variables
ENV PATH=/usr/local/mpi/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/mpi/lib:/usr/local/mpi/lib64:$LD_LIBRARY_PATH

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

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O anaconda.sh && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

ENV PATH="/opt/conda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/conda/lib:${LD_LIBRARY_PATH}"

# always have these for locale to set properly
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

RUN conda install -y python=3.7

ENV TORCH_CUDA_ARCH_LIST=3.5;5.0+PTX;6.0;6.1;7.0;7.5
RUN conda install -y pytorch==1.7.1 torchvision==0.8.2 cudatoolkit=10.1 -c pytorch


#RUN conda install -y \
        #libprotobuf \
        #boost \
        #gflags \
        #glog \
        #opencv \
        #lmdb \
        #mkl-include \
        #leveldb && \
    #pip install --upgrade pip ipython && \
    #rm /opt/conda/lib/python3.7/site-packages/ruamel_yaml* -rf && \
    #pip install --upgrade -r requirements.txt


#RUN cd /app && \
    #git clone https://www.github.com/nvidia/apex && \
    #cd apex && \
    #pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" .
RUN conda install -c conda-forge nvidia-apex

RUN touch /etc/skel/.bashrc

#RUN apt-get install -y openssh-server

RUN echo "alias ll='ls -alF'" >> /etc/skel/.bashrc


# higher version of mpi is requried by horovod
#RUN mkdir /tmp/openmpi && \
    #cd /tmp/openmpi && \
    #wget https://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-4.0.0.tar.gz && \
    #tar zxf openmpi-4.0.0.tar.gz && \
    #cd openmpi-4.0.0 && \
    #./configure --enable-orterun-prefix-by-default && \
    #make -j $(nproc) all && \
    #make install && \
    #ldconfig && \
    #rm -rf /tmp/openmpi
#RUN apt install -y openmpi-bin libopenmpi-dev

# install horovod
#RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \
    #HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_PYTORCH=1 pip install --no-cache-dir horovod && \
    #ldconfig
#RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \
    #HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_PYTORCH=1 python -m pip install --no-cache-dir \
    #git+https://github.com/horovod/horovod.git@910333f428e91c4cdca634864398f0952067f2a8 && \
    #ldconfig
#RUN HOROVOD_GPU_ALLREDUCE=NCCL \
    #HOROVOD_GPU_BROADCAST=NCCL \
    #pip install --no-cache-dir horovod==0.19.1

RUN apt-get install -y apt-utils
RUN apt-get install -y ca-certificates

RUN apt-get install -y infiniband-diags

# install java, used by evaluation for caption
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -y install default-jre-headless

RUN apt-get install -y iperf

RUN cd /app && \
    wget https://azcopyvnext.azureedge.net/release20210415/azcopy_linux_amd64_10.10.0.tar.gz -O a.tar.gz && \
    tar xvzf a.tar.gz && \
    cp azcopy_linux_amd64_10.10.0/azcopy /usr/bin/ && \
    chmod +x /usr/bin/azcopy && \
    rm -rf a.tar.gz azcopy_linux_amd64_10.10.0

RUN pip install ninja cython pyyaml
RUN cd /app && \
    git clone --recursive https://github.com/amsword/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install


#RUN rm /app/* -rf
RUN rm -rf /var/lib/apt/lists/*

# make this folder accessible
RUN chmod 777 /app
RUN echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config
#RUN chmod 777 ~/.ssh
#RUN echo "root:Docker!" | chpasswd

#ENTRYPOINT service ssh restart && /bin/bash
CMD ["sleep", "infinity"]
