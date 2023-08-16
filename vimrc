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
" timeout on keybindings can be low
set ttimeout
set ttimeoutlen=50

" graphical options
set background=dark
set termguicolors
set scrolloff=5
set showmode
set showcmd
set ttyfast
set number
set relativenumber
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

" vim-vinegar style ranger.vim map
nnoremap - :RangerWorkingDirectory<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <C-p> <cmd>Telescope git_files<cr>

nnoremap <leader>ds <cmd>Gdiff<cr>
nnoremap <leader>gc <cmd>Git commit --quiet<cr>
nnoremap <leader>gp <cmd>Git push --quiet<cr>
nnoremap <leader>gb <cmd>.GBrowse<cr>

" autocmds
augroup reloadvimrc
    au!
    au BufWritePost .vimrc source $MYVIMRC
    au BufWritePost vimrc source $MYVIMRC
    au BufWritePost init.vim source $MYVIMRC
    au BufWritePost init.nvim source $MYVIMRC
augroup END

augroup notmpundos
    au!
    au BufReadPre /tmp/*     set noundofile
    " sudo -e makes random file names in /var/tmp, tracking undo state is useless
    au BufReadPre /var/tmp/* set noundofile
    " pass edits files in /dev/shm
    au BufReadPre /dev/shm/* set noundofile
augroup END

" change xterm cursor style depending on mode
" insert mode, blinking thin line cursor
let &t_SI = "\e[5 q"
" normal mode, block cursor
let &t_EI = "\e[2 q"

let g:ranger_replace_netrw = 1

function! IsWSL()
    if has("linux")
        let lines = readfile("/proc/version")
        if lines[0] =~ "Microsoft"
            return 1
        endif
    endif
endfunction

if IsWSL()
    let g:netrw_browsex_viewer = "firefox.exe"
endif

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

if has("nvim")
    lua require('plugins')
    lua require('lsp')
endif
