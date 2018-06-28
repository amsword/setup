sudo apt-get install libnuma-dev

mkdir -p ~/data/lib
cd ~/data/lib
wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.0.tar.gz
tar -xvf openmpi-3.1.0.tar.gz
cd openmpi-3.1.0
./configure --prefix="$HOME/data/lib/mpi"
make -j
make install
