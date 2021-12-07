# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /usr/local/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

conda activate snake_jazz

# google-cloud-sdk
set -x PATH $PATH ~/google-cloud-sdk/bin

# pip installed things in the userspace
fish_add_path ~/.local/bin

# aliases -- temp hack until we move these out into functions
alias vim='nvim'
alias vimdiff='nvim -d'
alias c='code-insiders'
alias e='emacsclient -nc'


# keybindings
bind \ck history-search-backward
bind \cj history-search-forward

# starship prompt
# set -x STARSHIP_CONFIG ~/dotfiles/config/fish/starship.toml
# starship init fish | source
