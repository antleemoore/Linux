set nocompatible 
syntax on 

set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab 
set smarttab 
set shiftround
set autoindent
set smartindent
set relativenumber
set nobackup
set nowritebackup
set noswapfile
set hidden
set autoread
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
set virtualedit+=block

let mapleader = " "

nnoremap ; :
vnoremap ; :
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-left> <C-w><
nnoremap <C-right> <C-w>>
nnoremap <C-up> <C-w>+
nnoremap <C-down> <C-w>-
noremap <leader>a :e .
noremap <leader>A :e ~/.
noremap <leader>e :e 
noremap <leader>E :e ~/
nnoremap <leader>s :noh<cr>:source %<cr>
nnoremap / /\v
vnoremap / /\v
noremap <leader>x :noh<cr>:call clearmatches()<cr>
noremap <leader>w :noh<cr>:w<cr>
nnoremap <leader><leader> <c-^>
nnoremap <leader>D :noh<cr>:bd<cr>
nnoremap <leader>W :noh<cr>:bw<cr>
noremap j gj
noremap k gk
