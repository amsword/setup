FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04

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

ENV TORCH_CUDA_ARCH_LIST=3.5;5.0+PTX;6.0;6.1;7.0;7.5
RUN conda install -y pytorch=1.7 torchvision cudatoolkit=11.1 -c pytorch -c conda-forge

RUN conda install -y \
        python=3.7 \
        libprotobuf \
        boost \
        gflags \
        glog \
        opencv \
        lmdb \
        mkl-include \
        leveldb && \
    pip install --upgrade pip ipython && \
    rm /opt/conda/lib/python3.7/site-packages/ruamel_yaml* -rf && \
    pip install --upgrade -r requirements.txt



RUN cd /app && \
    git clone https://www.github.com/nvidia/apex && \
    cd apex && \
    python setup.py install --cuda_ext --cpp_ext

RUN cd /app && \
    git clone https://github.com/amsword/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install

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
RUN apt install -y openmpi-bin libopenmpi-dev

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
RUN pip install ninja

#ENTRYPOINT service ssh restart && /bin/bash
CMD ["sleep", "infinity"]
