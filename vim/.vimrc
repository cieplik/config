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


" vim-plug {{{1

try
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin("~/.vim/bundle")

  Plug 'airblade/vim-gitgutter'
  Plug 'aklt/plantuml-syntax', {'for': 'plantuml'}
  Plug 'vim-scripts/Align'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'bkad/CamelCaseMotion'
  Plug 'cieplik/vim-cmake'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'elzr/vim-json', {'for': 'json'}
  Plug 'embear/vim-localvimrc'
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
  Plug 'junegunn/fzf.vim'
  Plug 'honza/vim-snippets'
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-submode'
  Plug 'lyuts/vim-rtags', {'for': ['c', 'cpp'], 'frozen': 1}
  Plug 'cieplik/vim-rtags-callstack', {'for': ['c', 'cpp']}
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'matze/vim-ini-fold', {'for': 'dosini'}
  Plug 'mogelbrod/vim-jsonpath'
  Plug 'othree/xml.vim', {'for': 'xml'}
  Plug 'python-mode/python-mode', {'for': 'python'}
  Plug 'qingxbl/Mark--Karkat'
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'rhysd/clever-f.vim'
  Plug 'rhysd/committia.vim'
  Plug 'kbenzie/vim-cmake-completion', {'for': 'cmake'}
  Plug 'SirVer/ultisnips'
  Plug 'sheerun/vim-polyglot'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'vim-scripts/tlib'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/dbext.vim'
  Plug 'wellle/targets.vim'
  Plug 'xtal8/traces.vim'
  Plug 'yssl/QFEnter'

  " Color schemes
  Plug 'altercation/vim-colors-solarized'
  Plug 'jonathanfilip/vim-lucius'

  call plug#end()
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

let g:netrw_keepdir=0

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


" fzf.vim {{{1

let g:fzf_action = {'ctrl-s': 'split', 'ctrl-t': 'tab split', 'ctrl-v': 'vsplit'}
let g:fzf_layout = {'down': '~25%'}

function! s:GitRoot()
  return systemlist('env -u GIT_DIR git rev-parse --show-toplevel')[0]
endfunction

command! -nargs=* Agg call fzf#vim#ag_raw(<q-args>, {'dir': s:GitRoot()})

nnoremap <C-c> :Files<CR>
nnoremap <C-p> :call fzf#vim#files(<SID>GitRoot())<CR>


" EditorConfig {{{1
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = "none"

" :EditorConfigReload conflicts with :Explore
cnoreabbrev E Explore


" QFEnter {{{1
let g:qfenter_vopen_map = ['<C-v>']
let g:qfenter_hopen_map = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_topen_map = ['<C-t>']


" GitGutter {{{1

nnoremap <LocalLeader>g :GitGutterToggle<CR>


" LaTeX-Suite {{{1

let g:Imap_UsePlaceHolders = 0
let g:Tex_SectionMaps      = 0


" ini-fold {{{1

let g:ini_fold_enabled_filetypes = {'gitconfig': 0, 'dosini': 1}


" vim-json {{{1

" Don't conceal quotes
let g:vim_json_syntax_conceal = 0


" vim-polyglot {{{1

let g:polyglot_disabled = ['c/c++', 'c++11']


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
