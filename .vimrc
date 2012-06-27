" Alfredo's vim file
set nocompatible
" Set the encoding to UTF-8
set encoding=utf8
filetype plugin indent on
syntax on
filetype plugin on

" Tab spacing
set tabstop=2
set shiftwidth=2
set expandtab


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

" Set the Nevrland2-Darker colorsheme
colorscheme neverland2-darker

" Start all "IDE" tools
function Ide()
    " Settings for the NERDTree plugin
    " Add to the Start up 
    NERDTree
    " Change tho editing windows 
    wincmd p

    " SQL files correction
    "TODO: Verify the cause 
    :let g:omni_sql_no_default_maps = 1

    " Enable Tagbar
    TagbarToggle
endfunction

" Map Ide to F9
nmap <F9> :call Ide() <cr>

" Higlight trailing whitespaces
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/
