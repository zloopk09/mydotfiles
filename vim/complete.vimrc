"========================================
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
" Initial Plugins
"==========================================
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" UI
" Plug 'connorholyday/vim-snazzy'
Plug 'morhetz/gruvbox'
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'luochen1990/rainbow'

" file
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'

" edit
Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/vim-easy-align'
" Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
" Plug 'vim-syntastic/syntastic'


" Initialize plugin system
call plug#end()

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

" share system clipboard
set clipboard=unnamed

" Enable hidden buffers
set hidden

" Directories for swp files
set nobackup
set noswapfile
set nowb
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/undodir > /dev/null 2>&1
  set undodir=~/.vim/undodir
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
" indents to next multiple of 'shiftwidth'
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
syntax on

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
set scrolloff=4

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
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                       " Go static files
set wildignore+=go/bin                       " Go bin files
set wildignore+=go/bin-vagrant               " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

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
" set textwidth=79
set formatoptions=qrn1
"Wrap lines at convenient points
set linebreak
set showbreak=↳

"==========================================
" theme
"==========================================
set termguicolors
set guifont=Source\ Code\ Pro\ 15
set background=dark
:silent! colorscheme gruvbox

"==========================================
" keybindings
"==========================================
" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Fast quit
nmap <Leader>q :q<CR>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Go to home and end using capitalized directions
noremap 1 ^
noremap 0 $

" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Buffer prev/next
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>
" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" Center the screen
nnoremap <space> zz

" Act like D and C
" nnoremap Y yw

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
nmap <TAB> :tabn<CR>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" F8 显示可打印字符开关
nnoremap <F8> :set list! list?<CR>

"==========================================
" Functions
"==========================================
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" F2 行号开关
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
" F3 相对绝对行号切换
nnoremap <F3> :call NumberToggle()<CR>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"==========================================
" plugin settings
"==========================================
" --- NERDTree ----
" let g:nerdtree_tabs_open_on_console_startup = 0
" let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=35
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']
" F5 开关
map <F5> :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" --- NERDCommenter ---
let g:NERDSpaceDelims=1

" --- majutsushi/tagbar ---
" F6 开关
nmap <F6> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1

" --- mbbill/undotree ---
" F7 开关
nnoremap <F7> :UndotreeToggle<cr>

" --- vim-airline ---
" --- vim-airline-theme ---
" let g:airline_theme='gruvbox'

" --- ctrlpvim/ctrlp.vim ---
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>m :CtrlPMRU<CR>
map <leader>b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" --- bronson/vim-trailing-whitespace ---
map <leader>f :FixWhitespace<cr>

" --- junegunn/vim-easy-align ---
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" --- Yggdroot/indentLine ---
let g:indentLine_color_term = 238

" --- luochen1990/rainbow ---
"0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
