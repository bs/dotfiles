#!/bin/bash

# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln --backup -s ~/dotfiles/oh-my-zsh/themes ~/.oh-my-zsh/custom/themes
ln --backup -s ~/dotfiles/zshrc ~/.zshrc

# vim
ln --backup -s ~/dotfiles/vim ~/.vim/
ln --backup -s ~/dotfiles/vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# git
git config --global core.excludesfile ./gitignore

echo "start zsh"
