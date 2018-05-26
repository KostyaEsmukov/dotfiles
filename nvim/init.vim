
call plug#begin()

"## IDE-alike
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'sheerun/vim-polyglot' " collection of plugins for many programming languages
Plug 'xolox/vim-easytags'  " tags generator
Plug 'xolox/vim-misc' " required by /\
Plug 'w0rp/ale' " linter

"## Files navigation + VCS
Plug 'scrooloose/nerdtree'
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

"## powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"## markdown
Plug 'iamcco/markdown-preview.vim'

"## editor
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'tpope/vim-surround' " replace surroundings: quotes, etc
Plug 'tpope/vim-commentary' " block comment
Plug 'christoomey/vim-sort-motion' " gs (in visual) - sort lines

" TODO:
"??? Plug 'alfredodeza/coveragepy.vim'
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

"## terminal
" tnoremap <Esc> <c-\><c-n>

"## line swaps
" map <D-Up> kddpk
" map <D-Down> ddp

"## delete w/o copying. leader is \.
nnoremap <leader>d "_d
vnoremap <leader>d "_d

"## replace selection with the register contents
vnoremap <leader>p "_dP

"# colors
colorscheme kalisi
set background=dark

"# autosave changes
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
:autocmd FocusLost * silent! wa  " untitled buffers are silently ignored
set autowriteall

"# autoreload changed files
" Courtesy of https://unix.stackexchange.com/a/383044
" set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" https://askubuntu.com/a/825599
"autocmd CursorHold,CursorHoldI * call NERDTreeFocus() | call g:NERDTree.ForCurrentTab().getRoot().refresh() | call g:NERDTree.ForCurrentTab().render() | wincmd p


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
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = '%{strftime("%a %d %b %H:%M")}'

"## NERDTree
map <C-n> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif " http://superuser.com/a/474298
let NERDTreeIgnore=['\.pyc$', '\~$', '^__pycache__$', '^\.DS_Store$', '\.swp$']

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

"# ALE

let g:ale_fixers = {
\    'python': ['isort'],
\}

nmap <F8> <Plug>(ale_fix)

"# guides
set colorcolumn=80,90,100 " vertical line
highlight ColorColumn guibg=gray20

"# mark bad whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd InsertEnter,InsertLeave * match BadWhitespace /\s\+$/

"# mark bad words

" https://css-tricks.com/words-avoid-educational-writing/
" https://twitter.com/jesstelford/status/992757640315858946
highlight BadEduWords ctermbg=red guibg=darkred
autocmd InsertEnter,InsertLeave * match BadEduWords /\c\<\(obviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy\|indeed\)\>/


