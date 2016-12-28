set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'vim-syntastic/syntastic'


"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

Plugin 'elzr/vim-json'

"Plugin 'justinmk/vim-sneak'

"Plugin 'ctrlpvim/ctrlp.vim'


Plugin 'tpope/vim-fugitive'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'



" Color schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable mouse support
set mouse=a
" Enable syntax highlighting
syntax on
" Always show the status line
set laststatus=2
" Enable line numbers
set number

" Recommended settings for Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0"

" Airline font settings
let g:airline_powerline_fonts = 1

