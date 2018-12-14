
call plug#begin()

"## IDE-alike
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'sheerun/vim-polyglot' " collection of plugins for many programming languages
Plug 'w0rp/ale' " linter
Plug 'alfredodeza/coveragepy.vim'  " coverage.py integration. :Coveragepy show
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'plytophogy/vim-virtualenv'  " :VirtualEnv* commands

"## Files navigation + VCS
Plug 'scrooloose/nerdtree', { 'commit': '8d005db' }
Plug 'ryanoasis/vim-devicons' " file icons
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'Xuyuanp/nerdtree-git-plugin' " shows git status in nerdtree
Plug 'Aldlevine/nerdtree-git-plugin' " fork of the above, which colors whole line.  https://github.com/Xuyuanp/nerdtree-git-plugin/pull/79
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " see also: kien/ctrlp.vim
Plug 'airblade/vim-rooter' " changes cwd to git root
Plug 'airblade/vim-gitgutter' " shows git diff in the gutter
Plug 'tpope/vim-fugitive' " git wrapper (:Gblame)
Plug 'dkprice/vim-easygrep' " \vV - search word under cursor
Plug 'mileszs/ack.vim' " search with ack
Plug 'ctrlpvim/ctrlp.vim' " C-e alike of Intellij: buffers list, MRU, fzf
Plug 'ruanyl/vim-gh-line' " \gh and \gb -- copies URL to git's remote origin site for the current line

"## powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"## markdown
Plug 'iamcco/markdown-preview.vim'

"## editor
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'tpope/vim-surround' " replace surroundings: quotes, etc
Plug 'tpope/vim-commentary' " gc (in visual) - block comment
Plug 'christoomey/vim-sort-motion' " gs (in visual) - sort lines
Plug 'MattesGroeger/vim-bookmarks'  " toggle line bookmarks. mm - toggle.

let g:swap_no_default_key_mappings = 1  " gs -- conflicts with vim-sort-motion
Plug 'machakann/vim-swap'  " swap comma-delimited items with >,

" TODO:
"Plug 'vim-scripts/indentpython.vim'
"Plug 'tmhedberg/SimpylFold'
"nnoremap <space> za

call plug#end()

"# remaps
" noremap <space> :
nnoremap ; :

"## window cycling
nnoremap <tab> <c-w>
nnoremap <tab><tab> <c-w><c-w>

"## delete w/o copying. leader is \.
nnoremap <leader>d "_d
vnoremap <leader>d "_d

"## replace selection with the register contents
vnoremap <leader>p "_c<esc>p

"## yank the word under the cursor
nnoremap <leader>y yiw

"## show buffers (like Ctrl+E in Intellij)

" https://vi.stackexchange.com/a/2187
" nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>
nnoremap <C-e> :CtrlPBuffer<CR>

"## copy the current relative path to clipboard

nmap cp :let @+ = expand("%")<cr>

"## arguments swap

nmap <, <Plug>(swap-prev)
nmap >, <Plug>(swap-next)

"## Close quickfix easily
nnoremap <leader>a :cclose<CR>
"## Close preview easily
nnoremap <leader>z :pclose<CR>

"## Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

"## Fast saving
nmap <leader>w :wa!<cr>

"## Fast exit
nmap <leader>q :wqa<cr>

"## Center the screen
nnoremap <space> zz

"# colors
colorscheme kalisi
set background=dark

"# autosave changes
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
autocmd FocusLost * silent! wa  " untitled buffers are silently ignored
set autowriteall

"# autoreload changed files
" Courtesy of https://unix.stackexchange.com/a/383044
" set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" https://askubuntu.com/a/825599
"autocmd CursorHold,CursorHoldI * call NERDTreeFocus() | call g:NERDTree.ForCurrentTab().getRoot().refresh() | call g:NERDTree.ForCurrentTab().render() | wincmd p

" Show relative line numbers in a focused buffer
autocmd WinEnter,FocusGained * :setlocal number relativenumber
autocmd WinLeave,FocusLost   * :setlocal number norelativenumber

"# editor
set cursorcolumn cursorline " show cursor position in a cross-like fashion

set cb=unnamedplus " enable system clipboard. Don't forget to enable the 'Apps may access clipboard' in the iTerm2 settings

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set nowrap

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

" Enable mouse integration
set mouse=a

" case insensitive search
set ignorecase
set smartcase

" spell checking
set spell spelllang=en_us

" more natural splitting algo
set splitbelow
set splitright

set encoding=utf-8

set list " show tabs

"# Plugins config

"## Airline
set termguicolors " fix powerline arrows. https://github.com/rogual/neovim-dot-app/issues/215
let g:airline_powerline_fonts = 1
"https://github.com/vim-airline/vim-airline/wiki/Screenshots
"let g:airline_theme='murmur'
let g:airline_section_b = ''  " Hide git status

"## NERDTree
map <C-n> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif " http://superuser.com/a/474298
let NERDTreeIgnore=[
            \ '\.pyc$', '\~$', '^__pycache__$', '^\.DS_Store$', '\.swp$', '\.git$',
            \ '^\.pytest_cache$', '^\.mypy_cache$', '^\.coverage$', '^\.idea$',
            \ ]
let NERDTreeShowHidden=1

" open nerdtree when vim is started without a file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Enable folder icons in NerdTree
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

let g:NERDTreeGitStatusNodeColorization = 1  "enables colorization
let g:NERDTreeGitStatusWithFlags = 1  "enables flags, (may be default), required for colorization
highlight link NERDTreeGitStatusModified Tag  "custom color

"## vim rooter
let g:rooter_silent_chdir = 1

"## FZF
map <S-z> :FZF<CR>
let $FZF_DEFAULT_COMMAND= 'ag -g ""' " ignore files listed in .gitignore

"## vim-gitgutter
set updatetime=250 " reduce update delay
let g:gitgutter_diff_base = 'HEAD'  " include staged changes in diff

"## vim-fugitive

" \ga to stage the current file
map <leader>ga :Gwrite<CR>

"## vim-bookmark

" Fix conflicts with NERDTree
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

"# Trim trailing whitespaces
" http://vi.stackexchange.com/a/456

fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

" http://stackoverflow.com/a/10410590
autocmd BufWritePre * if index(['markdown'], &ft) < 0 | :call TrimWhitespace()

"# ack
" don't jump to the first result
cnoreabbrev Ack Ack!
nnoremap <S-x> :Ack!<Space>
" fix perl warnings
let $LANG= 'en_US.UTF-8'
let $LC_ALL= 'en_US.UTF-8'

"# Python virtualenvs

let g:python_host_prog = $WORKON_HOME . '/neovim_py2/bin/python'
let g:python3_host_prog = $WORKON_HOME . '/neovim_py3/bin/python'

"# Polyglot
syntax on

let g:ansible_unindent_after_newline = 1
let g:ansible_extra_keywords_highlight = 1
let g:polyglot_disabled = ['yaml']  " fix ansible-vim being shadowed by yaml-plugin

" Fix an issue with sql files:
" SQLComplete: The debxt plugin must be loaded for dynamic SQL completion
let g:omni_sql_no_default_maps = 1

"# ALE

let g:ale_fixers = {
\    'python': ['black', 'isort'],
\}

"# Language Server

"## enable auto-complete
let g:deoplete#enable_at_startup = 1

" Attempt to fix the annoying change in the completion list after the
" delayed response from the LS.
" See https://github.com/autozimu/LanguageClient-neovim/issues/609
call deoplete#custom#option('auto_complete_delay', 200)

let g:LanguageClient_diagnosticsList = 'Disabled'

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nmap <F8> <Plug>(ale_fix)

"# g++

map <F9> :w <CR> :!g++ % -o %< -std=c++14 <CR>

"# editorconfig

let g:EditorConfig_disable_rules = ['max_line_length']

"# vim-gh-line

let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

"# ctags

set tags=.tags
" Run `pyctags` to regenerate ctags (defined in the zshrc).

" C-] -- navigate to definition.
" C-o -- go back.
" g] -- list definitions.

"# Rulers
let &colorcolumn="72,80,".join(range(90,400),",")  " mark 72 (PEP-8 docs), 80 (PEP-8), 90+
highlight ColorColumn guibg=gray20

"# mark bad whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd InsertEnter,InsertLeave * match BadWhitespace /\s\+$/

"# mark bad words

" https://css-tricks.com/words-avoid-educational-writing/
" https://twitter.com/jesstelford/status/992757640315858946
highlight BadEduWords ctermbg=red guibg=darkred
autocmd InsertEnter,InsertLeave * match BadEduWords /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\|indeed\)\>/


