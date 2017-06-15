set -e
# install packages
sudo apt-get install -y rake
sudo apt-get install -y ruby-dev
sudo apt-get install -y python-pip python-dev build-essential
sudo apt-get install -y ipython
sudo apt-get install -y silversearcher-ag
sudo apt-get install -y lsb-release
sudo apt-get install software-properties-common python-software-properties

sudo locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 
sudo dpkg-reconfigure locales

sudo pip install pyyaml
sudo pip install lmdb

# setup the ipython configuration 
ipython profile create 
mkdir -p ~/.config/ipython/profile_default/
echo "c.InteractiveShell.autoindent = False" >> ~/.config/ipython/profile_default/ipython_config.py
