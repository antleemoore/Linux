au BufReadPost,BufNewFile *.wiki syntax on

let g:vimwiki_list = [{'path': '~/Documents/notes_vw'}]
" let g:rainbow_active = 1
" set termguicolors
" let g:rainbow_load_separately = [
"             \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"             \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
"             \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"             \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"             \ ]

" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
" let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
let g:ctrlp_max_height = 10
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:coc_global_extensions = ['coc-json', 'coc-pairs', 'coc-html', 'coc-python', 'coc-css', 'coc-clangd', 'coc-tsserver', 'coc-eslint', 'coc-snippets']
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:neovide_refresh_rate=144
let g:neovide_no_idle=v:true
let g:neovide_transparency=0.90
let g:neovide_cursor_animation_length=0.01

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,arduino,java AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue,javascript AutoFormatBuffer prettier
augroup END


inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><CR>  pumvisible() ? "<Right>" : "\<CR>"
noremap <leader>p :noh<cr>:CtrlP<cr>
nnoremap <leader>c <Plug>CommentaryLine
noremap <leader>v :noh<cr>:vnew<cr>:noh<cr>:CtrlP<cr>
noremap <leader>h :noh<cr>:new<cr>:noh<cr>:CtrlP<cr>

" OLD PLUGINS/COMMANDS/REMAPS
" Plugin 'groenewege/vim-less'
" Plugin 'leshill/vim-json'
" Plugin 'pangloss/vim-javascript'
" Plugin 'indenthtml.vim'
" Plugin 'tpope/vim-markdown'
" Plugin 'zhamlin/tiler.vim'
" noremap <leader>w :noh<cr>:Prettier<cr>:noh<cr>:w<cr>
" nnoremap <leader>n :noh<cr>:TilerNew<cr>:noh<cr>:CtrlP<cr>
" nnoremap <leader>d :noh<cr>:TilerClose<cr>
" nnoremap <leader>m :noh<cr>:TilerFocus<cr>
" nnoremap <leader>r :noh<cr>:TilerReorder<cr>
" nnoremap ZZ ZZ:noh<cr>:TilerReorder<cr>
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
" autocmd FileType java AutoFormatBuffer google-java-format
" autocmd FileType python AutoFormatBuffer yapf
" Plugin 'flazz/vim-colorschemes'
" colorsheme gruvbox
