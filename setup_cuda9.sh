CUDA_URL=https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb

PATCH1_URL=https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64-deb
PATCH2_URL=https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/2/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-2_1.0-1_amd64-deb
PATCH3_URL=https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/3/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-3_1.0-1_amd64-deb
PATCH4_URL=https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/4/cuda-repo-ubuntu1604-9-0-176-local-patch-4_1.0-1_amd64-deb

#PATCH1_URL=https://amsword.blob.core.windows.net/setup/CUDA/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64-deb
#PATCH2_URL=https://amsword.blob.core.windows.net/setup/CUDA/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-2_1.0-1_amd64-deb
#PATCH3_URL=https://amsword.blob.core.windows.net/setup/CUDA/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-3_1.0-1_amd64-deb
#PATCH4_URL=https://amsword.blob.core.windows.net/setup/CUDA/cuda-repo-ubuntu1604-9-0-176-local-patch-4_1.0-1_amd64-deb

wget $CUDA_URL -O cuda.deb
dpkg -i cuda.deb
apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
apt-get update
apt-get install -y cuda

wget $PATCH1_URL -O patch1.deb
dpkg -i patch1.deb

wget $PATCH2_URL -O patch2.deb
dpkg -i patch2.deb

wget $PATCH3_URL -O patch3.deb
dpkg -i patch3.deb

wget $PATCH4_URL -O patch4.deb
dpkg -i patch4.deb

rm cuda.deb patch1.deb patch2.deb patch3.deb patch4.deb
