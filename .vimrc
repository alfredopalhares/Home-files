"Comentar estas linhas
set nocompatible
filetype plugin indent on
syntax on
" Mostar o os plugins externos
filetype plugin on


set noexpandtab
set shiftwidth  =4
set softtabstop =0
set tabstop     =4

set hidden
set autoindent
set ruler
set showmode
set showcmd

set wildmenu
set wildmode    =list:longest,full

" Higlight searches while typing
set incsearch

" Higlight all search matches
set hlsearch


"Mostar o número de linhas
set number

" Tornar o encoding a UTF-8
set encoding=utf8


" Modificações do addon NERDTree
" Colocar o arranque automático
autocmd VimEnter * NERDTree
" Para não ficar sempre a janela do NERDTree activa quando se inicia\
autocmd VimEnter * wincmd p


" Correção do ficheiros SQL
"TODO: Vefificar a causa disto
:let g:omni_sql_no_default_maps = 1


" Activar as snippets de html para ficheiros html
" autocmd BufREad, BufNewFile *.php set ft=php.html
" Este também pordera funcionar
autocmd FileType php :let &ft.='.html'


