" settings {{{
set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamed
set hlsearch
syntax on
set ignorecase
set smartcase
set wrapscan
" }}}

" vim-plug {{{
if !filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
  execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'w0rp/ale'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'ryanoasis/vim-devicons'
  Plug 'altercation/vim-colors-solarized'
  Plug 'powerline/powerline'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf.vim'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-surround'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'easymotion/vim-easymotion'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'osyo-manga/vim-over'
  Plug 'tpope/vim-repeat'
  Plug 'Shougo/denite.nvim'
  Plug 'Shougo/neoyank.vim'
call plug#end()
"}}}


" ale {{{
let g:ale_sign_column_always = 1
" }}}

" vim-airline {{{
colorscheme solarized
let g:airline_powerline_fonts = 1

let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" }}}

" vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
" }}}

"FileType {{{
augroup vimrc
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" {{{ deoplete
let g:deoplete#enable_at_startup = 1
" }}}

" vim-easymotion {{{
nmap s <Plug>(easymotion-s2)
" }}}
