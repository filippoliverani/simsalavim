" vim-plug
"
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'epeli/slimux'
Plug 'kien/rainbow_parentheses.vim'
Plug 'wlangstroth/vim-racket'

call plug#end()

" General Config

scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set autoread
set backspace=indent,eol,start
set cursorline
set ruler                   " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set showcmd
set hidden
set history=1000
set laststatus=2
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
set lazyredraw
set number
set showcmd
set showmatch
set showmode
set title
set ttyfast
set visualbell
set t_vb=
set nowrap
set noesckeys
set formatoptions-=or
runtime macros/matchit.vim

" Leader

let mapleader = ","
let maplocalleader = "\\"

" Search Settings

set incsearch
set hlsearch
set ignorecase
set smartcase

" Persistent undo and backups

silent !mkdir -p ~/.vim/tmp/undo > /dev/null 2>&1
silent !mkdir -p ~/.vim/tmp/backup > /dev/null 2>&1
silent !mkdir -p ~/.vim/tmp/swap > /dev/null 2>&1

set undodir=~/.vim/tmp/undo
set undoreload=10000
set undofile
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

" Indentation

filetype plugin indent on
set autoindent
set smarttab
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set matchpairs+=<:>
set pastetoggle=<F12>
set expandtab
set shiftround
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4

set list listchars=tab:»·,trail:·

" Completion

set wildmode=list:longest,full
set wildmenu

" Colors

syntax enable
set background=dark
au BufNewFile,BufRead Jenkinsfile setf groovy

let g:solarized_termcolors=16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
"colorscheme solarized

" Scrolling

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

"" Convenience mappings

" Indentation

map <leader>i mmgg=G`m

" Simple save

map <C-s> <Esc>:wa<CR>
imap <C-s> <Esc>:wa<CR>

" Make capitals behave

nnoremap D d$
nnoremap Y y$
command! Q q
command! Qa qa
command! W w
command! Wa wa

" Move on displayed lines

noremap j gj
noremap k gk

" Easy buffer navigation

noremap <C-h>     <C-w>h
noremap <C-j>     <C-w>j
noremap <C-k>     <C-w>k
noremap <C-l>     <C-w>l
noremap <leader>v <C-w>v

" Easy tab navigation

map <S-H> gT
map <S-L> gt

" Substitute

nnoremap <leader>s :%s//<left>

" Clear search highlighting

map <C-l> :nohlsearch<CR>

" Disable help key

noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Disable arrow keys

inoremap  <Up>     <NOP>
noremap   <Up>     <NOP>
inoremap  <Down>   <NOP>
noremap   <Down>   <NOP>
inoremap  <Left>   <NOP>
noremap   <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Right>  <NOP>
noremap   <Right>  <NOP>

" Disable useless stuff

map Q <NOP>
map K <NOP>

" Change Working Directory to that of the current file

cmap cwd lcd %:p:h

" Visual shifting (does not exit Visual mode)

vnoremap < <gv
vnoremap > >gv

" Quickly edit/reload the vimrc file

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Save as root even if not root

cmap w!! %!sudo tee > /dev/null %

" Tags

set tags=.git/tags,./tags,~/.vim/tags,~/.tags

" Paste

map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>

"" Plugins settings

" NERD Tree

map <C-e> :NERDTreeToggle<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

autocmd FileType *
      \ if &omnifunc != '' |
      \   silent! all SuperTabChain(&omnifunc, "<c-p>") |
      \   silent! all SuperTabSetDefaultCompletionType("<c-x><c-u>") |
      \ endif

" ack and grep

map <leader>a :Ack!<space>
let g:ackprg = 'rg --vimgrep'
set grepprg=rg\ --vimgrep

" fzf

map <C-p> :Files<CR>
nmap <Leader>o :Files<CR>

" Slimux

map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>c :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>

let g:slimux_scheme_keybindings=1

" Powerline

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

set laststatus=2
set noshowmode
