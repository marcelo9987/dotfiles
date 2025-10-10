" .vimrc

set history=1000
let &t_ut='' "Para que las configuraciones no hagan cosas raras con el color

set autoindent "Identar las lineas de forma automática
set expandtab
set shiftwidth=4
set softtabstop=4

set encoding=utf-8

set scrolloff=10
set relativenumber
set nu rnu

"sobre los cargados en pantalla y terminales:
set lazyredraw
set ttyfast

"Agrupaciones de ({etc
set showmatch

"detectar tipo de archivo automáticamente
syntax on
filetype plugin indent on

" plugins 
source ~/plugins.vim

