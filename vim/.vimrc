
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

