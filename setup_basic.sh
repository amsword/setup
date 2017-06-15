set -e
# install packages
sudo apt-get install -y rake
sudo apt-get install -y ruby-dev
sudo pip install pyyaml
sudo pip install lmdb

sudo apt-get install -y silversearcher-ag

# setup the ipython configuration 
ipython profile create 
echo "c.InteractiveShell.autoindent = False" >> ~/.config/ipython/profile_default/ipython_config.py
