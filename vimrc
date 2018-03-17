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
" set number " Show line numbers
" set ruler  " Show line and column number

"
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

call plug#begin('~/.vim/plugged')

" Molokai color scheme
Plug 'tomasr/molokai'

" Manage Tag Files
Plug 'ludovicchabant/vim-gutentags'

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" A collection of language packs for Vim
Plug 'sheerun/vim-polyglot'

" quoting and parens
Plug 'tpope/vim-surround'

" Tree style file navigation
" Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'

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

" Sane buffer/window deletion
Plug 'mhinz/vim-sayonara'

" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise'

" Search in project
Plug 'ctrlpvim/ctrlp.vim'

" A nicer Python indentation style for vim
Plug 'Vimjas/vim-python-pep8-indent'

" Visualize Undo Tree
Plug 'mbbill/undotree'

" Search in files ... uses ripgrep
Plug 'mileszs/ack.vim'

" Find faster
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'


"Plug 'jeetsukumaran/vim-buffergator'
"
Plug 'scrooloose/nerdcommenter'

"Plug 'spf13/vim-colors'
"Plug 'nathanaelkane/vim-indent-guides'

" Auto complete quotes, etc
"Plug 'Raimondi/delimitMate'

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
"inoremap <F1> <ESC>
"nnoremap <F1> <ESC>
"vnoremap <F1> <ESC>

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
"nnoremap <silent> <leader>q :Sayonara<CR>

" =================== vim-airline ========================
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1

" Toggle paste mode
"nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" Lusty Explorer
"nmap <silent> <Leader>b :LustyBufferExplorer<CR>
"nmap <silent> <Leader>f :LustyFilesystemExplorer<CR>
"nmap <silent> <Leader>r :LustyFilesystemExplorerFromHere<CR>
 " Lusty requires hidden mode

"let g:NERDShutUp=1

" NerdTree {

" }

" Tagbar
"let g:tagbar_ctags_bin = "/opt/local/bin/ctags"

"let g:deoplete#enable_at_startup = 1

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
"  set grepformat=%f:%l:%c:%m,%f:%l:%m

  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0

"  let g:ctrlp_user_command = 'rg --files %s'
"  let g:ctrlp_working_path_mode = 'ra'
"  let g:ctrlp_switch_buffer = 'et'
endif

let g:ackprg = 'rg --vimgrep --no-heading'

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Use :F inside vim to search text
"let g:rg_command = '
 "\ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
 "\ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,py,asm,nasm}"
 "\ -g "!{.git,node_modules,vendor}/*" '

"command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

set wildignore+=*/.git/*,*/tmp/*,*.swp

"command! -bang -nargs=* Rg
      "\ call fzf#vim#grep(
      "\   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      "\   <bang>0 ? fzf#vim#with_preview('up:60%')
      "\           : fzf#vim#with_preview('right:50%:hidden', '?'),
      "\   <bang>0)


" From FZF
nmap ; :CtrlPBuffer<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>f :Ag<CR>
nmap <Leader>u :UndotreeToggle<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Use deoplete.
let g:deoplete#enable_at_startup = 1


map <D-/> \c<space><CR>
imap <D-/> \c<space><CR>

if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif
