FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

WORKDIR /app
ADD requirements.txt /app/
ENV PYTHON_VERSION=3.6
ENV NCCL_VERSION=2.4.7-1+cuda10.0

RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    vim \
    wget \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    infiniband-diags \
    libibverbs-dev \
    libnccl2=${NCCL_VERSION} \
    libnccl-dev=${NCCL_VERSION}

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O anaconda.sh && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

ENV PATH="/opt/conda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/conda/lib:${LD_LIBRARY_PATH}"

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
    pip install --upgrade -r /app/requirements.txt

RUN python -m pip install --upgrade pip

RUN python -m pip install \
    wheel \
    https://download.pytorch.org/whl/cu100/torch-1.1.0-cp36-cp36m-linux_x86_64.whl \
    https://download.pytorch.org/whl/cu100/torchvision-0.3.0-cp36-cp36m-linux_x86_64.whl \
    numpy \
    lmdb \
    Pillow \
    azureml-sdk \
    protobuf \
    tensorboardX \
    PyYAML

RUN cd /app && \
    git clone https://github.com/cocodataset/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install

RUN cd /app && \
    git clone https://www.github.com/nvidia/apex && \
    cd apex && \
    python setup.py install --cuda_ext --cpp_ext

# Install Open MPI
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

# Install horovod post-0.16.2 which has an important fix
RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \
    HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_PYTORCH=1 python -m pip install --no-cache-dir \
    git+https://github.com/horovod/horovod.git@910333f428e91c4cdca634864398f0952067f2a8 && \
    ldconfig

# Install OpenSSH for MPI to communicate between containers
RUN apt-get install -y --no-install-recommends openssh-client openssh-server && \
    mkdir -p /var/run/sshd

# Allow OpenSSH to talk to containers without asking for confirmation
RUN cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config

RUN apt-get install -y libsm6 libxext6 libxrender-dev

CMD ["sleep", "infinity"]
