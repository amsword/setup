pip install neovim

ROOT_FOLDER=$(pwd)

rm ~/.vimrc -f
rm ~/.config/nvim -rf

# python generate_vimrc.py
cd $ROOT_FOLDER
cat .vimrc_plugin_template .vimrc_customize_template > ~/.vimrc

VIM_CONFIG=~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
touch $VIM_CONFIG
cp init.vim $VIM_CONFIG

rm -rf ~/.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim +PluginInstall +qall

cd ~/.vim/plugged/YouCompleteMe/ && python install.py

# setup the command t
cd ~/.vim/plugged/command-t/lua/wincent/commandt/lib
make

