apt-get install -y wget
if [ ! -f cuda-repo.deb ]; then
    wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64.deb -O cuda-repo.deb
fi
dpkg -i cuda-repo.deb
apt-get update
apt-get install -y cuda

rm -f cuda-repo.deb

if [ ! -f cuda-patch.deb ]; then
    wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64.deb -O cuda-patch.deb
fi

dpkg -i cuda-patch.deb
