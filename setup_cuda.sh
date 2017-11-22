apt-get install -y wget
wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64.deb -O cuda-repo.deb
dpkg -i cuda-repo.deb
apt-get update
apt-get install -y cuda

rm -f cuda-repo.deb

wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64.deb -O cuda-patch.deb
dpkg -i cuda-patch.deb
