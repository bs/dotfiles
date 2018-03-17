#!/bin/sh

set -e

# neovim
which nvim || (echo "Download nvim. https://github.com/neovim/neovim/wiki/Installing-Neovim" && exit 1)
which zsh || (echo "You gotta get zsh." && exit 1)
which ctags || (echo "You need exuberant-ctags/tags" && exit 1)

# vim
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.config
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip install --user neovim

# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf ~/dotfiles/oh-my-zsh/themes ~/.oh-my-zsh/custom/themes
ln -sf ~/dotfiles/zshrc ~/.zshrc

# git
git config --global user.name "Britt Selvitelle"
git config --global user.email yap@bri.tt
git config --global core.excludesfile ~/dotfiles/gitignore

# tmux
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

# fzf
cd /tmp
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Finished!!! Logout and log back in to get started!"
