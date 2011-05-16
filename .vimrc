" Alfredo's vim file
set nocompatible
" Set the encoding to UTF-8
set encoding=utf8
filetype plugin indent on
syntax on
filetype plugin on

" Tab spacing
set noexpandtab
set shiftwidth  =4
set softtabstop =4
set tabstop     =8

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

" Show the line numbers
set number

" Settings for the NERDTree plugin
" Add to the Start up 
autocmd VimEnter * NERDTree
" Cahnge tho editing windows 
autocmd VimEnter * wincmd p

" SQL files correctio 
"TODO: Verify the cause 
:let g:omni_sql_no_default_maps = 1

" Active PHP snippets to *.html files 
autocmd FileType php :let &ft.='.html'

" Set the Nevrland2-Darker colorsheme
colorscheme neverland2-darker
