" Global settings {{{1

scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8

set nocompatible
set shell=/bin/bash

set mouse=

set vb t_vb=

let mapleader = ","
let maplocalleader = "\<Space>"


" Vundle {{{1

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
try
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'

  Plugin 'airblade/vim-gitgutter'
  Plugin 'aklt/plantuml-syntax'
  Plugin 'Align'
  Plugin 'AndrewRadev/linediff.vim'
  Plugin 'bkad/CamelCaseMotion'
  Plugin 'cieplik/vim-cmake'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'elzr/vim-json'
  Plugin 'embear/vim-localvimrc'
  Plugin 'honza/vim-snippets'
  Plugin 'kana/vim-operator-user'
  Plugin 'kana/vim-submode'
  Plugin 'lyuts/vim-rtags'
  Plugin 'MarcWeber/vim-addon-mw-utils'
  Plugin 'matze/vim-ini-fold'
  Plugin 'othree/xml.vim'
  Plugin 'python-mode/python-mode'
  Plugin 'qingxbl/Mark--Karkat'
  Plugin 'ReplaceWithRegister'
  Plugin 'rhysd/clever-f.vim'
  Plugin 'rhysd/committia.vim'
  Plugin 'rhysd/vim-clang-format'
  Plugin 'richq/vim-cmake-completion'
  Plugin 'rking/ag.vim'
  Plugin 'SirVer/ultisnips'
  Plugin 'terryma/vim-multiple-cursors'
  Plugin 'tlib'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-dispatch'
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-vinegar'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'vim-scripts/dbext.vim'
  Plugin 'vimoutliner/vimoutliner'
  Plugin 'will133/vim-dirdiff'
  Plugin 'xtal8/traces.vim'
  Plugin 'yssl/QFEnter'
  Plugin 'IngoHeimbach/neco-vim'

  Plugin 'cieplik/vim-kythe'
  Plugin 'mattn/webapi-vim'

  " Syntax
  Plugin 'ekalinin/Dockerfile.vim'
  Plugin 'hdima/python-syntax'
  Plugin 'tfnico/vim-gradle'
  Plugin 'tpope/vim-markdown'
  Plugin 'vim-scripts/scons.vim'

  " Color schemes
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'jonathanfilip/vim-lucius'

  call vundle#end()
catch /.*/
endtry


" Filetype {{{1

filetype plugin on


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

set formatoptions+=j

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

let g:mwDefaultHighlightingPalette = 'maximum'  " MARK setting

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
set laststatus=2


" GUI {{{1

if has( "gui_running" )
	set guioptions-=m
	set guioptions-=T
	set guioptions-=e
endif


" localvimrc {{{1
let g:localvimrc_sandbox=0
let g:localvimrc_persistent=1


" CamelCaseMotion {{{1
call camelcasemotion#CreateMotionMappings('<leader>')


" vim-submode {{{1
let g:submode_keep_leaving_key = 1

for s:direction in ['-', '+', '<', '>']
  silent!   call submode#enter_with('window-resize', 'n', '', '<C-w>'.s:direction, '<C-w>'.s:direction)
        \ | call submode#map('window-resize', 'n', '', s:direction, '3<C-w>'.s:direction)
endfor


" Ag {{{1

command! -bang -nargs=* -complete=file Agg
       \ call ag#Ag('grep!', <q-args> . " " . system('git rev-parse --show-toplevel'))


" CtrlP {{{1
let g:ctrlp_max_files     = 100000
let g:ctrlp_switch_buffer = 'et'

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_prompt_mappings = {
\ 'PrtHistory(-1)': ['<c-b>'],
\ 'PrtHistory(1)':  ['<c-f>'],
\ 'ToggleType(-1)': [],
\ 'ToggleType(1)':  ['<c-p>'],
\ }

nnoremap <C-c> :CtrlP .<CR>


" EditorConfig {{{1
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = "none"

" :EditorConfigReload conflicts with :Explore
cnoreabbrev E Explore


" QFEnter {{{1
let g:qfenter_vopen_map = ['<C-v>']
let g:qfenter_hopen_map = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_topen_map = ['<C-t>']


" LaTeX-Suite {{{1

let g:Imap_UsePlaceHolders = 0
let g:Tex_SectionMaps      = 0


" ini-fold {{{1

let g:ini_fold_enabled_filetypes = {'gitconfig': 0, 'dosini': 1}


" vim-json {{{1

" Don't conceal quotes
let g:vim_json_syntax_conceal = 0


" YouCompleteMe, vim-rtags {{{1

let g:ycm_python_binary_path = 'python'

let g:ycm_key_list_select_completion = []
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']

nnoremap <LocalLeader>3 :YcmCompleter ClearCompilationFlagCache<CR>
nnoremap <LocalLeader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <LocalLeader>D :YcmCompleter GoToDefinition<CR>
nnoremap <LocalLeader>/ :YcmDiags<CR>

highlight link YcmErrorSection Error


let g:rtagsUseDefaultMappings = 0

noremap <LocalLeader>i :call rtags#SymbolInfo()<CR>
noremap <LocalLeader>j :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <LocalLeader>S :call rtags#JumpTo(g:H_SPLIT)<CR>
noremap <LocalLeader>V :call rtags#JumpTo(g:V_SPLIT)<CR>
noremap <LocalLeader>T :call rtags#JumpTo(g:NEW_TAB)<CR>
noremap <LocalLeader>p :call rtags#JumpToParent()<CR>
noremap <LocalLeader>f :call rtags#FindRefs()<CR>
noremap <LocalLeader>F :call rtags#FindRefsCallTree()<CR>
noremap <LocalLeader>n :call rtags#FindRefsByName(input("(find refs) pattern: ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <LocalLeader>s :call rtags#FindSymbols(input("(find symbols) pattern: ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <LocalLeader>t :call FindClassTree()<CR>
noremap <LocalLeader>r :call rtags#ReindexFile()<CR>
noremap <LocalLeader>l :call rtags#ProjectList()<CR>
noremap <LocalLeader>w :call rtags#RenameSymbolUnderCursor()<CR>
noremap <LocalLeader>v :call rtags#FindVirtuals()<CR>

function! FindClassTree()
    let lines = rtags#ExecuteRC({'-class-hierarchy': rtags#getCurrentLocation()})
    call filter(lines, 'v:val !~ "classes:"')
    call map(lines, 'substitute(v:val, ''\v[^\/]+'', "", "")')
    call rtags#DisplayResults(lines)
endfunction


" pymode {{{1

let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_options = 0
let g:pymode_rope = 0


" Doxygen {{{1

let g:load_doxygen_syntax = 1


" Colorscheme {{{1

set rtp+=~/.vim/colorscheme


" Accessibility {{{1

map <Space><Space> <Tab>
imap jj <Esc>


" Machine-local runtime {{{1

set rtp+=~/.vim/local

" }}}1

" vim: set expandtab foldmethod=marker :
