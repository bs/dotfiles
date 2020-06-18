" TODO: what to do about karabiner only registering escape on keyup?
" TODO: make ctrl-c close a floating window (I'm thinking fzf ... maybe not terminal? in fzf maybe even esc. I guess the reason not to is if I needed to move around in visual and copy something)
" TODO: Make terminal opening with spacespace focus the terminal
" TODO: Find a better way to bind keys for exiting insert mode in a terminal

" TODO: https://github.com/justinmk/vim-sneak
" TODO: https://github.com/justinmk/vim-gtfo
" TODO: https://github.com/SirVer/ultisnips

" TODO: Send a thank you to @dkarter for vimrc fu
" TODO: Send a thank you to @junegunn for all of his amazing work
" TODO: Send a thank you to @mhinz for all of his amazing work
" TODO: Who was that vim hacker that was vegan that I wanted to ping?


   " *------------------------------------------------------*
   " |                                                      |
   " |   i like vim                                         |
   " |                                                      |
   " *------------------------------------------------------*
   "        o
   "         o   ^__^
   "          o  (oo)\_______
   "             (__)\       )\/\
   "                 ||----w |
   "                 ||     ||


" General settings {{{

scriptencoding utf-16               " allow emojis in vimrc
set nocompatible                    " vim, not vi
syntax on                           " syntax highlighting
filetype plugin indent on           " try to recognize filetypes and load rel' plugins

" set leader key - unfortunately this has to execute at the beginning of the vimrc
let mapleader = ","

" alias for leader key
map <space> ,
xmap <space> ,

set clipboard=unnamedplus " yank to the macOS clipboard
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
set tabstop=2                       " Softtabs - use 2 spaces for tabs.
set shiftwidth=2                    " Number of spaces to use for each step of (auto)indent.
set expandtab                       " insert tab with right amount of spacing
" set shiftround                      " Round indent to multiple of 'shiftwidth'
" set textwidth=80
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

set number " line numbers
set relativenumber " current line is 0

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

" highlight fenced code blocks in markdown
let g:markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'html',
      \ 'js=javascript',
      \ 'json',
      \ 'python',
      \ 'ruby',
      \ 'sql',
      \ 'vim',
      \ ]

" g:python3_host_prog =

" }}}

" Load all plugins {{{
if filereadable(expand('~/.vimrc.bundles'))
  source ~/.vimrc.bundles
endif
" }}}

" Plugin settings (sans mapping) {{{

" UndoTree:
nnoremap <silent> <leader>ut :UndotreeToggle<CR>

" Investigate
let g:investigate_use_dash=1

" iamcco/markdown-preview.nvim
let g:mkdp_auto_close=0
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='~/dotfiles/github-markdown.css'

" COC

" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Vista.vim

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

" NeoTerm:

let g:neoterm_autoscroll = 1
let g:neoterm_autoinsert = 1

" Gist:

map <leader>gst :Gist<cr>

" indentLine

let g:indentLine_fileType = [
      \ 'python',
      \ 'java',
      \ 'ruby',
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'html',
      \ 'eruby',
      \ 'vim'
      \ ]

let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#454C5A'

" airline
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
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

" Scratch.vim

let g:scratch_no_mappings=1
let g:scratch_persistence_file = '~/.vim/tmp/scratch.vim'

nnoremap <leader>sc :Scratch<CR>

augroup ScratchToggle
  autocmd!
  autocmd FileType scratch nnoremap <buffer> <leader>sc :q<CR>
augroup END

" Workspace

nnoremap <leader>s :ToggleWorkspace<CR>

" goyo.vim + limelight.vim

let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

let g:background_before_goyo = &background

function! s:goyo_enter()

  set wrap
  set linebreak

  let g:background_before_goyo = &background
  if has('gui_running')
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
endfunction

function! s:goyo_leave()

  set nowrap
  set nolinebreak

  if has('gui_running')
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  execute 'Limelight!'
  execute 'set background=' . g:background_before_goyo
endfunction

augroup GOYO
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

" Snippets (UltraSnips):
let g:UltiSnipsEditSplit                   = 'vertical'
let g:UltiSnipsSnippetDirectories = ['~/dotfiles/vim/ultisnips']

" Saynoara

let g:sayonara_confirm_quit = 1

" Delete current buffer without losing the split
" nnoremap <silent> <C-q> :bp\|bd #<CR>

" Startify

nnoremap <leader>st :Startify<cr>
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1

let g:startify_change_to_dir       = 0
let g:startify_fortune_use_unicode = 1

" Rainbow Brackets
let g:rainbow_active = 1

" auto save
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]


" semshi
let g:semshi#error_sign	= v:false                       " let ms python lsp handle this

" Clap
" nnoremap <silent> <C-b> :Clap buffers<CR>
" nnoremap <silent> <C-y> :Clap history<CR>
cnoremap <silent> <C-r> :Clap command_history<CR>
" nnoremap <silent> <C-p> :Clap filer<CR>
nnoremap <silent> <C-g>u :Clap filer ~/<CR>
" map <Leader>v :Clap registers <CR>

" FZF

" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction:w


let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --color=always -E .git --ignore-file ~/.gitignore'
let $FZF_DEFAULT_OPTS='--ansi --layout=reverse'
let g:fzf_files_options = '--preview "(bat --color \"always\" --line-range 0:100 {} || head -'.&lines.' {})"'

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

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

" FZF Command History
" cnoremap <silent> <C-r> call FZFOpen(':History:')<CR>

" Custom Fzf Commands
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))

" FZF + DevIcons
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

" NERDTree

" \ '\.vim$',
" \ '\~$',
let g:NERDTreeIgnore = [
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

augroup NERDTreeAuCmds
  autocmd!
  autocmd FileType nerdtree nmap <buffer> <expr> - g:NERDTreeMapUpdir
augroup END

"  vim-nerdtree-syntax-highlight:
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['ex'] = '834F79'
let g:NERDTreeExtensionHighlightColor['exs'] = 'c57bd8'
let g:NERDTreeExtensionHighlightColor['yml'] = 'f4bf70'
let g:NERDTreeExtensionHighlightColor['yaml'] = 'f4bf70'
let g:NERDTreeExtensionHighlightColor['elm'] = '39B7CF'

" WebDevIcons
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
" if exists('g:loaded_webdevicons')
"   call webdevicons#refresh()
" endif

" vimwiki

let g:vimwiki_list = [{
                        \ 'path': '~/src/wikish/',
                        \ 'syntax': 'markdown',
                        \ 'ext': '.md'
                    \ }]

" vim-zettel

let g:zettel_format = "%y%m%d-%H%M-%title"
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"


" }}} Plugin settings (sans mapping)

" Auto commands {{{
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

  " enable spell only if file type is normal text
  let spellable = ['markdown', 'gitcommit', 'txt', 'text', 'liquid']
  autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif

  " startify when there is no open buffer left
  autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif


  " open startify on start
  autocmd VimEnter * if argc() == 0 | Startify | endif

  " auto html tags closing, enable for markdown files as well
  let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.md'

  " relative numbers on normal mode only
  augroup numbertoggle
    autocmd!
    autocmd InsertLeave * set relativenumber
    autocmd InsertEnter * set norelativenumber
  augroup END



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

  " 4 spaces indentation in python
  autocmd FileType python setlocal tabstop=4 shiftwidth=4

  " Vim Script file settings
  augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
  augroup END

augroup END
" }}}

" Misc {{{

" flash line and col briefly when jumping to a previous location
noremap <C-o> <C-o> :set cursorline <bar> set cursorcolumn <bar> call timer_start(300, { tid -> execute('set cursorline! <bar> set cursorcolumn!')})<cr>

" edit config files
fun! OpenConfigFile(file)
  execute 'e ' . a:file
endfun

" }}} Misc

" NeoVim Specific (TODO: Get rid of this) {{{
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

    " augroup TerminalMod
    "   autocmd!
    "   autocmd BufEnter *
    "         \ if &buftype == 'terminal' |
    "         \   setlocal foldcolumn=0 |
    "         \ endif
    "   autocmd TermEnter * setlocal foldcolumn=0
    " augroup END


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

endif
" }}}

" UI Customizations {{{
colorscheme dracula

" solid window border (requires patched Nerd Font)
set fillchars+=vert:│

highlight Pmenu guibg='#00010a' guifg=white              " popup menu colors
highlight Comment gui=italic cterm=italic               " bold comments
" highlight Normal gui=none
" highlight NonText guibg=none
" highlight clear SignColumn                              " use number color for sign column color
hi Search guibg=#b16286 guifg=#ebdbb2 gui=NONE          " search string highlight color
" autocmd ColorScheme * highlight VertSplit cterm=NONE    " split color
" hi NonText guifg=bg                                     " mask ~ on empty lines
hi clear CursorLineNr                                   " use the theme color for relative number
hi CursorLineNr gui=bold                                " make relative number bold


"  }}}

" Key Mappings {{{

"" the essentials
nnoremap ; :
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nmap <leader>w :w<CR>
nmap <leader>/ :FzfRg
inoremap jk <Esc>

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" cmd / to comment
map <C-_> gcc

"" buffer navigation

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" open FZF in current file's directory
nnoremap <silent> <Leader>_ :Files <C-R>=expand('%:h')<CR><CR>

" fold file based on syntax
nnoremap <silent> <leader>zs :setlocal foldmethod=syntax<CR>


" rename current file
nnoremap <Leader>rn :Move <C-R>=expand("%")<CR>

" navigaton in Tmux and Vim Splits
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-p> :TmuxNavigatePrevious<cr>

" map classic vim splits to tmux
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>

" Moving within the vim :terminal
nnoremap <Leader>t      :vsplit +terminal<cr>
tnoremap <Esc> <C-\><C-n>
" tnoremap et <c-\><c-n>

tnoremap <silent> <M-h> <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <M-j> <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <M-k> <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <M-l> <C-\><C-n>:TmuxNavigateRight<cr>

" map classic vim splits from terminal to tmux
tnoremap <silent> <M-w>h <C-\><C-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <M-w>j <C-\><C-n>:TmuxNavigateDown<cr>
tnoremap <silent> <M-w>k <C-\><C-n>:TmuxNavigateUp<cr>
tnoremap <silent> <M-w>l <C-\><C-n>:TmuxNavigateRight<cr>


" edit configs
nnoremap <silent> <leader>vc :call OpenConfigFile('~/.vimrc')<cr>
nnoremap <silent> <leader>vb :call OpenConfigFile('~/.vimrc.bundles')<cr>

" Source (reload) vimrc
nnoremap <leader>so :source $MYVIMRC<cr>

" VimPlug
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

" change dir to current file's dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" closing things + sayonara
map <silent><leader>q :Sayonara<CR>
"nmap \ <leader>q

" move lines up and down in visual mode
xnoremap <c-k> :move '<-2<CR>gv=gv
xnoremap <c-j> :move '>+1<CR>gv=gv

" nmap <leader>q :Sayonara<CR>
nnoremap <silent><C-q> :Sayonara<CR>

nnoremap <M-q> <Esc>:confirm qall<CR>
nnoremap <M-Q> <Esc>:qall!<CR>
imap <M-q> <Esc>:confirm qall<CR>
imap <M-Q> <Esc>:qall!<CR>

"nnoremap <silent><leader>q  :Sayonara<cr>
nnoremap <silent><leader>Q  :Sayonara!<cr>

"" easy motion stuff
" search behavior
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" quick navigation
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)

" vista
nnoremap <leader>v :Vista!!<CR>
nnoremap <leader>vf :Vista finder<CR>

" coc

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" FZF
nnoremap <silent> <C-b> :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>
nnoremap <silent> <C-g>g :call FZFOpen(':FzfRg!')<CR>
nnoremap <silent> <C-g>c :call FZFOpen(':Commands')<CR>
nnoremap <silent> <C-g>l :call FZFOpen(':BLines')<CR>
nnoremap <silent> <C-g>h :call FZFOpen(':History')<CR>
nnoremap <silent> <C-y> :call FZFOpen(':History')<CR>
nnoremap <silent> <C-t> :call FZFOpen(':BTags')<CR>
" nnoremap <silent> <C-g>u :call FZFOpen(':Files ~/')<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent> <C-g>d :call FZFOpen(':Cd ~')<CR>

" NerdTree
nnoremap <Leader>nt :NERDTreeToggle<CR>

" not necessarily NTree related but uses NERDTree because I have it setup
nnoremap <leader>d :e %:h<CR>


" }}}

"  Experimental Key Mappings -------------------------------------------------- {{{
"
  " zoom a vim pane, <C-w> = to re-balance
    " nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
    " nnoremap <leader>= :wincmd =<cr>


  " close all other windows with <leader>o
    " nnoremap <leader>wo <c-w>o

  " Tab/shift-tab to indent/outdent in visual mode.
    " vnoremap <Tab> >gv
    " vnoremap <S-Tab> <gv

  " Keep selection when indenting/outdenting.
    " vnoremap > >gv
    " vnoremap < <gv

  " Incsearch:
    " map /  <Plug>(incsearch-forward)
    " map ?  <Plug>(incsearch-backward)
    " map g/ <Plug>(incsearch-stay)

" --------------------- Key Mappings ---------------------------- }}}
