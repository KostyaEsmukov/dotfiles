
call plug#begin()

"## IDE-alike
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"## Files navigation + VCS
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " see also: kien/ctrlp.vim
Plug 'airblade/vim-rooter' " changes cwd to git root
Plug 'airblade/vim-gitgutter'
Plug 'dkprice/vim-easygrep'
Plug 'mhinz/vim-startify' " start screen, session manager

"## powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"## etc
Plug 'editorconfig/editorconfig-vim'

" TODO:
"Plug 'neomake/neomake' " linter
"??? Plug 'alfredodeza/coveragepy.vim'
"
"Plug 'vim-scripts/indentpython.vim'
"
"Plug 'tmhedberg/SimpylFold'
"nnoremap <space> za

call plug#end()

"# remaps
" noremap <space> :

"## window cycling
nnoremap <tab> <c-w>
nnoremap <tab><tab> <c-w><c-w>

"## terminal
tnoremap <Esc> <c-\><c-n>

"# colors
colorscheme kalisi
set background=dark

"# editor
set colorcolumn=80 " vertical line

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

set splitbelow
set splitright

set encoding=utf-8

set list " show tabs

"# mark bad whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile * match BadWhitespace /\s\+$/

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

"## vim rooter
let g:rooter_silent_chdir = 1

"## FZF
map <S-z> :FZF<CR>
let $FZF_DEFAULT_COMMAND= 'ag -g ""'

"## vim-gitgutter
set updatetime=250 " reduce update delay

"# Trim trailing whitespaces
" http://vi.stackexchange.com/a/456

fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

autocmd BufWritePre *.py,*.ts,*.js,*.h,*.c,*.hpp,*.cpp,*.rb,*.java,*.html,*.css,*.sh :call TrimWhitespace()


