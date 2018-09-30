
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'jnurmine/Zenburn'
call vundle#end()

set encoding=utf-8

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

syntax on

colorscheme zenburn

set clipboard=unnamed

set backspace=2 " make backspace work like most other apps

" replace selection with the register contents
vnoremap <leader>p "_dP

autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal colorcolumn=70
highlight ColorColumn guibg=gray20

"## Allow saving of files as sudo when I forgot to start vim using sudo. (jessfraz)
cmap w!! w !sudo tee > /dev/null %

"## Fast saving
nmap <leader>w :w!<cr>

"## Fast exit
nmap <leader>q :wqa<cr>
