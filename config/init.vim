set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'frazrepo/vim-rainbow'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'vimwiki/vimwiki'
Plugin 'morhetz/gruvbox'
Plugin 'mbbell/undotree'
call vundle#end()
call glaive#Install()
filetype indent on
filetype plugin on

source $HOME/.config/nvim/plugin-config.vim
au BufReadPost *.cls set syntax=java
highlight Normal ctermbg=none
highlight NonText ctermbg=none
syntax on
