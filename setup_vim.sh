sudo apt-get install -y vim-nox git rake ruby-dev

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#setup the plugin
cp .vimrc ~/
vim +PluginInstall +qall

# setup the ycm
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

#setup the command t
cd ~/.vim/bundle/command-t
rake make
