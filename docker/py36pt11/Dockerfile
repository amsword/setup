FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

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

RUN conda install pytorch torchvision cudatoolkit=10.0 -c pytorch

# install nccl for gpu parallel
#RUN git clone https://github.com/NVIDIA/nccl.git && \
        #cd nccl && make src.build && \
        #make pkg.debian.build && \
        #cd .. && rm -rf nccl

RUN cd /app && \
    git clone https://github.com/cocodataset/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install

RUN cd /app && \
    git clone https://www.github.com/nvidia/apex && \
    cd apex && \
    python setup.py install --cuda_ext --cpp_ext

RUN touch /etc/skel/.bashrc

ADD config /app
ADD id_rsa /app
ADD id_rsa.pub /app

RUN mkdir ~/.ssh/ -p && cp /app/id_rsa ~/.ssh/ && \
    cp /app/id_rsa.pub ~/.ssh/ && \
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys && \
    cp /app/config /root/.ssh/

RUN apt-get install -y openssh-server

RUN echo "alias ll='ls -alF'" >> /etc/skel/.bashrc

RUN rm /app/* -rf
RUN rm -rf /var/lib/apt/lists/*

# make this folder accessible
RUN chmod 777 /app

#ENTRYPOINT service ssh restart && /bin/bash
CMD ["sleep", "infinity"]
