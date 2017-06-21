set -e
sudo apt-get update
sudo apt-get install -y \
    ipython \
    build-essential \
    clang \
    git \
    ipython \
    lsb-release \
    python-dev \
    python-pip \
    python-software-properties \
    rake \
    ruby-dev \
    silversearcher-ag \
    software-properties-common

sudo locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 
sudo dpkg-reconfigure locales

git config --global user.email "jianfengwang@outlook.com"
git config --global user.name "Jianfeng Wang"

sudo pip install -r requirements.txt

ipython profile create 
mkdir -p ~/.config/ipython/profile_default/
echo "c.InteractiveShell.autoindent = False" >> ~/.config/ipython/profile_default/ipython_config.py
