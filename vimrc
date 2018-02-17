set nocompatible " vim, not vi

set encoding=utf-8
set guifont=Meslo\ LG\ M\ for\ Powerline:h14
set laststatus=2
set ambiwidth=single

" Map <Leader> key to ,
let mapleader = ","

" tabs and spaces
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set hidden
set number " Show line numbers
set ruler  " Show line and column number

" clipboard
set clipboard=unnamed " yank to the macOS clipboard

" vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" close buffers on leaving them
autocmd BufEnter *? cclose

"if has("autocmd")
"  autocmd bufwritepost .vimrc source $MYVIMRC
"endif

" swap files
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" brittspace
set encoding=utf-8
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:.

" show matching brackets/parenthesis
set showmatch

" Plugins
call plug#begin()

" Manage Tag Files
Plug 'ludovicchabant/vim-gutentags'

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" Tree style file navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Git Wrapper
Plug 'tpope/vim-fugitive'

" shows a git diff in the gutter (sign column) and stages/undoes hunks
Plug 'airblade/vim-gitgutter'

" Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'flazz/vim-colorschemes'

" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" Better whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" A vim plugin to display the indention levels with thin vertical lines 
Plug 'Yggdroot/indentLine'

" A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. 
Plug 'elzr/vim-json'

" Sane buffer/window deletion
Plug 'mhinz/vim-sayonara'

" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise'

" Search in project
Plug 'kien/ctrlp.vim'

" A nicer Python indentation style for vim
Plug 'Vimjas/vim-python-pep8-indent'

" Useful pairs of mapping
Plug 'tpope/vim-unimpaired'


"Plug 'Soares/ack.vim'
Plug 'mileszs/ack.vim'
"Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'spf13/vim-colors'
"Plug 'Lokaltog/vim-powerline'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'vim-ruby/vim-ruby'
"Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'

" Auto complete quotes, etc
Plug 'Raimondi/delimitMate'

" Completion framework
Plug 'Shougo/deoplete.nvim'

" ***** Vim-Scripts Repos
"Bundle 'L9'
"Bundle 'matchit.zip'

" ***** Non Github Repos
"Bundle 'git://git.wincent.com/command-t.git'

" Old Bundles I'm not sure if I want to use
"Bundle 'tpope/vim-fugitive'
"Bundle 'sjl/gundo.vim'
"Bundle 'sjbach/lusty'
"Bundle 'taq/vim-git-branch-info'
"Budle 'myusuf3/numbers.vim'
call plug#end()

" No audio bell
set vb t_vb=

" Colorscheme
syntax on
set background=dark
let g:solarized_termtrans = 1
colorscheme molokai

" Don't show 99 char boundry in the terminal
set colorcolumn=0

" Get rid of the fucking help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Strip all trailing whitespace
" nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<Cr>

" ================== Sayonara ============================
nnoremap <silent> <leader>q :Sayonara<CR>

" =================== vim-airline ========================
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1

" ctrlp file searching
set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <silent> <C-e> :CtrlPRTS<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
nmap <silent> <C-b> :CtrlPBuffer<CR>

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" Lusty Explorer
"nmap <silent> <Leader>b :LustyBufferExplorer<CR>
"nmap <silent> <Leader>f :LustyFilesystemExplorer<CR>
"nmap <silent> <Leader>r :LustyFilesystemExplorerFromHere<CR>
 " Lusty requires hidden mode

let g:NERDShutUp=1

" NerdTree {
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
" }

" Ack
if has("gui_macvim") && has("gui_running")
   " Command-Shift-F on OSX
  map <D-F> :Ack!<space>
"   "call janus#add_mapping('ack', 'map', '<D-F>', ':Ack<space>')
" else
"   " Define <C-F> to a dummy value to see if it would set <C-f> as well.
"   map <C-F> :dummy
"
"   if maparg("<C-f>") == ":dummy"
"     " <leader>f on systems where <C-f> == <C-F>
"     " call janus#add_mapping('ack', 'map', '<leader>f', ':Ack<space>')
"   else
"     " <C-F> if we can still map <C-f> to <S-Down>
"     " call janus#add_mapping('ack', 'map', '<C-F>', ':Ack<space>')
"   endif
"
"   map <C-f> <S-Down>
endif

" TComment
if has("gui_macvim") && has("gui_running")
  map <D-/> gc
endif

map <D-/> :TComment<CR>
" map <D-t> <ESC>:CtrlP<CR>
" imap <D-t> <ESC>:CtrlP<CR>
" inoremap <D-t> <esc>:CtrlP<CR>
"else
"  call janus#add_mapping('ctrlp', 'map', '<C-t>', ':CtrlP<CR>')
"  call janus#add_mapping('ctrlp', 'imap', '<C-t>', '<ESC>:CtrlP<CR>')
"endif

     " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }
     "}

let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0
let g:NERDTreeHijackNetrw = 0

" Tagbar
let g:tagbar_ctags_bin = "/opt/local/bin/ctags"

let g:deoplete#enable_at_startup = 1
