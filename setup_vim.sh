set -e
# based on https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
sudo apt-get update
sudo apt-get install -y  \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    python3-dev \
    ruby-dev \
    lua5.1 \
    lua5.1-dev \
    libperl-dev \
    git \
    cmake \
    build-essential \
    rake \
    ruby-dev

sudo apt-get remove -y vim vim-runtime gvim

rm -rf vim
git clone https://github.com/vim/vim.git
cd vim/src
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim80
sudo make install
cd ../../

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

rm -rf ~/.vim
rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


LSB_RELEASE_INFO=$(lsb_release -r)
IS_14=1
if [[ $LSB_RELEASE_INFO = *"16.04" ]]; then
    IS_14=0
fi

if [ $IS_14 -eq 1 ]; then
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
    sudo apt-get update
    sudo apt-get install -y gcc-5 g++-5
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 \
        60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
fi

python generate_vimrc.py
cd ~/code/setup
cp .vimrc_plugin ~/.vimrc
vim +PluginInstall +qall

if [ $IS_14 -eq 1 ]; then
    CLANG_FILE_NAME="clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-14.04" 
    CLANG_TAR_FILE_NAME=${CLANG_FILE_NAME}.tar.xz
    rm -f $CLANG_TAR_FILE_NAME
    wget http://releases.llvm.org/4.0.0/$CLANG_TAR_FILE_NAME
    tar xf $CLANG_TAR_FILE_NAME 
else
    CLANG_FILE_NAME="clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz" 
    CLANG_TAR_FILE_NAME=${CLANG_FILE_NAME}.tar.xz
    rm -f $CLANG_TAR_FILE_NAME
    wget http://releases.llvm.org/6.0.1/$CLANG_TAR_FILE_NAME
    tar xf $CLANG_TAR_FILE_NAME 
fi

# setup the ycm
rm -rf ycm_build
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" \
	-DPATH_TO_LLVM_ROOT=~/code/setup/$CLANG_FILE_NAME . \
	~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release

cp ~/code/setup/.vimrc ~/.vimrc

#setup the command t
cd ~/.vim/bundle/command-t
rake make
