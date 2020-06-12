# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /usr/local/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

conda activate snake_jazz

# google-cloud-sdk
set -x PATH $PATH ~/google-cloud-sdk/bin

# aliases -- temp hack until we move these out into functions
alias vim='nvim'
alias vimdiff='nvim -d'

# starship prompt
# set -x STARSHIP_CONFIG ~/dotfiles/config/fish/starship.toml
# starship init fish | source
