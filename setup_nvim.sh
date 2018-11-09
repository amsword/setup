sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip
sudo apt-get install python-neovim
sudo apt-get install python3-neovim
sudo gem install neovim


VIM_CONFIG=~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
touch $VIM_CONFIG
cp init.vim $VIM_CONFIG

rm -rf ~/.vim
rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim



python generate_vimrc.py
cd ~/code/setup
cp .vimrc_plugin ~/.vimrc
nvim +PluginInstall +qall

CLANG_FILE_NAME="clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04" 
CLANG_TAR_FILE_NAME=${CLANG_FILE_NAME}.tar.xz
rm -f $CLANG_TAR_FILE_NAME
wget http://releases.llvm.org/6.0.1/$CLANG_TAR_FILE_NAME
tar xf $CLANG_TAR_FILE_NAME 

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

# nvim with python support. assume conda is used
sudo pip install neovim
