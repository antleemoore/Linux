set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-commentary'
Plugin 'leshill/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'indenthtml.vim'
Plugin 'tpope/vim-markdown'
Plugin 'groenewege/vim-less'
Plugin 'ctrlpvim/ctrlp.vim'
call vundle#end()
filetype plugin indent on 

let g:ctrlp_max_height = 30
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
noremap <leader>p :noh<cr>:CtrlP<cr>
noremap <leader>e :e 
noremap <leader>E :e ~/
nnoremap <leader>c <Plug>CommentaryLine
noremap <leader>v :noh<cr>:vnew<cr>:noh<cr>:CtrlP<cr>
noremap <leader>h :noh<cr>:new<cr>:noh<cr>:CtrlP<cr>
