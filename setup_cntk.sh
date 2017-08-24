MKL_FILE_NAME=CNTKCustomMKL-Linux-3.tgz
MKL_URL=https://www.microsoft.com/en-us/cognitive-toolkit/wp-content/uploads/sites/3/2017/05/MKL_FILE_NAME
MKL_TARGET_FOLDER=/usr/local/CNTKCustomMKL
OMP_FILE=openmpi-1.10.3.tar.gz
OMP_URL=https://www.open-mpi.org/software/ompi/v1.10/downloads/$OMP_FILE
PROTOL_BUF_FILE=v3.1.0.tar.gz
PROTOL_BUF_URL=https://github.com/google/protobuf/archive/$PROTOL_BUF_FILE
LIBZIP_FOLDER=libzip-1.1.2
LIBZIP_FILE=${LIBZIP_FOLDER}.tar.gz
LIBZIP_URL=http://nih.at/libzip/$LIBZIP_FILE
BOOST_FOLDER=boost_1_60_0
BOOST_URL=https://sourceforge.net/projects/boost/files/boost/1.60.0/${BOOST_FOLDER}.tar.gz/download
CUB_VERSION=1.4.1
CUB_FOLDER=cub-${CUB_VERSION}
CUB_NAME_IN_URL=${CUB_VERSION}.zip
CUB_URL=https://github.com/NVlabs/cub/archive/${CUB_NAME_IN_URL}
CUDNN_FILE=cudnn-8.0-linux-x64-v6.0.tgz
CUDNN_URL=http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/$CUDNN_FILE


if [ ! -f $MKL_FILE_NAME ]; then
    wget $MKL_URL
fi

if [ ! -d $MKL_TARGET_FOLDER ]; then
    sudo mkdir $MKL_TARGET_FOLDER
    sudo tar -xzf CNTKCustomMKL-Linux-3.tgz -C $MKL_TARGET_FOLDER 
fi

if [ ! -f $OMP_FILE ]; then
    wget $OMP_URL
    tar -xzvf ./openmpi-1.10.3.tar.gz
    cd openmpi-1.10.3
    ./configure --prefix=/usr/local/mpi
    make -j all
    sudo make install
    cd ..
fi
export PATH=/usr/local/mpi/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/mpi/lib:$LD_LIBRARY_PATH

if [ ! -f $PROTOL_BUF_FILE ]; then
    sudo apt-get install -y curl
    wget $PROTOL_BUF_URL
    tar -xzf v3.1.0.tar.gz
    cd protobuf-3.1.0
    ./autogen.sh
    ./configure CFLAGS=-fPIC CXXFLAGS=-fPIC --disable-shared \
        --prefix=/usr/local/protobuf-3.1.0
    cd ..
    make -j $(nproc)
    sudo make install
fi

if [ ! -f $LIBZIP_FILE ]; then
    wget $LIBZIP_URL
    tar -xzvf ./$LIBZIP_FILE
    cd $LIBZIP_FOLDER
    ./configure
    make -j all
    sudo make install
fi

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

if [ ! -d $BOOST_FOLDER ]; then
    sudo apt-get install libbz2-dev
    sudo apt-get install python-dev
    
    wget -q -O - https://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz/download | tar -xzf - 
    cd $BOOST_FOLDER
    ./bootstrap.sh --prefix=/usr/local/boost-1.60.0
    sudo ./b2 -d0 -j"$(nproc)" install  
    cd ..
fi

if [ ! -d $CUB_FOLDER ]; then
    wget $CUB_URL
    uzip ./${CUB_FOLDER}
    sudo cp -r $CUB_FOLDER /usr/local
fi

if [ ! -f $CUDNN_FILE ]; then
    wget $CUDNN_URL
    tar -xzvf ./$CUDNN_FILE
    sudo mkdir /usr/local/cudnn-6.0
    sudo cp -r cuda /usr/local/cudnn-6.0
fi
export LD_LIBRARY_PATH=/usr/local/cudnn-6.0/cuda/lib64:$LD_LIBRARY_PATH

s#udo apt-get install zlib1g-dev


