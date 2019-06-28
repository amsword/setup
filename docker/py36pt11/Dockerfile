FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu16.04

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

# fix the issue: https://github.com/phusion/baseimage-docker/issues/319
RUN apt-get install -y --no-install-recommends apt-utils

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O anaconda.sh && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

ENV PATH="/opt/conda/bin:${PATH}"

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
    pip install --upgrade pip ipython

# though we donot instlal yaml, we have to remove it here
#RUN apt-get remove -y python-yaml python-scipy
RUN pip install --upgrade -r requirements.txt

# config the tmux for all users by default
RUN cp /app/.tmux.conf /etc/skel/

RUN python -c "import nltk; nltk.download('wordnet', '/usr/local/share')"

# install nccl for gpu parallel
RUN git clone https://github.com/NVIDIA/nccl.git && \
        cd nccl && make src.build && \
        make pkg.debian.build && \
        cd .. && rm -rf nccl

RUN pip install torch=1.1
RUN pip install torchvision

RUN cd /app && \
    git clone https://github.com/cocodataset/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install

RUN cd /app && \
    git clone https://www.github.com/nvidia/apex && \
    cd apex && \
    python setup.py install --cuda_ext --cpp_ext

RUN touch /etc/skel/.bashrc
RUN echo "alias ll='ls -alF'" >> /etc/skel/.bashrc

RUN rm /app/* -rf
RUN rm /root/* -rf

# make this folder accessible
RUN chmod 777 /app

CMD ["sleep", "infinity"]
