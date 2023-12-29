set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,cp932,euc-jp,sjis
set fileformat=unix
set ambiwidth=double

set nobackup
set noswapfile
set autoread
set hidden
set ttyfast

set number
set cursorline
set smartindent
set showmatch

noremap j gj
noremap k gk
noremap <down> gj
noremap <up> gk

syntax enable

set expandtab
set tabstop=2
set shiftwidth=2

set ignorecase
set smartcase

set incsearch
set wrapscan
set hlsearch

nmap <Esc><Esc> :nohlsearch<CR><Esc>

noremap! <C-?> <C-h>

call plug#begin()
Plug 'nordtheme/vim'
call plug#end()

colorscheme nord

