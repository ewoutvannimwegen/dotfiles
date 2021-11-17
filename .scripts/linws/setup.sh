#!/usr/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

PKGS=(
'build-essential'
'python3'
'python3-pip'
'texlive-full'
'zsh'
'git'
'nodejs'
'npm'
'xclip'
'ninja-build' 
'libtool'
'libtool-bin'
'autoconf'
'automake' 
'cmake' 
'g++' 
'doxygen'
'make'
'pkg-config'
'unzip'
'patch'
'gettext'
'curl'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt-get install "$PKG" -y 
done

DIR="$HOME/build"
if [ ! -d "$DIR" ]; then
    mkdir -p $DIR
fi
 
DIR="$HOME/build/neovim"
if [ ! -d "$DIR" ]; then
    cd $DIR && cd ..
    git clone https://github.com/neovim/neovim
    cd $DIR && make -j8
    sudo make clean install 
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

git init --bare $HOME/.Dotfiles 
alias dotfiles='/usr/bin/git --git-dir=$HOME/.Dotfiles --work-tree=$HOME' 
dotfiles config --local status.showUntrackedFiles no

git config --global user.name "ewoutvannimwegen"
git config --global user.email "ewoutvannimwegen@gmail.com"

dotfiles remote add origin https://github.com/ewoutvannimwegen/dotfiles.git
dotfiles pull origin main

sudo apt-get autoremove -y
