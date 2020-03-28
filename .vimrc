"Vim gittoso +-+-+"
nnoremap © :!git commit -a -m "
nnoremap π :!git push<CR>
set updatetime=1000

"NERDTree"
let g:NERDTreeNodeDelimiter = "\u00a0"

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)
execute pathogen#infect()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set relativenumber
nnoremap <F3> :NumbersToggle<CR>

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set vb t_vb=

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set cursorcolumn
set cursorline
set scrolloff=3
set backspace=indent,eol,start
runtime! macros/matchit.vim

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Mouse
set mouse=a

" Python
nnoremap ® :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap © :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" Indentline
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

" Vertical column on python
if (&ft=='py')
    set colorcolumn=73
    if has('gui_running')
        highlight OverLength guibg=#592929
        match OverLength /\%>79v.\+/
    else
        match ErrorMsg '\%>79v.\+'
    endif
endif
" never mind fuck the system (the if fails idk why)
set colorcolumn=73
match ErrorMsg '\%>79v.\+'


" Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" EasyMotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
map <leader><space> :let @/=''<cr> " clear search

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

let g:enable_bold_font = 1

" NERDtree
map <S-l> :tabn<CR>
map <S-h> :tabp<CR>

" LATEX Stuff
"
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

autocmd BufEnter *.tex set tw=72
autocmd BufEnter *.tex set spell spelllang=en_us

let g:Imap_UsePlaceHolders = 0

" Bind F5 to save file if modified and execute python script in a buffer.
nnoremap <silent> <D-r> :call SaveAndExecutePython()<CR>
vnoremap <silent> <D-r> :<C-u>call SaveAndExecutePython()<CR>

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python3 " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction

" Color scheme (terminal)
syntax enable
colorscheme dracula
highlight Normal ctermbg=NONE

" Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
