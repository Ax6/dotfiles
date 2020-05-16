"""""""\   Base   \"""""""

" Don't try to be vi compatible
set nocompatible

" Turn on syntax highlighting
syntax on

" Show relative line numbers
set relativenumber

" Automatic indentation as you type
set autoindent

" Invoke default indentation settings
filetype indent on

" Invoke plugins based on file type
filetype plugin on

" 80 char line forever
set colorcolumn=80

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set vb t_vb=

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set formatoptions=tcqrn1
set expandtab
set noshiftround
" Default 4 spaces indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
" For JS we want 2 whitespaces
autocmd FileType javascript set ts=2 sw=2 sts=2

" Nice searching
set hlsearch
set incsearch
set ignorecase
set smartcase
map <leader><space> :let @/=''<cr> " clear search

" Splits
set splitbelow
set splitright

"""""""\ Pathogen \"""""""
execute pathogen#infect()


"""""""\ Plugins \"""""""
"Vim fast update +-+-+"
set updatetime=1000

"NERDTree"
let g:NERDTreeNodeDelimiter = "\u00a0"

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''


"""""""\  Fixing  \"""""""

" Fix dracula colors on mac
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None

" Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Latex plugin for win32 users 
set shellslash
