let g:airline_powerline_fonts = 1
scriptencoding utf-8

" config {{{
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamedplus
set hlsearch
syntax on
set ignorecase
set smartcase
set wrapscan
set showtabline=2
set hidden

" }}}

" vim-plug {{{
if !filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
  execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'simeji/winresizer'
  Plug 'Shougo/neco-vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'easymotion/vim-easymotion'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'junegunn/fzf.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'osyo-manga/vim-over'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'w0rp/ale'
call plug#end()
" }}}

" keymap {{{
let mapleader = "\<Space>"
inoremap <silent> jj <ESC>

"   buffer {{{
  nnoremap <silent><C-j> :bnext<CR>
  nnoremap <silent><C-k> :bprevious<CR>
  nnoremap <silent><C-w>d :bdelete<CR>
"   }}}

"   window {{{
  nnoremap <C-w>\| :vsplit<CR>
  nnoremap <C-w>- :split<CR>

"   }}}
" }}}

" ale {{{
let g:ale_sign_column_always = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace']
\}
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" vim-gitgutter {{{
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''
" }}}

" vim-easymotion {{{
nmap s <Plug>(easymotion-s2)
" }}}

" vim-airline {{{
let g:girline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '

" }}}

" fzf {{{
nnoremap <Leader>b :Buffers<CR>
" }}}

" vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
" }}}

" vim-over {{{
nnoremap <silent> <Leader>s :OverCommandLine<CR>%s/
" }}}

" nerdtree {{{
nnoremap <Leader>n :NERDTreeToggle<CR>
" }}}

" FileType {{{
augroup vimrc
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
