filetype plugin on
filetype plugin indent on
execute pathogen#infect()
syntax enable
set background=dark
colorscheme koehler
let g:solarized_termcolors=256

set bs=2
set nocompatible
set ts=2
set pastetoggle=<F2>
set number
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=79
set autoindent
set mouse=a
set hls is
set encoding=utf-8

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
   
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
   
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
   
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

