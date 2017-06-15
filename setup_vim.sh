set -e
# based on https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
sudo apt-get update
sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git cmake

sudo apt-get remove -y vim vim-runtime gvim rake

git clone https://github.com/vim/vim.git
cd vim/src
# the version of python might be bumpped, pls change it accordingly
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim80
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#setup the plugin

cd ~/code/setup
cp .vimrc ~/
vim -i None +PluginInstall +qall

# install the pre-compiled clang-3.9, which is required by ycm
wget http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
tar xf clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz

# setup the ycm
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" \
	-DPATH_TO_LLVM_ROOT=~/code/setup/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04 . \
	~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release

#setup the command t
cd ~/.vim/bundle/command-t
sudo apt-get install -y rake ruby-dev
rake make
