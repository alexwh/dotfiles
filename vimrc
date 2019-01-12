runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" general options
filetype plugin indent on
syntax on
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,shift-jis,latin1
set fileformat=unix
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
set nojoinspaces

" graphical options
colorscheme gruvbox
set background=dark
set scrolloff=5
set showmode
set showcmd
set ttyfast
set number
set relativenumber
set mouse=
set noruler
set lazyredraw
set list
set listchars=tab:▸\ ,trail:←,nbsp:¬

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
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4


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
nnoremap Y y$
nnoremap U <c-r>
nmap S i<cr><esc>d^==kg_lD

" leader shortcuts
nmap <silent> <leader>h :noh<cr>
nmap <leader>ev :edit ~/.vimrc<cr>
nmap <leader>ez :edit ~/.zshrc<cr>
nmap <leader>w :w<cr>
nmap <leader><leader> V
nmap <silent> <leader>s :set spell!<cr>
nmap <silent> <leader>l :set nu!<cr>:set rnu!<cr>:set list!<cr>
nmap <silent> <leader>u :UndotreeToggle<cr>
nmap <silent> <leader>r :RainbowLevelsToggle<cr>

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

" gofmt enforces tabs
autocmd BufNewFile,BufReadPost *.go set noexpandtab

" plugin settings
let g:airline_powerline_fonts = 1
function! AirlineThemePatch(palette)
	let a:palette.normal.airline_a   = [ '#ffffff', '#268bd2', 255, 33 ]
	let a:palette.insert.airline_a   = [ '#ffffff', '#859900', 255, 64 ]
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

let g:flake8_show_in_file=1

let g:ranger_replace_netrw = 1

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '➜'
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 0
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\   'python': ['flake8', 'isort'],
\}

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
