sudo apt-get install -y wget
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_8.0.61-1_amd64.deb -O cuda-repo.deb
dpkg -i cuda-repo.deb
sudo apt-get update
sudo apt-get install -y cuda

rm -f cuda-repo.deb
