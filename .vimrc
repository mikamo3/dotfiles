if has ('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundle {{{
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" ColorScheme {{{
NeoBundle 'nanotech/jellybeans.vim'

"}}}

" PowerLine {{{
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
"}}}

call neobundle#end()
"}}}

set nocompatible
set number
syntax on
set noswapfile
set nobackup
set ruler
set cmdheight=1
set laststatus=2
set wrap
set showmatch
set whichwrap=h,l
set hidden
set history=2000
" Encording: {{{
if has('multi_byte')
    set encoding=utf-8
    set fileencodings=utf-8,cp932,sjis,iso-2022-jp,euc-jp
    set fileformats=unix,dos,mac
    set fileencoding=utf-8
endif
"}}}

" Indent {{{
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
" }}}

" Search {{{
set ignorecase
set smartcase
set incsearch
set hlsearch
set magic
"}}}

" List {{{
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"}}}

" Folding {{{
set foldenable
set foldmethod=marker
set foldlevel=0
set foldnestmax=3         " maximum nest level
set foldcolumn=1          " show fold guide
" }}}
colorscheme jellybeans 
set guifont=Ricty\ Regular\ for\ Powerline:h14"
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif
" list
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" KeyMapping {{{
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
nnoremap / /\v
nnoremap ; :
"}}}
