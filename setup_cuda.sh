apt-get install -y wget
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.0-28_amd64.deb -O cuda-repo.deb
dpkg -i cuda-repo.deb
apt-get update
apt-get install -y cuda-toolkit-6-5
# rm cuda-repo.deb
