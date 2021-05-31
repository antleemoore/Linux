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
Plugin 'zhamlin/tiler.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
call vundle#end()
filetype plugin indent on 

let g:ctrlp_max_height = 10
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:coc_global_extensions = ['coc-json', 'coc-prettier', 'coc-pairs', 'coc-java', 'coc-html', 'coc-python', 'coc-css', 'coc-clangd', 'coc-tsserver', 'coc-eslint', 'coc-sh', 'coc-snippets']
command! -nargs=0 Prettier :CocCommand prettier.formatFile
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><CR>  pumvisible() ? "\<C-right>" : "\<CR>"
noremap <leader>p :noh<cr>:CtrlP<cr>
nnoremap <leader>c <Plug>CommentaryLine
noremap <leader>v :noh<cr>:vnew<cr>:noh<cr>:CtrlP<cr>
noremap <leader>h :noh<cr>:new<cr>:noh<cr>:CtrlP<cr>
noremap <leader>w :noh<cr>:Prettier<cr>:noh<cr>:w<cr>
nnoremap <leader>n :noh<cr>:TilerNew<cr>:noh<cr>:CtrlP<cr>
nnoremap <leader>d :noh<cr>:TilerClose<cr>
nnoremap <leader>m :noh<cr>:TilerFocus<cr>
nnoremap <leader>r :noh<cr>:TilerReorder<cr>
nnoremap ZZ ZZ:noh<cr>:TilerReorder<cr>