#! /bin/sh

# zsh
ln -s ./zshrc ../.zshrc

# vim
ln -s ./vim ../.vim
ln -s ./vimrc ../.vimrc

# git
git config --global core.excludesfile ./gitignore
