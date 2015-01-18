runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" general options
filetype plugin indent on
syntax on
colorscheme solarized
set background=dark
set encoding=utf-8
set fileformat=unix
"set modelines=0 " security issues
set undofile
set undodir=~/.vim/undo
set noswapfile
set backspace=indent,eol,start
let mapleader=" "
set autochdir
set wildmenu
set wildignore=*.pyc,*.jpg,*.gif,*.png
set autoread
set hidden
set laststatus=2

" graphical options
set scrolloff=5
set showmode
set showcmd
set ttyfast
set number
set mouse=
set noruler
set lazyredraw

" search options
set incsearch
set hlsearch
set showmatch
set smartcase
set ignorecase
set wrapscan
set gdefault
set matchtime=3
set magic

" tab options
set autoindent
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" list options
set list
set listchars=tab:▸\ 
set lcs+=trail:←
set lcs+=extends:»
set lcs+=precedes:«
set lcs+=nbsp:¬


" larger movements
map <c-j> <c-d>
map <c-k> <c-u>
map <c-l> g_
map <c-h> ^

nnoremap <up>     <c-y>
nnoremap <down>   <c-e>
nnoremap <silent> <left>  :bprev<cr>
nnoremap <silent> <right> :bnext<cr>

inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>


inoremap <f1> <esc>
nnoremap <f1> <esc>
vnoremap <f1> <esc>

" ex mode is useless, map it to something useful
map Q @q
map q: :q
" inoremap jj <esc>
nnoremap Y y$
nnoremap U <c-r>

" leader shortcuts
nmap <silent> <leader>h :noh<cr>
nmap <leader>ev :edit ~/.vimrc<cr>
nmap <leader>ez :edit ~/.zshrc<cr>
nmap <leader>w :w<cr>
nmap <leader><leader> V
nmap <silent> <leader>s :set spell!<cr>
nmap <silent> <leader>l :set nu!<cr>:set list!<cr>

" fast system clipboard pastes
vmap <leader>y "+y
vmap <leader>d "+d
vmap <leader>p "+p
vmap <leader>P "+P
nmap <leader>p "+p
nmap <leader>P "+P
nmap <leader>Y "+Y
nmap <leader>yy "+yy
nmap <leader>dd "+dd

" vim-easy-align plug binds
vmap <enter> <plug>(EasyAlign)
nmap <leader>a <plug>(EasyAlign)


" autocmds
augroup reloadvimrc
	au!
	au BufWritePost .vimrc source $MYVIMRC
augroup END

augroup notmpundos
	au!
	au BufReadPre /tmp/*     set noundofile
	" sudo -e makes random file names in /var/tmp, tracking undo state is useless
	au BufReadPre /var/tmp/* set noundofile
	" pass edits files in /dev/shm
	au BufReadPre /dev/shm/* set noundofile
augroup END

" tpope style markdown runtime detection
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

let g:airline_powerline_fonts = 1
function! AirlineThemePatch(palette)
	let a:palette.normal.airline_a   = [ '#ffffff', '#268bd2', 255, 33 ]
	let a:palette.insert.airline_a   = [ '#ffffff', '#859900', 255, 64 ]
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'
let g:airline#extensions#tabline#enabled = 1

" gui settings
if has('gui_running')
	set guicursor+=a:blinkon0 " cursor doesn't blink
	" remove menu bar, toolbar and scrollbar (in order)
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=l
	set guioptions-=L

	set guifont=Liberation\ Mono\ for\ Powerline\ 11

	set cursorline
endif
