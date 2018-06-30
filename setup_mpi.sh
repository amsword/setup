sudo apt-get install libnuma-dev

mkdir -p ~/data/lib
cd ~/data/lib
VERSION=3.1
FILENAME=openmpi-$VERSION.1
ZIPFILENAME=$FILENAME.tar.gz
URL=https://download.open-mpi.org/release/open-mpi/v$VERSION/$ZIPFILENAME
wget $URL
tar -xvf $ZIPFILENAME
cd $FILENAME
./configure --prefix=/usr/local
make -j
make all
sudo make install
# update the lib 
sudo ldconfig
