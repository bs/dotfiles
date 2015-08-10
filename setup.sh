#!/bin/bash

# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf ~/dotfiles/oh-my-zsh/themes ~/.oh-my-zsh/custom/themes
ln -sf ~/dotfiles/zshrc ~/.zshrc

# vim
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# git
git config --global core.excludesfile ~/dotfiles/gitignore

echo "start zsh"
echo "vim +PluginInstall +qall or :PluginInstall"
