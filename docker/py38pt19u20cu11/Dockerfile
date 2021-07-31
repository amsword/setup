FROM nvcr.io/nvidia/pytorch:21.06-py3

ENV LD_LIBRARY_PATH=/opt/hpcx/nccl_rdma_sharp_plugin/lib:$LD_LIBRARY_PATH
ENV NCCL_ASYNC_ERROR_HANDLING=1
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /app && cd /app && \
    wget https://azcopyvnext.azureedge.net/release20210415/azcopy_linux_amd64_10.10.0.tar.gz -O a.tar.gz && \
    tar xvzf a.tar.gz && \
    cp azcopy_linux_amd64_10.10.0/azcopy /usr/bin/ && \
    chmod +x /usr/bin/azcopy && \
    rm -rf a.tar.gz azcopy_linux_amd64_10.10.0

RUN cd /app && \
    git clone --recursive https://github.com/amsword/cocoapi && \
    cd cocoapi/PythonAPI && \
    make install

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6 zip -y

RUN rm -rf /var/lib/apt/lists/*
