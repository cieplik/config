" Global settings {{{1

scriptencoding utf-8
set encoding=utf-8

set nocompatible
set shell=/bin/bash


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
Plugin 'w0ng/vim-hybrid'

call vundle#end()


" Filetype {{{1

filetype plugin indent on


" Reset all {{{1

set listchars=


" Netrw {{{1

" let g:netrw_keepdir=0


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


" Column and Row highlighting {{{1

set cursorline cursorcolumn


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

if exists("*submode::enter_with")
  for s:direction in ['-', '+', '<', '>']
    call submode#enter_with('window-resize', 'n', '', '<C-w>'.s:direction, '<C-w>'.s:direction)
    call submode#map('window-resize', 'n', '', s:direction, '3<C-w>'.s:direction)
  endfor
endif


" vim-airline {{{1
let g:airline_theme     = 'monochrome'
let g:airline_section_b = '%{airline#util#wrap(fnamemodify(getcwd(), ":t"),0)}'
let g:airline_mode_map  = {'__': '-', 'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V',
                        \ 'V': 'V', '': 'V', 's': 'S', 'S': 'S', '': 'S'}


" CtrlP {{{1
let g:ctrlp_max_files = 100000


" Colorscheme {{{1

set rtp+=~/.vim/colorscheme


" Mess {{{1

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set backspace=indent,eol,start	" more powerful backspacing

" Now we set some defaults for the editor
set autoindent		" always set autoindenting on
" set linebreak		" Don't wrap words by default
set textwidth=0		" Don't wrap lines by default
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
			" 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Disable the mouse
set mouse=

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
" if has("autocmd")
"   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"                    \| exe normal g'\"" | endif
" endif

set tabstop=2
set shiftwidth=2
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.

" Uzupelnianie skladni C / C++ i binding do tworzenia tagow.
set nocp
" set completeopt=menu
map <M-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --langmap=c++:+.tcc.hpp -h default,.tcc,.hpp --extra=+q .<CR>

let OmniCpp_MayCompleteDot   = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

let maplocalleader = "\<Space>"


" Tag List
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
map <F11> :TlistToggle<CR>

" Kodowanie znakow w konsoli.
set tenc=utf-8

" Wylacz place-holders w Latex-Suite
let g:Imap_UsePlaceHolders = 0

" Wylacz makra dla sekcji
let g:Tex_SectionMaps = 0

" Podswietlanie tab, eol, space
set lcs+=tab:>-,trail:%,eol:$
map <F12> :set list! <CR>

" Podswietlanie wiersza i kolumny
map <F4> :set cursorline! cursorcolumn! <CR>

" Wylaczenie toolbara i menubara

" NERDTree

let NERDTreeHijackNetrw = 0
map <F10> :NERDTreeToggle<CR>

" Vimoutliner

map <F5> :e ~/Projects/Other/outline.otl<CR>

set autochdir
" let g:netrw_keepdir = 0

set exrc
set secure

" Clojure (VimClojure)

let vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let vimclojure#ParenRainbow=1           " Rainbow parentheses'!


" .lvimrc

function! SetLocalOptions(fname)
	let dirname = fnamemodify(a:fname, ":p:h")
	while "/" != dirname
		let lvimrc  = dirname . "/.lvimrc"
		if filereadable(lvimrc)
			execute "source " . lvimrc
			break
		endif
		let dirname = fnamemodify(dirname, ":p:h:h")
	endwhile
endfunction

au BufNewFile,BufRead * call SetLocalOptions(bufname("%"))

" Aliasy

cnoreabbrev cdp     cd /home/dawid/Projects<CR>
cnoreabbrev cdpc    cd /home/dawid/Projects/Career<CR>
cnoreabbrev cdpcc   cd /home/dawid/Projects/Career/CV/cv.modern<CR>
cnoreabbrev cdpf    cd /home/dawid/Projects/Fluxbox<CR>
cnoreabbrev cdpj    cd /home/dawid/Projects/Java<CR>
cnoreabbrev cdpl    cd /home/dawid/Projects/Lisp<CR>
cnoreabbrev cdpn    cd /home/dawid/Projects/Niemirow<CR>
cnoreabbrev cdps    cd /home/dawid/Projects/Studies<CR>
cnoreabbrev cdpsa   cd /home/dawid/Projects/Studies/ACLS<CR>
cnoreabbrev cdpsr   cd /home/dawid/Projects/Studies/Rehab<CR>
cnoreabbrev cdpsrr  cd /home/dawid/Projects/Studies/Rehab/rehab<CR>
cnoreabbrev cdpst   cd /home/dawid/Projects/Studies/Thesis<CR>
cnoreabbrev cdpsts  cd /home/dawid/Projects/Studies/Thesis/solaris-crossbow<CR>
cnoreabbrev cdpstst cd /home/dawid/Projects/Studies/Thesis/solaris-crossbow/tex/thesis<CR>

cnoreabbrev cdv    cd /home/dawid/.VirtualBox<CR>
cnoreabbrev cdvs   cd /home/dawid/.VirtualBox/Shared<CR>


set et


" vim: set expandtab foldmethod=marker :
