# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# TODO: break out aliases into their own files
# TODO: Maybe at some point check out https://github.com/romkatv/powerlevel10k

# vi mode
# bindkey -v
# export KEYTIMEOUT=1

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Map a few of the emacs keyboard shortcuts to vi
bindkey '^K' up-history
bindkey '^J' down-history

# Set the default user so we don't show the user in the path
# unless it's someone else.
DEFAULT_USER="britt"

DISABLE_AUTO_TITLE=true


# Preferred editor for local and remote sessions
if [ -z ${EDITOR+x} ]; then
  export EDITOR='nvim'
fi

# Editor for git commits, rebases etc (don't set it if it was set already...
# i.e. by NeoVim)
if [ -z ${GIT_EDITOR+x} ]; then
fi

# vim
alias e="$EDITOR"
alias v="$VISUAL"
alias sp="nvr -cc split"
alias vs="nvr -cc vsplit"
alias tree="tree -C"
alias :qa="nvr -cc ':qa'"
alias :wq="nvr -cc ':wq'"

alias vim="$EDITOR"
alias vi="$EDITOR"
alias vimdiff='nvim -d'
alias legacyvim='command vim'

# notes
wi() {
  cd ~/src/wikish
  e +cd ~/src/wikish/
}

# edit zshrc
zc() {
  e ~/dotfiles/zshrc
}



# enable colored output from ls, etc
export CLICOLOR=1

# case insensitive autoomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# fzf - cli fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ripgrep

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

export FZF_DEFAULT_COMMAND='fd --type f --follow --color=always --exclude .git --exclude node_modules --exclude vendor --exclude build --exclude _build --exclude bundle --exclude Godeps'
export FZF_DEFAULT_OPTS="--ansi --bind='ctrl-o:execute(vim {})+abort'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if $(command -v fzf >/dev/null); then

  # fif - find in file ... ripgrep
  #grep --line-buffered --color=never -r "" * | fzf

  # with ag - respects .agignore and .gitignore
  #ag --nobreak --nonumbers --noheading . | fzf

  # using ripgrep combined with preview
  # find-in-file - usage: fif <searchTerm>
  fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
  }

  # v() {
    # local file
    # file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
  # }

  # fo [FUZZY PATTERN] - Open the selected file with the default editor
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
  #   - CTRL-O to open with `open` command,
  #   - CTRL-E or Enter key to open with the $EDITOR
  fo() {
    local out file key
    out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
    key=$(head -1 <<<"$out")
    file=$(head -2 <<<"$out" | tail -1)
    if [ -n "$file" ]; then
      [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-nvim} "$file"
    fi
  }

  # vf - fuzzy open with vim from anywhere
  # ex: vf word1 word2 ... (even part of a file name)
  # zsh autoload function
  vf() {
    local files

    files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

    if [[ -n $files ]]
    then
       vim -- $files
       print -l $files[1]
    fi
  }

  # fcd - cd to selected directory
  fcd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*' -prune \
      -o -type d -print 2>/dev/null | fzf +m) &&
      cd "$dir"
  }

  # fcda - including hidden directories
  fcda() {
    local dir
    dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
  }

  # cdf - cd into the directory of the selected file
  fcdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
  }

  # cf - fuzzy cd from anywhere
  # ex: cf word1 word2 ... (even part of a file name)
  # zsh autoload function
  cf() {
    local file

    file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

    if [[ -n $file ]]
    then
       if [[ -d $file ]]
       then
          cd -- $file
       else
          cd -- ${file:h}
       fi
    fi
  }

  # fh - repeat history
  fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  }

  # fkill - kill process
  fkill() {
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
      kill -${1:-9} $pid
    fi
  }

  # fgco - checkout git branch/tag
  fgco() {
    local tags branches target
    tags=$(
      git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}'
    ) || return
    branches=$(
      git branch --all | grep -v HEAD |
        sed "s/.* //" | sed "s#remotes/[^/]*/##" |
        sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}'
    ) || return
    target=$(
      (
        echo "$tags"
        echo "$branches"
      ) |
        fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2
    ) || return
    git checkout $(echo "$target" | awk '{print $2}')
  }

  # fgcoc - checkout git commit
  fgcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
      commit=$(echo "$commits" | fzf --tac +s +m -e) &&
      git checkout $(echo "$commit" | sed "s/ .*//")
  }

  # fgshow - git commit browser
  fgshow() {
    git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
  FZF-EOF"
  }

  # fgcs - get git commit sha
  # example usage: git rebase -i `fcs`
  fgcs() {
    local commits commit
    commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
      commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
      echo -n $(echo "$commit" | sed "s/ .*//")
  }

  # fgstash - easier way to deal with stashes
  # type fstash to get a list of your stashes
  # enter shows you the contents of the stash
  # ctrl-d shows a diff of the stash against your current HEAD
  # ctrl-b checks the stash out as a branch, for easier merging
  fgstash() {
    local out q k sha
    while out=$(
      git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
        fzf --ansi --no-sort --query="$q" --print-query \
          --expect=ctrl-d,ctrl-b
    ); do
      mapfile -t out <<<"$out"
      q="${out[0]}"
      k="${out[1]}"
      sha="${out[-1]}"
      sha="${sha%% *}"
      [[ -z "$sha" ]] && continue
      if [[ "$k" == 'ctrl-d' ]]; then
        git diff $sha
      elif [[ "$k" == 'ctrl-b' ]]; then
        git stash branch "stash-$sha" $sha
        break
      else
        git stash show -p $sha
      fi
    done
  }

  # Install one or more versions of specified language
  # e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
  # if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
  # Mnemonic [V]ersion [M]anager [I]nstall
  vmi() {
    local lang=${1}

    if [[ ! $lang ]]; then
      lang=$(asdf plugin-list | fzf)
    fi

    if [[ $lang ]]; then
      local versions=$(asdf list-all $lang | fzf -m)
      if [[ $versions ]]; then
        for version in $(echo $versions);
        do; asdf install $lang $version; done;
      fi
    fi
  }

  # fgst - pick files from `git status -s` 
  is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
  }

  fgst() {
    # "Nothing to see here, move along"
    is_in_git_repo || return

    local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
      printf '%q ' "$item" | cut -d " " -f 2
    done
    echo
  }

# fhistory() {
#   local cols sep
#   cols=$(( COLUMNS / 3 ))
#   sep='{::}'
#   tmpfile=$(mktemp /tmp/ffhist.XXXXX)
#   cp -f ~/Library/Application\ Support/Firefox/Profiles/yb3m2yuc.default-1548370077866/places.sqlite $tmpfile
#   sqlite3 -separator $sep $tmpfile \
#   "select substr(title, 1, $cols), url from moz_places
#   where url not like '%google%search%'
#   order by
#   visit_count desc,
#   last_visit_date desc;" |
#   awk -F $sep '{printf "%-'$cols's \x1b[36m%s\x1b[m\n", $1, $2}' |
#   fzf --ansi --multi | sed 's#.*\(https*://\)#\1#'
# }


fi

# Mosh
# export PATH=/usr/local/bin:$PATH

if [[ -n $TMUX ]]; then
    export NVIM_LISTEN_ADDRESS=/tmp/nvim_$USER_tmux
fi

nv() {
  if [ ! -z "$TMUX" ]; then
    local ids="$(tmux list-panes -a -F '#{pane_current_command} #{window_id} #{pane_id}' | awk '/^nvim / {print $2" "$3; exit}')"
    local window_id="$ids[(w)1]"
    local pane_id="$ids[(w)2]"
    [ ! -z "$pane_id" ] && tmux select-window -t "$window_id" && tmux select-pane -t "$pane_id"
  fi
  nvr -s $@
}

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# OMZSH git
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit snippet OMZ::plugins/fasd/fasd.plugin.zsh

# z for finding recent things
zinit light rupa/z
zinit light changyuheng/fz

zinit light zdharma/fast-syntax-highlighting
zinit light Aloxaf/fzf-tab

# extend completions
zinit light zsh-users/zsh-completions

# extend completions - conda
zinit light esc/conda-zsh-completion

# Fast-syntax-highlighting & autosuggestions
# zinit wait lucid for \
#  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
#     zdharma/fast-syntax-highlighting \
#  atload"!_zsh_autosuggest_start" \
#     zsh-users/zsh-autosuggestions \
#  blockf \
#     zsh-users/zsh-completions

# fish like autocomplete
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

bindkey '^[[[CE' autosuggest-accept
bindkey '^ ' autosuggest-accept

# FZF_COMPLETE=2

zinit light wfxr/forgit

zinit light zdharma/zsh-startify

# zsh history search
# pre-requisite `brew install zsh-history-substring-search`
# NOTE: must be placed after zsh-syntax-highlighting if used together
# readme: /usr/local/opt/zsh-history-substring-search/README.md
hist_plug=/usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
if [ -f $hist_plug ]; then
  source $hist_plug
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi

# Options for https://github.com/Aloxaf/fzf-tab
bindkey '^[[[CE' autosuggest-accept
# bindkey '^T' toggle-fzf-tab

# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false

# show dope previews
# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# (experimental, may change in the future)
# some boilerplate code to define the variable `extract` which will be used later
# please remember to copy them
local extract="
# trim input(what you select)
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap

# give a preview of directory by exa when completing cd
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'

zinit ice depth=1; zinit light romkatv/powerlevel10k

# general use
alias ls='exa' # ls
alias l='exa -lbF --git' # list, size, type, git
alias ll='exa -lbGF --git' # long list
alias lm='exa -lbF --git --sort=modified' # long list, modified date sort

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(starship init zsh)"
# Autojump which is the equiv of z
# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# From the very excellent [@krismolendyke](https://github.com/krismolendyke/dotfiles/)
# Also worth reading [this on securing macos](https://web.archive.org/web/20180604062858/https://www.davd.eu/securing-macos/)
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

# use asdf to manage programming languages (except python)
. $(brew --prefix asdf)/asdf.sh

# Use a conda env that is a clone of base,
# but maintain base as a clean reference
conda activate snake_jazz

# TODO: move these to a perm place for completions"
# google-cloud-sdk
if [ -f '/Users/britt/google-cloud-sdk/path.zsh.inc' ]; then
    export PATH="$PATH:/Users/britt/google-cloud-sdk/bin"
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/britt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/britt/google-cloud-sdk/completion.zsh.inc'; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
