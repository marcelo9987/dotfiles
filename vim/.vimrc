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

" Configurar clangd
if executable('clangd')
  augroup lsp_c
    autocmd!
    autocmd FileType c,cpp call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd']},
          \ 'whitelist': ['c', 'cpp'],
          \ })
  augroup END
endif

"asyncomplete
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

let g:asyncomplete_auto_popup = 0
" let g:asyncomplete_popup_delay = 200

" inoremap <expr> <S-Tab>   pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : 
            \ asyncomplete#force_refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

set completeopt=menuone,noinsert,noselect


" plugins 
source ~/plugins.vim

