" Global settings {{{1

scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8

set nocompatible
set shell=/bin/bash

set mouse=

let maplocalleader = "\<Space>"


" Vundle {{{1

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Align'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'ReplaceWithRegister'
" Plugin 'Rip-Rip/clang_complete'
Plugin 'aklt/plantuml-syntax'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elzr/vim-json'
Plugin 'embear/vim-localvimrc'
Plugin 'garbas/vim-snipmate'
Plugin 'kana/vim-submode'
Plugin 'matze/vim-ini-fold'
Plugin 'othree/xml.vim'
Plugin 'tlib'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vimoutliner/vimoutliner'

" Syntax
Plugin 'tfnico/vim-gradle'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/scons.vim'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'jonathanfilip/vim-lucius'

call vundle#end()


" Filetype {{{1

filetype plugin indent on


" Reset all {{{1

set listchars=


" History {{{1

set history=100
set viminfo='20,\"50


" File access {{{1

set autochdir

" let g:netrw_keepdir=0

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc


" Tabs, indenting, editing {{{1

set tabstop=2
set shiftwidth=2
set expandtab

set autoindent
set textwidth=0

set backspace=indent,eol,start

" Completion, hints, help {{{1

let OmniCpp_MayCompleteDot   = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0

set keywordprg=:help

set wildmode=full
set wildmenu


" Case settings {{{1

set ignorecase
set smartcase


" Searching {{{1

set hlsearch
set incsearch


" Line wrapping {{{1

nmap <BS>     :silent set wrap!<CR>
nmap <BS><BS> :silent windo set wrap!<CR>

set listchars+=extends:»


" Highlighting {{{1

syntax on
set showmatch  " show matching brackets

map <F12> :set list! <CR>
set listchars+=tab:>-,trail:%,eol:$

map <F4> :set cursorline! cursorcolumn! <CR>


" Column and Row highlighting {{{1

set cursorline cursorcolumn


" Status line {{{1
let g:airline_theme     = 'monochrome'
let g:airline_section_b = '%{airline#util#wrap(fnamemodify(getcwd(), ":t"),0)}'
let g:airline_mode_map  = {'__': '-', 'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V',
                        \ 'V': 'V', '': 'V', 's': 'S', 'S': 'S', '': 'S'}

set ruler
set showcmd


" GUI {{{1

if has( "gui_running" )
	set guioptions-=m
	set guioptions-=T
	set guioptions-=e
endif


" localvimrc {{{1
let g:localvimrc_sandbox=0
let g:localvimrc_persistent=1


" vim-submode {{{1
let g:submode_keep_leaving_key = 1

for s:direction in ['-', '+', '<', '>']
  silent!   call submode#enter_with('window-resize', 'n', '', '<C-w>'.s:direction, '<C-w>'.s:direction)
        \ | call submode#map('window-resize', 'n', '', s:direction, '3<C-w>'.s:direction)
endfor


" CtrlP {{{1
let g:ctrlp_max_files = 100000


" LaTeX-Suite {{{1

let g:Imap_UsePlaceHolders = 0
let g:Tex_SectionMaps      = 0


" ini-fold {{{1

let g:ini_fold_enabled_filetypes = {'gitconfig': 0, 'dosini': 1}


" vim-json {{{1

" Don't conceal quotes
let g:vim_json_syntax_conceal = 0


" clang-complete {{{1

let g:clang_use_library   = 1
let g:clang_complete_auto = 0


" Colorscheme {{{1

set rtp+=~/.vim/colorscheme


" Machine-local runtime {{{1

set rtp+=~/.vim/local


" Mess {{{1

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif


" vim: set expandtab foldmethod=marker :
