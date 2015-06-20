if has ('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundle {{{
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" Vimproc {{{
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }
"}}}

" ColorScheme {{{
NeoBundle 'nanotech/jellybeans.vim'
"}}}

" PowerLine {{{
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
"}}}

" Unite {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
"}}}

" NeoComplete {{{
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'violetyk/neocomplete-php.vim'
let g:neocomplete_php_locale = 'ja'

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

" TagList {{{
NeoBundle 'vim-scripts/tagbar'
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
map <silent> <C-l>t :TagbarToggle<CR>
"}}}

" RainbowParentheses {{{
NeoBundle 'kien/rainbow_parentheses.vim'
autocmd BufEnter * RainbowParenthesesActivate
autocmd BufEnter * RainbowParenthesesLoadRound
"}}}

" etc... {{{
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'jiangmiao/simple-javascript-indenter'
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
set nrformats=hex
set cursorline
set scrolloff=5

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
set smarttab
set smartindent 
set expandtab
set tabstop=4
set shiftwidth=4
"}}}

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
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" KeyMapping {{{
let mapleader=","
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
nnoremap / /\v
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
""vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
"}}}

" forPHP {{{

" }}}
