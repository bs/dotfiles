#!/bin/bash

# fail if a piped cmd throws an exception and treat unset variables as errors
set -eou pipefail

# display utilities for this script
source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/bs/dotfiles/script/prompt)"

# Are we on Mac or Linux?
if test "$(uname)" = "Darwin"
then
  BREW_PATH = "/usr/local"

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then
  BREW_PATH = "/home/linuxbrew/.linuxbrew"
fi

# Install my brew ¯\_(ツ)_/¯
brew_install() {
  if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    success 'my brew installed!'

    eval $($BREW_PATH/bin/brew shellenv)
    success 'brew env variables temporally set'

    brew analytics off
    success 'brew analytics turned off'
  else
    info 'my brew already installed'
  fi
}

# update my brew
brew_update () {
  brew update
  success 'my brew updated'
}

# zsh install
# TODO: is it sane to install zsh via brew on linux? mebbe?
zsh_install() {
  if test $(which zsh); then
      info "zsh already installed..."
  else
      brew install zsh
      success 'zsh installed'
  fi

  # Install zinit - framework for loading zsh plugins
  if [ ! -d "~/.zinit" ]; then
    mkdir ~/.zinit
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
  else
    echo 'zinit already installed'
    # TODO: cd into the directory and pull down the latest zinit
  fi
}

# pull down and symlink dotfiles
dotfiles_install() {
  echo ''
  read -p "Do you want to use these sweet dotfiles? y/n" -n 1 -r

  # move to a new line
  echo
  echo

  if [[ $REPLY =~ ^[Yy]$ ]] then
    echo "Right on ..."

    git clone https://github.com/bs/dotfiles.git ~/dotfiles

    echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
    echo

    if [[ $? -eq 0 ]]
      then
        echo "symlinks successful!"
      else
        echo "symlink whoopsie..." >&2
    fi
  else
    echo 'coo coo coo ...'
  fi
}

# action time

cd ~/

brew_install
brew_update

zsh_install

dotfiles_install
