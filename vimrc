set nocompatible

" Vundle

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles

Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mileszs/ack.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle "tomtom/tlib_vim"
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'tpope/vim-markdown'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'rodjek/vim-puppet'

" General Config

scriptencoding utf-8
set encoding=utf-8
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
set statusline+=%{fugitive#statusline()} "  Git Hotness
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

if version >= 703
    set undodir=~/.vim/tmp/undo
    set undoreload=10000
    set undofile
endif

set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

" Indentation

filetype plugin indent on
set autoindent
set smarttab
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
set matchpairs+=<:>                " match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane
set expandtab
set shiftround
autocmd FileType python,ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
"autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

set list listchars=tab:»·,trail:·

" Completion

set wildmode=list:longest,full
set wildmenu

" Colors

set t_Co=16
syntax enable
set background=light
colorscheme solarized
call togglebg#map("<F2>")

" Scrolling

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

"" Convenience mappings

" Make capitals behave
nnoremap D d$
nnoremap Y y$

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

set tags=./tags,~/.vim/tags,~/.tags

"" Plugins settings

" NERD Tree

map <C-e> :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>

let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40

" Completion

set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

let g:SuperTabLongestEnhanced = 1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

autocmd FileType *
            \ if &omnifunc != '' |
            \   call SuperTabChain(&omnifunc, "<c-p>") |
            \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
            \ endif

" Ack

map <leader>a :Ack!<space>

" CtrlP

let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {'dir':  'vendor/bundler$\|\.git$\|\.hg$\|\.svn$', 'file': '\.exe$\|\.so$\|\.dll$' }

map <C-t> :CtrlPTag<CR>

" Slime

let g:slime_target = "tmux"
let g:slime_paste_file = tempname()

" Powerline

let g:Powerline_colorscheme='solarized'
let g:Powerline_symbols = 'fancy'

" Ack

let g:ackprg = 'ag --nogroup --nocolor --column'
