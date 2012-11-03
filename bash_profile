export CLICOLOR=1
export PATH=~/bin:/usr/local/bin:~/.rbenv/bin:$PATH
export EDITOR=vi

source ~/.git-completion.bash

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Show full path and git branch (if exists) in prompt
export PS1="\w\[\033[34m\]\$(parse_git_branch)\[\033[00m\] $\[\033[00m\] "

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
source /usr/local/bin/virtualenvwrapper.sh
