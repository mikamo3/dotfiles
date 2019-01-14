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
call plug#end()
"}}}

" vim-airline {{{
colorscheme solarized
let g:airline_powerline_fonts = 1

let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" }}}

"FileType {{{
augroup vimrc
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
