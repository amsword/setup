FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

WORKDIR /app
ADD requirements.txt /app
ADD .tmux.conf /app

ARG DEBIAN_FRONTEND=noninteractive

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

RUN wget -q -O /etc/apt/sources.list.d/mellanox_mlnx_ofed.list https://linux.mellanox.com/public/repo/mlnx_ofed/5.0-1.0.0.0/ubuntu18.04/mellanox_mlnx_ofed.list && \
        wget -qO - http://www.mellanox.com/downloads/ofed/RPM-GPG-KEY-Mellanox | apt-key add - && \
        apt -y update && \
        apt -y install mlnx-ofed-all

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

ENV TORCH_CUDA_ARCH_LIST=3.5;5.0+PTX;6.0;6.1;7.0;7.5;8.0
RUN conda install -y pytorch==1.7.1 torchvision==0.8.2 cudatoolkit=11.0 -c pytorch

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


RUN cd /app && \
    git clone https://www.github.com/nvidia/apex && \
    cd apex && \
    pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" .

RUN touch /etc/skel/.bashrc

#RUN apt-get install -y openssh-server

RUN echo "alias ll='ls -alF'" >> /etc/skel/.bashrc


# Build ucx suite
# note: openmpi will not select ucx without multithreading enabled
ENV ITP_UCX_VERSION=1.10.0
ENV ITP_UCX_TARNAME=ucx-$ITP_UCX_VERSION
ENV ITP_UCX_URL=https://github.com/openucx/ucx/releases/download/v${ITP_UCX_VERSION}/${ITP_UCX_TARNAME}.tar.gz
RUN cd /app && curl -fSsL ${ITP_UCX_URL} | tar xzf - &&\
    cd ${ITP_UCX_TARNAME} &&\
    ./configure \
        --prefix=/usr/local/ucx \
        --with-cuda=/usr/local/cuda \
        --with-verbs=/usr/lib/x86_64-linux-gnu \
        --enable-mt &&\
    make -j"$(nproc)" &&\
    make install

# Build openmpi (use --prefix /opt/openmpi-xxx to move to runtime image)
# note: require --enable-orterun-prefix-by-default for Azure machine learning compute
# note: disable verbs as we use ucx middleware and don't want btl openib warnings
ENV ITP_OPENMPI_VERSION=4.0.4
ENV ITP_OPENMPI_PATH=/opt/openmpi-${ITP_OPENMPI_VERSION}
ENV ITP_OPENMPI_TARNAME=openmpi-${ITP_OPENMPI_VERSION}
ENV ITP_OPENMPI_URL=https://download.open-mpi.org/release/open-mpi/v%OMPI_BASE%/${ITP_OPENMPI_TARNAME}.tar.gz
RUN export OMPI_BASE=${ITP_OPENMPI_VERSION%.*} &&\
    cd /app && curl -fSsL `echo ${ITP_OPENMPI_URL} | sed s/%OMPI_BASE%/$OMPI_BASE/` | tar xzf - &&\
    cd ${ITP_OPENMPI_TARNAME} &&\
    ./configure \
        --prefix=${ITP_OPENMPI_PATH} \
        --with-ucx=/usr/local/ucx \
        --without-verbs \
        --with-cuda=/usr/local/cuda \
        --enable-mpirun-prefix-by-default \
        --enable-orterun-prefix-by-default \
        --enable-mca-no-build=btl-uct &&\
    make -j"$(nproc)" install &&\
    ldconfig
ENV PATH=${ITP_OPENMPI_PATH}/bin:$PATH
ENV LD_LIBRARY_PATH=${ITP_OPENMPI_PATH}/lib:$LD_LIBRARY_PATH

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

RUN apt-get update --fix-missing
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
