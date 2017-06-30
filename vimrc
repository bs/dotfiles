" Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

set encoding=utf-8
set guifont=Meslo\ LG\ M\ for\ Powerline:h14
set laststatus=2
set ambiwidth=single
"let g:Powerline_symbols = 'unicode'
"let g:Powerline_symbols = 'fancy'

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

set nocompatible " vim, not vi
filetype off     " not sure
filetype plugin on

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

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'

" ***** Github
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
" Bundle 'tpope/vim-endwise'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
"Bundle 'Soares/ack.vim'
Bundle 'mileszs/ack.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'majutsushi/tagbar'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplcache'
Bundle 'flazz/vim-colorschemes'
" Bundle 'scrooloose/nerdcommenter'
Bundle 'mbbill/undotree'
Bundle 'spf13/vim-colors'
Bundle 'Lokaltog/vim-powerline'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'pangloss/vim-javascript'

" ***** Vim-Scripts Repos
"Bundle 'L9'
Bundle 'matchit.zip'

" ***** Non Github Repos
"Bundle 'git://git.wincent.com/command-t.git'

" Old Bundles I'm not sure if I want to use
"Bundle 'tpope/vim-fugitive'
"Bundle 'sjl/gundo.vim'
"Bundle 'sjbach/lusty'
"Bundle 'taq/vim-git-branch-info'
"Budle 'myusuf3/numbers.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


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

" neocomplcache {
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_enable_auto_delimiter = 1
  let g:neocomplcache_max_list = 15
  let g:neocomplcache_auto_completion_start_length = 3
  let g:neocomplcache_force_overwrite_completefunc = 1
  let g:neocomplcache_snippets_dir='~/.vim/bundle/snipmate-snippets/snippets'

  " AutoComplPop like behavior.
  let g:neocomplcache_enable_auto_select = 0

  " SuperTab like snippets behavior.
  imap  <silent><expr><tab>  neocomplcache#sources#snippets_complete#expandable() ? "\<plug>(neocomplcache_snippets_expand)" : (pumvisible() ? "\<c-e>" : "\<tab>")
  smap  <tab>  <right><plug>(neocomplcache_snippets_jump) 

  " Plugin key-mappings.
  " Ctrl-k expands snippet & moves to next position
  " <CR> chooses highlighted value
  imap <C-k>     <Plug>(neocomplcache_snippets_expand)
  smap <C-k>     <Plug>(neocomplcache_snippets_expand)
  inoremap <expr><C-g>   neocomplcache#undo_completion()
  inoremap <expr><C-l>   neocomplcache#complete_common_string()
  inoremap <expr><CR>    neocomplcache#complete_common_string()


  " <CR>: close popup
  " <s-CR>: close popup and save indent.
  inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
  inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"

  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><s-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
  let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

  " For snippet_complete marker.
  if has('conceal')
      set conceallevel=2 concealcursor=i
  endif

" }

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
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
