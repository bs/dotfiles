" TODO: what to do about karabiner only registering escape on keyup?
" TODO: make ctrl-c close a floating window (I'm thinking fzf ... maybe not terminal? in fzf maybe even esc. I guess the reason not to is if I needed to move around in visual and copy something)
" TODO: Add in custom fzf commands
" TODO: Why isn't COC working in command mode?
" TODO: Make terminal opening with spacespace focus the terminal
" TODO: Find a better way to bind keys for exiting insert mode in a terminal
" TODO: Read over the functions that open another document from terminal
" TODO: Look up better Dash integration
" TODO: What is CtrlSF?
" TODO: Make sure I can restore old scratchs
" TODO: FZF in vim isn't obeying my gitignore
" TODO: $EDITOR in a :terminal is still mapped to nvim (likely vrom .zsh)

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

" TODO: Send a thank you to @dkarter for vimrc fu
" TODO: Send a thank you to @junegunn for all of his amazing work
" TODO: Send a thank you to @mhinz for all of his amazing work
" TODO: Who was that vim hacker that was vegan that I wanted to ping?
" TODO: Floating windows don't close if I hit esc w/ FZF


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

" }}}

" Basic Global Settings {{{

" set leader key
let mapleader = "\\"

" alias for leader key
map <space> \
xmap <space> \

" inoremap jf <esc>

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

" line numbers
set number
" set numberwidth=1

" Autocomplete with dictionary words when spell check is on
" set complete+=kspell

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

" @bs: I don't have a complete understanding of why all of these need to be
" load before plugin loading.
" TODO: Play with these and moving the plugin load method around

"  Plugin Modifications (BEFORE loading bundles) ----- {{{

" ====================================
" Floaterm
" ====================================

" let g:floaterm_position = 'center'
" let g:floaterm_background = '#272c35'
" let g:floaterm_winblend = 10


" hi FloatermNF       guibg=#272c35
" hi FloatermBorderNF guibg=#272c35 guifg=white

" command! -nargs=0 FT FloatermToggle

" " Use 90% width for floaterm. If error occurs, update the plugin
" let g:floaterm_width = 0.9
" let g:floaterm_height = 0.7

" function s:floatermSettings()
"     call SetColorColumn(0)
" endfunction

" augroup FloatermCustom
"   autocmd!

"   autocmd FileType floaterm call s:floatermSettings()
"   " <leader>h : Hide the floating terminal window
"   " <leader>q : Quit the floating terminal window
"   autocmd FileType floaterm tmap <buffer> <silent> <leader>q <C-\><C-n>:call SetColorColumn(1)<CR>:q<CR>
"   autocmd FileType floaterm tmap <buffer> <silent> <leader>h <C-\><C-n>:call SetColorColumn(1)<CR>:hide<CR>
" augroup END

" nnoremap <silent> <leader>gg :FloatermNew lazygit<CR>

"" ====================================
" UndoTree:
" ====================================
nnoremap <silent> <leader>ut :UndotreeToggle<CR>

" ====================================
" Investigate
" ====================================

let g:investigate_use_dash=1

" ====================================
" COC
" ====================================

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" " TODO: Pasting in CoC Vanilla config until I understand better
" " TextEdit might fail if hidden is not set.
" set hidden

" " Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" " Give more space for displaying messages.
" set cmdheight=2

" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300

" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" set signcolumn=yes

" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" let g:endwise_no_mappings=1 " endwise also maps the <CR> key
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Other CoC I pulled ... not using until I understand the dealio
" TODO: Not using asdf ... may need to do something about node path here
" Tell CoC where node is if it doesn't know
" let current_node_path = trim(system('asdf where nodejs'))
" let g:coc_node_path = current_node_path . '/bin/node'

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" augroup CocConfig
"   autocmd!
"   " coc-highlight: enable highlighting for symbol under cursor
"   autocmd CursorHold * silent call CocActionAsync('highlight')

"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup END

" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')

" " set coc as nvim man page provider for functions
" " TODO: maybe need to check if coc is enabled for file and do setlocal?
" set keywordprg=:call\ CocAction('doHover')

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
let g:scratch_persistence_file = '~/.vim/tmp/scratch.vim'

nnoremap <leader>sc :Scratch<CR>

augroup ScratchToggle
  autocmd!
  autocmd FileType scratch nnoremap <buffer> <leader>sc :q<CR>
augroup END

" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

let g:background_before_goyo = &background

function! s:goyo_enter()"
  let g:background_before_goyo = &background
  if has('gui_running')
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
endfunction

function! s:goyo_leave()
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

" ----------------------------------------------------------------------------
" Saynoara
" ----------------------------------------------------------------------------

let g:sayonara_confirm_quit = 1

" Delete current buffer without losing the split
" nnoremap <silent> <C-q> :bp\|bd #<CR>
nnoremap <silent><C-q> :Sayonara<CR>

nnoremap <M-w> <Esc>:Sayonara<CR>
nnoremap <M-W> <Esc>:Sayonara!<CR>
nnoremap <M-q> <Esc>:confirm qall<CR>
nnoremap <M-Q> <Esc>:qall!<CR>

imap <M-w> <Esc>:Sayonara<CR>
imap <M-W> <Esc>:Sayonara!<CR>
imap <M-q> <Esc>:confirm qall<CR>
imap <M-Q> <Esc>:qall!<CR>

nnoremap <silent><leader>q  :Sayonara<cr>
nnoremap <silent><leader>Q  :Sayonara!<cr>

" ----------------------------------------------------------------------------
" Startify
" ----------------------------------------------------------------------------

nnoremap <leader>st :Startify<cr>
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1

let g:startify_change_to_dir       = 0
let g:startify_fortune_use_unicode = 1
" let g:startify_update_oldfiles     = 1
" let g:startify_use_env             = 1

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
nnoremap <silent> <C-g>h :call FZFOpen(':History')<CR>
nnoremap <silent> <C-t> :call FZFOpen(':BTags')<CR>
" nnoremap <silent> <C-g>u :call FZFOpen(':Files ~/')<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" FZF Command History
cnoremap <silent> <C-r> call FZFOpen(':History:')<CR>

" Custom Fzf Commands
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))
nnoremap <silent> <C-g>d :call FZFOpen(':Cd ~')<CR>



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
" if exists('g:loaded_webdevicons')
"   call webdevicons#refresh()
" endif

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

" ---------------
"  @bs specials
" ---------------

" flash line and col briefly when jumping to a previous location
noremap <C-o> <C-o> :set cursorline <bar> set cursorcolumn <bar> call timer_start(300, { tid -> execute('set cursorline! <bar> set cursorcolumn!')})<cr>
" noremap <esc>jk :set cursorline <bar> set cursorcolumn <bar> call timer_start(300, { tid -> execute('set cursorline! <bar> set cursorcolumn!')})<cr>

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

    " 4 spaces indentation in python
    autocmd FileType python setlocal tabstop=4 shiftwidth=4

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
" cmd / to comment
map <C-_> gcc

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
" nnoremap <silent> <M-p> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" Moving within the vim :terminal
if has('nvim')
  nnoremap <leader>T      :vsplit +terminal<cr>
  tnoremap <esc>          <c-\><c-n>

  tnoremap <silent> <M-h> <C-\><C-n>:TmuxNavigateLeft<cr>
  tnoremap <silent> <M-j> <C-\><C-n>:TmuxNavigateDown<cr>
  tnoremap <silent> <M-k> <C-\><C-n>:TmuxNavigateUp<cr>
  tnoremap <silent> <M-l> <C-\><C-n>:TmuxNavigateRight<cr>
endif

  " Split edit your vimrc. Type space, v, r in sequence to trigger
    fun! OpenConfigFile(file)
      if (&filetype ==? 'startify')
        execute 'e ' . a:file
      else
        execute 'tabe ' . a:file
      endif
    endfun

    nnoremap <silent> <leader>vc :call OpenConfigFile('~/.vimrc')<cr>
    nnoremap <silent> <leader>vb :call OpenConfigFile('~/.vimrc.bundles')<cr>
    ""
  " Source (reload) your vimrc. Type space, s, o in sequence to trigger
    nnoremap <leader>so :source $MYVIMRC<cr>

  " VimPlug
   nnoremap <leader>pi :PlugInstall<CR>
    nnoremap <leader>pu :PlugUpdate<CR>
    nnoremap <leader>pc :PlugClean<CR>

  " change dir to current file's dir
  nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

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


  " @bs: should this be leader t?
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


