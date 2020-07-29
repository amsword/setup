
ROOT_FOLDER=$(pwd)

VIM_CONFIG=~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
touch $VIM_CONFIG
cp init.vim $VIM_CONFIG

rm -rf ~/.vim
rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim



python generate_vimrc.py
cd $ROOT_FOLDER
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
	-DPATH_TO_LLVM_ROOT=$ROOT_FOLDER/$CLANG_FILE_NAME . \
	~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release

cp $ROOT_FOLDER/.vimrc ~/.vimrc 

#setup the command t
#cd ~/.vim/bundle/command-t
#rake make

