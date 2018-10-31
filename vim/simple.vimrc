"==============WIP=======================
" Author:  zloop
" Email: zloopk09@gmail.com
" Sections:
"       -> Basic Settings
"       -> Initial Plugins
"       -> General Settings
"       -> UI Settings
"       -> Theme
"       -> keybindings
"       -> Functions
"       -> Plugin Settings
"==============WIP=======================

"==========================================
" Basic Settings
"==========================================
" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

"==========================================
" General Settings
"==========================================
" For plugins to load correctly
filetype plugin indent on

" Sets how many lines of history VIM has to remember
set history=1000

" Set to auto read when a file is changed from the outside
set autoread

" Pick a leader key
let mapleader = ','

" Security
set modelines=0

" Enable hidden buffers
set hidden

" Directories for swp files
set nobackup
set noswapfile
set nowb
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Encoding
set encoding=utf-8

" Make backspace work as you would expect
set backspace=indent,eol,start  
set whichwrap+=<,>,h,l

" Faster redrawing
set ttyfast
" redraw only when we need to.
set lazyredraw

set autoindent
set smartindent
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
" >> indents to next multiple of 'shiftwidth'
set shiftround

" Show as much as possible of the last line
set display+=lastline

" Display tabs and trailing spaces visually
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Open new windows right of the current window.
set splitright
" Open new windows below the current window.
set splitbelow

" For regular expressions turn magic on
set magic

"==========================================
" UI Settings
"==========================================
" Enable syntax highlighting
syntax enable

set mouse=a 
set selection=exclusive 
set selectmode=mouse,key

" highlight matching parenthenesses
set showmatch

"Always show current position
set ruler

" Show line numbers
set number

" autoscroll when you get within x of boundary
set scrolloff=6

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Height of the command bar
set cmdheight=2

" Turn on the Wild menu
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrapscan

" change the terminal's title
set title

" Always show statusline
set laststatus=2
" Show current mode in command-line.
set showmode
" Show already typed keys when more are expected.
set showcmd

" highlight current line
set cursorline
set nocursorcolumn

" set iskeyword+=_,$,@,%,#,-

"Don't wrap lines
set wrap
"Wrap lines at convenient points
set linebreak
set showbreak=↳
fun! ToggleShowBreak()
  if &showbreak == ''
    set showbreak=↳
  else
    set showbreak=
  endif
endfun
nmap <leader>b :call ToggleShowBreak()<CR>