sudo apt-get install libnuma-dev

mkdir -p ~/data/lib
cd ~/data/lib
FILENAME=openmpi-1.10.3
ZIPFILENAME=$FILENAME.tar.gz
URL=https://download.open-mpi.org/release/open-mpi/v1.10/$ZIPFILENAME
wget $URL
tar -xvf $ZIPFILENAME
cd $FILENAME
./configure --prefix=/usr/local
make -j
make all
make install
