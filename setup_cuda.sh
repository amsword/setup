#apt-get install -y wget

LSB_RELEASE_INFO=$(lsb_release -r)
IS_14=1
if [[ $LSB_RELEASE_INFO = *"16.04" ]]; then
    IS_14=0
fi

if [ ! -f cuda-repo.deb ]; then
    if [ $IS_14 -eq 1 ]; then
        wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64.deb -O cuda-repo.deb.tmp
    else
        wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb -O cuda-repo.deb.tmp
    fi
    mv cuda-repo.deb.tmp cuda-repo.deb
fi

# if previously you install a version, the option of --force-overwrite will
# overwrite previous version, which is the expected behavior
sudo dpkg --force-overwrite -i cuda-repo.deb
sudo apt-get update
sudo apt-get install -y cuda

#rm -f cuda-repo.deb

if [ ! -f cuda-patch.deb ]; then
    if [[ $IS_14 -eq 1 ]]; then
        wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1404-8-0-local-cublas-performance-update_8.0.61-1_amd64.deb -O cuda-patch.deb
    else
        wget https://amsword.blob.core.windows.net/setup/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64.deb -O cuda-patch.deb
    fi
fi

sudo dpkg -i --force-overwrite cuda-patch.deb
