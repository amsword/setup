set -e

sudo locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8 
sudo dpkg-reconfigure locales

git config --global user.email "jianfengwang@outlook.com" && \
        git config --global user.name "Jianfeng Wang"

# setup the ipython configuration 
ipython profile create 
mkdir -p ~/.config/ipython/profile_default/
echo "c.InteractiveShell.autoindent = False" >> ~/.config/ipython/profile_default/ipython_config.py
