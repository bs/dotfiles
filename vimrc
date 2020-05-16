" TODO: Enter is pasting in thing from coc
" TODO: Add in custom fzf commands

" TODO: read about and understand floating windows
" TODO: passthrough cmd/ in iterm and remap that fancy highlight cursor
" TODO: add fancy fonts to ipad
" TODO: make spelling errors and whitespace less loud

" TODO: https://github.com/justinmk/vim-sneak
" TODO: https://github.com/justinmk/vim-gtfo
" TODO: https://github.com/Vigemus/nvimux
" TODO: https://ianding.io/2019/07/29/configure-coc-nvim-for-c-c++-development/
" TODO: https://github.com/christoomey/vim-tmux-navigator
" TODO: https://thoughtbot.com/blog/seamlessly-navigate-vim-and-tmux-splits
" TODO: https://github.com/SirVer/ultisnips

"  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
"  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
" ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
" ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
" ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
" ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
" ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
"    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
"          ░    ░  ░    ░ ░        ░   ░         ░
"                                 ░

" Sweet ANSI art and a lot of config inspiration from:
" https://github.com/dkarter/dotfiles/blob/master/vimrc

" General settings {{{

scriptencoding utf-16               " allow emojis in vimrc
set nocompatible                    " vim, not vi
syntax on                           " syntax highlighting
filetype plugin indent on           " try to recognize filetypes and load rel' plugins

" }}}

" Basic Global Settings {{{

" set leader key
let mapleader = "\\"

" alias for leader key
nmap <space> \
xmap <space> \

set backspace=2                     " Backspace deletes like most programs in insert mode
set hidden                          " enable hidden unsaved buffers
set history=200       " how many : commands to save in history
set ruler                           " show the cursor position all the time
set showcmd           " display incomplete commands
set incsearch         " do incremental searching
set laststatus=2                    " Always display the status line
set autowrite         " Automatically :write before running commands
set ignorecase                      " ignore case in searches
set smartcase                       " use case sensitive if capital letter present or \C
set magic             " Use 'magic' patterns (extended regular expressions).
set noshowmode        " don't show mode as airline already does
set showcmd           " show any commands
set foldmethod=manual               " set folds by syntax of current language
set foldcolumn=2                    " display gutter markings for folds
set iskeyword+=-                    " treat dash separated words as a word text object

set termguicolors                   " enable true colors
set mouse=a                         " enable mouse (selection, resizing windows)
set guioptions=                     " remove scrollbars on macvim

" tabs and spaces and text appearance
set tabstop=2                       " Softtabs or die! use 2 spaces for tabs.
set shiftwidth=2                    " Number of spaces to use for each step of (auto)indent.
set expandtab                       " insert tab with right amount of spacing
set shiftround                      " Round indent to multiple of 'shiftwidth'
set textwidth=80
set nowrap                          " nowrap by default
set list                            " show invisible characters
set listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace

if !has('nvim')                     " does not work on neovim
  set emoji                         " treat emojis 😄  as full width characters
  set cryptmethod=blowfish2         " set encryption to use blowfish2 (vim -x file.txt)
end

set ttyfast                         " should make scrolling faster
set lazyredraw                      " should make scrolling faster

" visual bell for errors
set visualbell

" line numbers
set number
set numberwidth=1

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
if has('nvim')
  set diffopt+=vertical
endif

" set where swap file and undo/backup files are saved
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" persistent undo between file reloads
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/tmp,.
endif

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" yank to the macOS clipboard
set clipboard=unnamed

" highlight fenced code blocks in markdown
let g:markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'elixir',
      \ 'elm',
      \ 'graphql',
      \ 'html',
      \ 'js=javascript',
      \ 'json',
      \ 'python',
      \ 'ruby',
      \ 'sql',
      \ 'vim',
      \ ]

" }}}

" @bs: I don't have a complete understanding of why all of these need to be
" load before plugin loading.
" TODO: Play with these and moving the plugin load method around
"  Plugin Modifications (BEFORE loading bundles) ----- {{{

" ====================================
" Floaterm
" ====================================

let g:floaterm_position = 'center'
let g:floaterm_background = '#272c35'
let g:floaterm_winblend = 10


hi FloatermNF       guibg=#272c35
hi FloatermBorderNF guibg=#272c35 guifg=white

command! -nargs=0 FT FloatermToggle

" Use 90% width for floaterm. If error occurs, update the plugin
let g:floaterm_width = 0.9
let g:floaterm_height = 0.7

function s:floatermSettings()
    call SetColorColumn(0)
endfunction

augroup FloatermCustom
  autocmd!

  autocmd FileType floaterm call s:floatermSettings()
  " <leader>h : Hide the floating terminal window
  " <leader>q : Quit the floating terminal window
  autocmd FileType floaterm tmap <buffer> <silent> <leader>q <C-\><C-n>:call SetColorColumn(1)<CR>:q<CR>
  autocmd FileType floaterm tmap <buffer> <silent> <leader>h <C-\><C-n>:call SetColorColumn(1)<CR>:hide<CR>
augroup END

nnoremap <silent> <leader>gg :FloatermNew lazygit<CR>

"" ====================================
" UndoTree:
" ====================================
nnoremap <silent> <leader>ut :UndotreeToggle<CR>

" ====================================
" COC
" ====================================

" TODO: @bs: Not using asdf ... may need to do something about node path here
" Tell CoC where node is if it doesn't know
" let current_node_path = trim(system('asdf where nodejs'))
" let g:coc_node_path = current_node_path . '/bin/node'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup CocConfig
  autocmd!
  " coc-highlight: enable highlighting for symbol under cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" set coc as nvim man page provider for functions
" TODO: maybe need to check if coc is enabled for file and do setlocal?
set keywordprg=:call\ CocAction('doHover')

" ====================================
" Vista.vim
" ====================================

" use coc as backend
let g:vista_default_executive = 'coc'

let g:vista_finder_alternative_executives = ['ctags']

" enable fzf preview
let g:vista_fzf_preview = []

" enable icons (must have patched fonts)
let g:vista#renderer#enable_icon = 1

" enable nicer indentation using patched fonts
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" how long before scrolling / floating the definition
let g:vista_cursor_delay = 200

" how to show the definition
let g:vista_echo_cursor_strategy = 'floating_win'

" update symbol list when text changed (really it should be on file saved or
" different file opened)
let g:vista_update_on_text_changed = 1

" mappings
nnoremap <leader>vv :Vista!<CR>
nnoremap <leader>vf :Vista finder<CR>

" ====================================
" NeoTerm:
" ====================================
let g:neoterm_repl_ruby = 'pry'
let g:neoterm_autoscroll = 1

" ====================================
" Gist:
" ====================================
map <leader>gst :Gist<cr>

" ====================================
" indentLine
" ====================================

let g:indentLine_fileType = [
      \ 'python',
      \ 'java',
      \ 'ruby',
      \ 'elixir',
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'html',
      \ 'eruby',
      \ 'vim'
      \ ]

let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#454C5A'

" ====================================
" setup airline
" ====================================
" let g:airline#extensions#branch#enabled = 0
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_mode_map = {
"       \ '__' : '-',
"       \ 'n'  : 'N',
"       \ 'i'  : 'I',
"       \ 'R'  : 'R',
"       \ 'c'  : 'C',
"       \ 'v'  : 'V',
"       \ 'V'  : 'V',
"       \ '' : 'V',
"       \ 's'  : 'S',
"       \ 'S'  : 'S',
"       \ '' : 'S',
"       \ }

" ----------------------------------------------------------------------------
" Scratch.vim
" ----------------------------------------------------------------------------
let g:scratch_no_mappings=1

nnoremap <leader>sc :Scratch<CR>

augroup ScratchToggle
  autocmd!
  autocmd FileType scratch nnoremap <buffer> <leader>sc :q<CR>
augroup END


" =============================================================================
" FZF
" =============================================================================

let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --color=always -E .git --ignore-file ~/.gitignore'
let $FZF_DEFAULT_OPTS='--ansi --layout=reverse'
let g:fzf_files_options = '--preview "(bat --color \"always\" --line-range 0:100 {} || head -'.&lines.' {})"'

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <C-b> :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>
nnoremap <silent> <C-g>g :call FZFOpen(':FzfRg!')<CR>
nnoremap <silent> <C-g>c :call FZFOpen(':Commands')<CR>
nnoremap <silent> <C-g>l :call FZFOpen(':BLines')<CR>
nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>
nnoremap <silent> <Leader>h :call FZFOpen(':History')<CR>
nnoremap <silent> <C-t> :call FZFOpen(':BTags')<CR>
nnoremap <silent> <C-g>h :call FZFOpen(':Files ~/')<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" FZF Command History
cnoremap <silent> <C-r> call FZFOpen(':History:')<CR>

" ======================================
" FZF + DevIcons
" ======================================

function! FzfIcons()
  let l:fzf_files_options = '--preview "bat --color always --style numbers {2..} | head -'.&lines.'"'
   function! s:edit_devicon_prepended_file(item)
    let l:file_path = a:item[4:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': $FZF_DEFAULT_COMMAND . ' | devicon-lookup --color',
        \ 'sink':   function('s:edit_devicon_prepended_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'window': { 'width': 0.9, 'height': 0.6 }
        \ })

endfunction

" Git Blamer
let g:blamer_enabled = 1

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
let g:NERDTreeIgnore = [
      \ '\.vim$',
      \ '\~$',
      \ '\.beam',
      \ 'elm-stuff',
      \ 'deps',
      \ '_build',
      \ '.git',
      \ 'node_modules',
      \ 'tags',
      \ ]

let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer=1
" keep alternate files and jumps
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

nnoremap <Leader>nt :NERDTreeToggle<CR>

" not necessarily NTree related but uses NERDTree because I have it setup
nnoremap <leader>d :e %:h<CR>

augroup NERDTreeAuCmds
  autocmd!
  autocmd FileType nerdtree nmap <buffer> <expr> - g:NERDTreeMapUpdir
augroup END
" move up a directory with "-" like using vim-vinegar (usually "u" does that)


" ----------------------------------------------------------------------------
" WebDevIcons
" ----------------------------------------------------------------------------
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:WebDevIconsOS = 'Darwin'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ex'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['exs'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rb'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rabl'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['erb'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['svg'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['elm'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.ruby-version'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.ruby-gemset'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.rspec'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Rakefile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['application.rb'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['environment.rb'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['routes.rb'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['spring.rb'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.keep'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = ''

" Useful alternatives:           

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" ----------------------------------------------------------------------------
"  vim-nerdtree-syntax-highlight:
" ----------------------------------------------------------------------------
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['ex'] = '834F79'
let g:NERDTreeExtensionHighlightColor['exs'] = 'c57bd8'
let g:NERDTreeExtensionHighlightColor['yml'] = 'f4bf70'
let g:NERDTreeExtensionHighlightColor['yaml'] = 'f4bf70'
let g:NERDTreeExtensionHighlightColor['elm'] = '39B7CF'

" if has('statusline')
"   set laststatus=2

"   " Broken down into easily includeable segments
"   set statusline=%<%f\    " Filename
"   set statusline+=%w%h%m%r " Options
"   set statusline+=%{fugitive#statusline()} "  Git Hotness
"   set statusline+=\ [%{&ff}/%Y]            " filetype
"   set statusline+=\ [%{getcwd()}]          " current dir
"   set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
" endif

" Strip all trailing whitespace
" nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<Cr>


" Load all plugins ------------------------------- {{{
if filereadable(expand('~/.vimrc.bundles'))
  source ~/.vimrc.bundles
endif
" }}}

" UI Customizations --------------------------------{{{
colorscheme dracula

" solid window border requires FuraCode Nerd Font
set fillchars+=vert:│
"  }}}

" Auto commands ------------------------------------------------- {{{
  augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile .babelrc set filetype=json
    autocmd BufRead,BufNewFile *.yrl set filetype=erlang
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile .eslintrc,.prettierrc set filetype=json

    " Enable spellchecking for Markdown
    autocmd FileType markdown setlocal spell

    " Automatically wrap at 80 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80

    " Automatically wrap at 72 characters and spell check git commit messages
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal spell

    " Allow stylesheets to autocomplete hyphenated words
    autocmd FileType css,scss,sass setlocal iskeyword+=-

    " Vim/tmux layout rebalancing
    " automatically rebalance windows on vim resize
    autocmd VimResized * :wincmd =

    " add support for comments in json (jsonc format used as configuration for
    " many utilities)
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " notify if file changed outside of vim to avoid multiple versions
    autocmd FocusGained * checktime

    " disable automatic comment insertion
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  augroup END
" }}}

" Vim Script file settings ------------------------ {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

"  Key Mappings -------------------------------------------------- {{{
"
" Delete current buffer without losing the split
nnoremap <silent> <C-q> :bp\|bd #<CR>

" copy and paste
map <C-_> gcc


" open FZF in current file's directory
nnoremap <silent> <Leader>_ :Files <C-R>=expand('%:h')<CR><CR>

" fold file based on syntax
nnoremap <silent> <leader>zs :setlocal foldmethod=syntax<CR>

" rename current file
nnoremap <Leader>rn :Move <C-R>=expand("%")<CR>

" Navigate in Tmux and Vim Splits
" nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> <C-w>p {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Sayonara
"nnoremap <silent> <leader>q :Sayonara<CR>

  " Split edit your vimrc. Type space, v, r in sequence to trigger
    fun! OpenConfigFile(file)
      if (&filetype ==? 'startify')
        execute 'e ' . a:file
      else
        execute 'tabe ' . a:file
      endif
    endfun

    nnoremap <silent> <leader>vr :call OpenConfigFile('~/.vimrc')<cr>
    nnoremap <silent> <leader>vb :call OpenConfigFile('~/.vimrc.bundles')<cr>
    ""
  " Source (reload) your vimrc. Type space, s, o in sequence to trigger
    nnoremap <leader>so :source $MYVIMRC<cr>

  " VimPlug
   nnoremap <leader>pi :PlugInstall<CR>
    nnoremap <leader>pu :PlugUpdate<CR>
    nnoremap <leader>pc :PlugClean<CR>

  " change dir to current file's dir
    " nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

  " zoom a vim pane, <C-w> = to re-balance
    " nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
    " nnoremap <leader>= :wincmd =<cr>


  " close all other windows with <leader>o
    " nnoremap <leader>wo <c-w>o

  " Tab/shift-tab to indent/outdent in visual mode.
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

  " Keep selection when indenting/outdenting.
    vnoremap > >gv
    vnoremap < <gv

  " Incsearch:
    " map /  <Plug>(incsearch-forward)
    " map ?  <Plug>(incsearch-backward)
    " map g/ <Plug>(incsearch-stay)

" --------------------- Key Mappings ---------------------------- }}}

" NeoVim Specific -----------------------------------------------------------------------------------------------------------
if has('nvim')
  " use neovim-remote (pip3 install neovim-remote) allows
  " opening a new split inside neovim instead of nesting
  " neovim processes for git commit
    let $VISUAL      = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
    let $GIT_EDITOR  = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
    let $EDITOR      = 'nvr -l'
    let $ECTO_EDITOR = 'nvr -l'

    " interactive find replace preview
    set inccommand=nosplit

    augroup TerminalMod
      autocmd!
      autocmd BufEnter *
            \ if &buftype == 'terminal' |
            \   setlocal foldcolumn=0 |
            \ endif
      autocmd TermEnter * setlocal foldcolumn=0
    augroup END


  " share data between nvim instances (registers etc)
    augroup SHADA
      autocmd!
      autocmd CursorHold,TextYankPost,FocusGained,FocusLost *
            \ if exists(':rshada') | rshada | wshada | endif
    augroup END

  " set pum background visibility to 20 percent
    set pumblend=20

  " set file completion in command to use pum
    set wildoptions=pum

    " Two versions of this ... I'm using this one for now because I want to
    " use <C-j> & <C-k> to navigate up and down.
    tnoremap <silent><C-w>h <C-\><C-n><C-w>h
    tnoremap <silent><C-w>j <C-\><C-n><C-w>j
    tnoremap <silent><C-w>k <C-\><C-n><C-w>k
    tnoremap <silent><C-w>l <C-\><C-n><C-w>l

    " easily escape terminal
    tnoremap <leader><esc> <C-\><C-n><esc><cr>
    tnoremap <C-o> <C-\><C-n><esc><cr>

  " quickly toggle term
    nnoremap <silent> <leader>o :vertical botright Ttoggle<cr><C-w>l
    nnoremap <silent> <leader>O :botright Ttoggle<cr><C-w>j
    nnoremap <silent> <leader><space> :vertical botright Ttoggle<cr><C-w>l

    " close terminal
    tnoremap <silent> <leader>o <C-\><C-n>:Ttoggle<cr>
    tnoremap <silent> <leader><space> <C-\><C-n>:Ttoggle<cr>

  " send stuff to REPL using NeoTerm
    nnoremap <silent> <c-s>l :TREPLSendLine<CR>
    vnoremap <silent> <c-s>s :TREPLSendSelection<CR>

  " pasting works quite well in neovim as is so disabling yo
    nnoremap <silent> yo o
    nnoremap <silent> yO O

endif
" }}}
"
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1

" " For VimPlug {{{
" function! PlugGx()
"   let l:line = getline('.')
"   let l:sha  = matchstr(l:line, '^  \X*\zs\x\{7,9}\ze ')

"   if (&filetype ==# 'vim-plug')
"     " inside vim plug splits such as :PlugStatus
"     let l:name = empty(l:sha)
"                   \ ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
"                   \ : getline(search('^- .*:$', 'bn'))[2:-2]
"   else
"     " in .vimrc.bundles
"     let l:name = matchlist(l:line, '\v/([A-Za-z0-9\-_\.]+)')[1]
"   endif

"   let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')
"   if l:uri !~? 'github.com'
"     return
"   endif
"   let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
"   let l:url  = empty(l:sha)
"               \ ? 'https://github.com/'.l:repo
"               \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
"   call netrw#BrowseX(l:url, 0)
" endfunction

" augroup PlugGxGroup
"   autocmd!
"   autocmd BufRead,BufNewFile .vimrc.bundles nnoremap <buffer> <silent> gx :call PlugGx()<cr>
"   autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
" augroup END
" " }}}


