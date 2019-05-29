set -e

CUDNN_URL=https://amsword.blob.core.windows.net/setup/CUDNN/libcudnn7_7.4.2.24-1%2Bcuda9.0_amd64.deb
CUDNN_DEV_URL=https://amsword.blob.core.windows.net/setup/CUDNN/libcudnn7-dev_7.4.2.24-1%2Bcuda9.0_amd64.deb

# the following two files come from the offical website
wget $CUDNN_URL -O cudnn.deb 
dpkg -i cudnn.deb

wget $CUDNN_DEV_URL -O cudnn-dev.deb 
dpkg -i cudnn-dev.deb

rm cudnn.deb
rm cudnn-dev.deb

