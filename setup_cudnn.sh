set -e

# the following two files come from the offical website
wget https://amsword.blob.core.windows.net/setup/libcudnn7_7.0.5.15-1%2Bcuda8.0_amd64.deb -O cudnn.deb 
sudo dpkg -i cudnn.deb

wget https://amsword.blob.core.windows.net/setup/libcudnn7-dev_7.0.5.15-1%2Bcuda8.0_amd64.deb -O cudnn-dev.deb 
sudo dpkg -i cudnn-dev.deb

