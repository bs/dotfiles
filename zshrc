# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set the default user so we don't show the user in the path
# unless it's someone else.
DEFAULT_USER="britt"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="lambda"
#ZSH_THEME="minimal"
#ZSH_THEME="fishy"
#ZSH_THEME="sorin"
ZSH_THEME="britt"
DISABLE_AUTO_TITLE=true

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh


# nvim
# alias vim="nvim"
# alias vi="nvim"
# alias vimdiff='nvim -d'
#export EDITOR=nvim

# fzf - cli fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# crazy hack for fastai aws setup
if ls /usr/local/cuda* 1> /dev/null 2>&1; then
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/home/ubuntu/src/cntk/bin:/usr/local/mpi/bin:$PATH
  export LD_LIBRARY_PATH=/home/ubuntu/src/cntk/bindings/python/cntk/libs:/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:$LD_LIBRARY_PATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
  export PYTHONPATH=/home/ubuntu/src/cntk/bindings/python
  if [ -e /usr/lib/libmpi_cxx.so ]; then
    export LD_PRELOAD=/usr/lib/libmpi_cxx.so
  fi
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:$LD_LIBRARY_PATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:/lib/:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$LD_LIBRARY_PATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:/lib/:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$LD_LIBRARY_PATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:/lib/:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$LD_LIBRARY_PATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PKG_CONFIG_PATH
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:/lib/:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$LD_LIBRARY_PATH
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:/lib/:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$LD_LIBRARY_PATH
  export PYTHONPATH=/home/gauta/src/caffe2/build:$PYTHONPATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PKG_CONFIG_PATH
  export PATH=/usr/local/cuda/bin:/usr/local/bin:/opt/aws/bin:/usr/local/mpi/bin:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PATH
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/lib:/usr/lib:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/mpi/lib:/lib/:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$LD_LIBRARY_PATH
  export PYTHONPATH=~/src/caffe2/build:$PYTHONPATH
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/home/ubuntu/src/caffe2/build:/home/ec2-user/src/caffe2/build:$PKG_CONFIG_PATH

  export PATH=~/src/anaconda3/bin:$PATH
  source activate fastai
else
  export PATH=~/anaconda3/bin:/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:$PATH

  # Python
  export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH
fi
