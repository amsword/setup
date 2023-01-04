FROM singularitybase.azurecr.io/base/job/pytorch/ptca-rocm5.2.3_ubuntu20.04_py3.8_pytorch_1.12.1:20220916T084510070

ENV NCCL_ASYNC_ERROR_HANDLING=0
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /app && cd /app && \
    wget https://azcopyvnext.azureedge.net/release20220511/azcopy_linux_amd64_10.15.0.tar.gz -O a.tar.gz && \
    tar xvzf a.tar.gz && \
    cp azcopy_linux_amd64_10.15.0/azcopy /usr/bin/ && \
    chmod +x /usr/bin/azcopy && \
    rm -rf a.tar.gz azcopy_linux_amd64_10.15.0

#RUN cd /app && \
    #git clone --recursive https://github.com/amsword/cocoapi && \
    #cd cocoapi/PythonAPI && \
    #make install

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6 zip -y
RUN apt-get install vim tmux -y --fix-missing

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -y install default-jre-headless

RUN pip install dnspython
RUN conda install -y -c conda-forge gdb

RUN apt-get install -y libgtest-dev

RUN cd /app && git clone https://github.com/yzygitzh/rccl.git && \
    cd rccl && \
    mkdir build && \
    cd build && \
    CXX=/opt/rocm/bin/hipcc cmake -DCMAKE_PREFIX_PATH=/opt/rocm/ .. && \
    make -j && \
    cd ../ && \
    cp ./build/librccl.so* /opt/rocm-5.2.3/lib/


RUN rm -rf /var/lib/apt/lists/*

