sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip
sudo apt-get install python-neovim
sudo apt-get install python3-neovim

VIM_CONFIG=~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
touch $VIM_CONFIG
cp init.vim $VIM_CONFIG
