# set up a mac or linux machine from scratch to awesome

# TODO: should probably refactor into classes

import os
from pathlib import Path
import pkgutil
import subprocess

home = Path.home()
dotfiles = home/'dotfiles'
home_dot_config = home/'.config'
dot_config = dotfiles/'config'

os_name = os.uname().sysname
is_mac = True if os_name == 'Darwin' else False
is_linux = True if os_name == 'Linux' else False

homebrew_prefix = '/usr/local' if is_mac else '/home/linuxbrew/.linuxbrew'
brew_binary = f'{homebrew_prefix}/bin/brew'

# utility
bcolors = {
    'header' : '\033[95m',
    'blue': '\033[94m',
    'green' : '\033[92m',
    'warn' : '\033[93m',
    'fail' : '\033[91m',
    'end' : '\033[0m',
    'bold' : '\033[1m',
    'underline' : '\033[4m',
    'reset': '\x1b[0m'
}

# donger inspired by @atomantic/dotfiles
def robo_says(msg, color='blue'):
    print(f'{bcolors["header"]}\\[._.]/ {bcolors[color]} {msg} {bcolors["reset"]}')

########################################################

# directories that should exist
directories = (
    home/'.zinit',
    home/'.vim',
    home/'.vim/tmp',
    home/'.config'
)

# symlinks
config_directories_to_symlink = (
    'nvim',
    'karabiner',
    'tridactyl',
    'fish',
    'kitty'
)

dotfiles_to_symlink = (
    'Brewfile',
    'gitconfig',
    'gitignore',
    'npmrc',
    'p10k.zsh',
    'tmux.conf',
    'vimrc.bundles',
    'vimrc',
    'xonshrc',
    'zshenv',
    'zshrc'
)

asdf_languages = (
    'nodejs',
    'ruby',
    'rust'
)

# why don't conda packages have a clever name?
conda_packages = (
)

pip_packages = (
    'pynvim',
    'neovim-remote',
    'notedown'
)

gems = (
    'json_pure',
    'neovim'
)

npm_global_packages = (
    'yarn',
    'neovim'
)

macos_config_script = 'macos_config.sh'

##################################################3

def create_directory(d):
    p = Path(d)
    if p.exists():
        robo_says(f'dir {d} already exists')
    else:
        p.mkdir()
        robo_says(f'dir {d} created', 'green')


def create_directories():
    robo_says('Setting up directories')

    for d in directories:
        create_directory(d)

# TODO: make these more resillient and recreate symlinks if they are changed
def sym_the_links():
    """symlink directories and dotfiles"""

    for d in config_directories_to_symlink:
        link = home_dot_config/d
        if not link.is_symlink():
            link.symlink_to(dot_config/d)

    for df in dotfiles_to_symlink:
        link = home/f'.{df}'
        if not link.is_symlink():
            link.symlink_to(dotfiles/df)


def brew_installed():
    return Path(brew_binary).is_file()

def git_clone(url=None, path=None):
    if url==None or path==None:
        raise ValueError('Tried to call git_clone without passing in a repo url or local path')

    subprocess.run(['git', 'clone', url, path])

def brew_install():
    robo_says(f'installing my true brew')
    if brew_installed():
        robo_says(f'true brew already installed', 'green')
    else:
        subprocess.run('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"', shell=True)

        subprocess.run([brew_binary, 'analytics', 'off'])
        robo_says('my true brew installed and analytics turned off', 'green')

def brew_update():
    if brew_installed:
        robo_says('updating brew packages')
        subprocess.run([brew_binary, 'update'])
        robo_says('brew updated', 'green')

def xcode_cli_install():
    if not is_mac:
        return

    exists = subprocess.run(['xcode-select', '--print-path'])

    if not exists.returncode == 0:
        subprocess.run(['xcode-select', '--install'])
        robo_says('xcode cli tools installed', 'green')
    else:
        robo_says('xcode cli tools already installed')

def mac_core_software_update():
    robo_says('updaing core macos packages')
    subprocess.run(['sudo', 'softwareupdate', '-i', '-a'])
    robo_says('core macos packages updated', 'green')

def exec_in_fish(cmd):
    subprocess.run(cmd, shell=True, executable=f'{homebrew_prefix}/bin/fish')

def conda_setup():
    """Setup conda shells and environments"""

    robo_says('adding conda init to shells')

    # TODO: Make work on linux ... need to look up where conda is
    for sh in ('fish', 'zsh', 'bash', 'xonsh'):
        subprocess.run(f'{homebrew_prefix}/anaconda3/bin/conda init {sh}', shell=True, executable=f'{homebrew_prefix}/bin/{sh}')

    # Use a conda env that is a clone of base, but maintain base as a clean reference
    # Interestingly right now, only from fish can you:
    #   - calling conda activate, other shells don't see the init block
    #   - sourcing ~/.{whichever_shell}rc to load a conda env changed in the config, other shells return status 0 but don't register the change
    robo_says('creating snake_jazz ... sss ss sss sssss')

    exec_in_fish('conda create --name snake_jazz --clone base')
    # fish should now pick up snake_jazz as its default when called from subprocess


def conda_packages_install():
    """install conda packages"""

    robo_says('installing conda packages')
    for pkg in conda_packages:
        exec_in_fish(f'conda install --name snake_jazz {pkg}')

    robo_says('done installing conda packages', 'green')

def pip_packages_install():
    """install pip packages"""

    robo_says('installing pip packages')
    for pkg in pip_packages:
        exec_in_fish(f'pip install {pkg}')

    robo_says('done setting up python! I know snake math!', 'green')

# install gems
def gems_install():
    """Install gems"""

    robo_says('installing ruby gems')
    for pkg in gems:
        exec_in_fish(f'gem install {pkg}')
    robo_says('ruby gems installed', 'green')

def npms_install():
    """Install npm packages"""

    robo_says('installing npm packages')
    for pkg in npm_global_packages:
        exec_in_fish(f'npm install -g {pkg}')

    robo_says('npm packages installed', 'green')

def asdf_plugins_install():
    """Install asdf plugins"""

    robo_says('installing asdf plugins')
    for lang in asdf_languages:
        subprocess.run(['asdf', 'plugin', 'add', lang])

def asdf_langs_install():
    """Install latest versions of asdf languages"""

    # get nodejs gpg keys
    robo_says('getting nodejs gpg keys')
    subprocess.run('/bin/bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring', shell=True)

    for lang in asdf_languages:
        robo_says(f'installing the latest version of {lang}')
        subprocess.run(['asdf', 'install', lang, 'latest'])
        subprocess.run(f'asdf global {lang} $(asdf latest {lang})', shell=True)

def zsh_setup():
    robo_says('setting up zsh')
    git_clone('https://github.com/zdharma/zinit.git', home/'.zinit/bin')
    robo_says('zinit installed', 'green')

    robo_says('sourcing zshrc and installing zsh plugins')
    subprocess.run('source ~/.zshrc', shell=True, executable='/usr/local/bin/zsh') # TODO: make this work on linux
    robo_says('zsh plugins loaded', 'green')

    robo_says('setting the default shell to zsh')
    subprocess.run(['chsh', '-s', f'{homebrew_prefix}/bin/zsh'])

def dotfiles_install():
    robo_says('fetching dotfiles')
    git_clone('https://github.com/bs/dotfiles', home/'dotfiles')

def brewfile_install():
    robo_says('installing brew packages')
    subprocess.run('brew bundle --file ~/.Brewfile', shell=True, executable='/bin/bash')

def brew_finish():
    """All of the things to do after brew packages are installed"""
    subprocess.run('$(brew --prefix)/opt/fzf/install', shell=True)
    subprocess.run(['brew', 'cleanup'])
    subprocess.run(['brew', 'doctor'])

def macos_configs_install():
    robo_says('flipping the switches on macOS configs')
    subprocess.run(f'/bin/bash ~/dotfiles/{macos_config_script}', shell=True)

    robo_says('macos configs done', 'green')

if __name__ == "__main__":
    robo_says('Running this dope thing.')

    create_directories()
    dotfiles_install()

    # Core packages
    xcode_cli_install()
    mac_core_software_update()

    # Move things around
    sym_the_links()

    # All the Homebrew things
    brew_install()
    brew_update()
    brewfile_install() # note: conda is installed here on mac
    brew_post()

    # shells
    zsh_setup()

    # programming languages
    conda_setup()
    asdf_plugins_install()
    asdf_langs_install()
    conda_packages_install()
    pip_packages_install()
    gems_install()
    npms_install()
    robo_says('done setting up programming languages. I know snake math!', 'green')

    macos_configs_install()

    robo_says('All done! Celebrate!!! (and reboot)', 'green')


### SCRAP

# import a module ... download it if it doesn't exist locally
# def install_and_import(package):
#     import importlib

#   try:
#     importlib.import_module(package)
#   except ImportError:
#     print(f'pip installing package {package}')
#     result = subprocess.run(['pip', 'install', package], capture_output = True)
#     if result.returncode == 1:
#       raise
#     else:
#       print(f'results: {result.stdout}')
#   finally:
#     print(f'importing {package}')
#     globals()[package] = importlib.import_module(package)

# def abort_if_false(ctx, param, value):
#   if not value:
#     print(f'oh no! {ctx}, {param}, {value}')
#     print(dir(ctx))

#     # TODO: come back and make this shiz work
#     ctx.fail('oh noes')
#     # ctx.abort()

# @click.command()
# @click.option('--yes', callback=abort_if_false, is_flag=True, default=True, prompt='Ready to get started?')
# def testo(yes):
#   click.echo(f'hi dude! {yes}')

