set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'leshill/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'indenthtml.vim'
Plugin 'tpope/vim-markdown'
Plugin 'groenewege/vim-less'

call vundle#end()
filetype plugin indent on 
syntax on 

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
noremap <leader>v <C-w>v
noremap <leader>h <C-w>s
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap / /\v
vnoremap / /\v
noremap <leader>x :noh<cr>:call clearmatches()<cr>
nnoremap <leader><leader> <c-^>
noremap j gj
noremap k gk
nnoremap <leader>c <Plug>CommentaryLine

let g:ctrlp_max_height = 30
let g:ctrlp_show_hidden = 1
