# based on https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git cmake

sudo apt-get remove vim vim-runtime gvim

git clone https://github.com/vim/vim.git
cd vim/src
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
sudo make install

# sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
# sudo update-alternatives --set editor /usr/bin/vim
# sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
# sudo update-alternatives --set vi /usr/bin/vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#setup the plugin
cp .vimrc ~/
vim +PluginInstall +qall

# install the pre-compiled clang-3.9, which is required by ycm
wget http://llvm.org/releases/3.9.0/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
tar xf clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
cd clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
sudo cp -R * /usr/local/

# setup the ycm
cd ~
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/usr/local/ . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release

#setup the command t
cd ~/.vim/bundle/command-t
rake make
