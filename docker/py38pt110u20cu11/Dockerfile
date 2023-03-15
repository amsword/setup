FROM mcr.microsoft.com/azureml/aifx/stable-ubuntu2004-cu115-py38-torch1110

ENV LD_LIBRARY_PATH=/opt/hpcx/nccl_rdma_sharp_plugin/lib:$LD_LIBRARY_PATH
ENV NCCL_ASYNC_ERROR_HANDLING=1
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

RUN rm -rf /var/lib/apt/lists/*

FROM singularitybase.azurecr.io/validations/base/singularity-tests:20210729T152030606 AS validator
FROM singularitybase.azurecr.io/base/job/deepspeed/0.4-pytorch-1.8.0-cuda11.1-cudnn8-devel:20210728T191425219
COPY --from=validator /validations /opt/microsoft/_singularity/validations/
ENV SINGULARITY_IMAGE_ACCELERATOR=NVIDIA
RUN /opt/microsoft/_singularity/validations/validator.sh
