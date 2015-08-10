#!/bin/bash

# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s ~/.dotfiles/zshrc ~/.zshrc

# vim
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc

# git
git config --global core.excludesfile ./gitignore

# start zsh
zsh
