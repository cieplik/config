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
  Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
  Plug 'junegunn/fzf.vim'
  Plug 'will133/vim-dirdiff'
  Plug 'honza/vim-snippets'
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-submode'
  Plug 'lyuts/vim-rtags', {'for': ['c', 'cpp'], 'frozen': 1}
  Plug 'cieplik/vim-rtags-callstack', {'for': ['c', 'cpp']}
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'matze/vim-ini-fold', {'for': 'dosini'}
  Plug 'mogelbrod/vim-jsonpath'
  Plug 'ojroques/vim-oscyank', {'branch': 'main'}
  Plug 'othree/xml.vim', {'for': 'xml'}
  Plug 'python-mode/python-mode', {'for': 'python'}
  Plug 'ryancx/Mark--Karkat'
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'rhysd/clever-f.vim'
  Plug 'kbenzie/vim-cmake-completion', {'for': 'cmake'}
  Plug 'SirVer/ultisnips'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tomtom/tlib_vim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'Valloric/YouCompleteMe', {'do': './install.py --clangd-completer --go-completer'}  " --java-completer --go-completer'}  " --ts-completer'}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/dbext.vim'
  Plug 'wellle/targets.vim'
  Plug 'xtal8/traces.vim'
  Plug 'yssl/QFEnter'
  Plug 'romainl/flattened'

  call plug#end()
catch /.*/
endtry


" Filetype {{{1

filetype plugin on
filetype indent off


" Reset all {{{1

set listchars=


" History {{{1

set history=100
set viminfo='20,\"50


" File access {{{1

autocmd BufEnter * silent! lcd %:p:h  " `set noautochdir` was causing problems with FZF

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


" Diff {{{1

nnoremap <LocalLeader>b :set noscrollbind nocursorbind<CR>
nnoremap <LocalLeader>B :set scrollbind cursorbind<CR>


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


" vim-fugitive {{{1
nnoremap <LocalLeader>m :Gvdiffsplit origin/master:%<CR>


" fzf.vim {{{1
let g:fzf_action = {'ctrl-s': 'split', 'ctrl-t': 'tab split', 'ctrl-v': 'vsplit'}
let g:fzf_layout = {'down': '~25%'}

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

function! s:GitRoot()
  return systemlist('env -u GIT_DIR -u GIT_WORK_TREE git rev-parse --show-toplevel')[0]
endfunction

command! -nargs=* Agg call fzf#vim#ag_raw(<q-args>, {'dir': s:GitRoot()})

nnoremap <LocalLeader>w :Agg -w <C-r><C-w><CR>
nnoremap <LocalLeader>a :Agg -w 
nnoremap <LocalLeader>A :Ag -w 

nnoremap <C-c> :Files<CR>
nnoremap <C-m> :call fzf#vim#files(fnamemodify(findfile('CMakeLists.txt', ';'), ':h'))<CR>
nnoremap <C-p> :call fzf#vim#files(<SID>GitRoot())<CR>


" EditorConfig {{{1
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = "none"

" :EditorConfigReload conflicts with :Explore
cnoreabbrev E Explore


" QFEnter {{{1
let g:qfenter_keymap = {'vopen': ['<C-v>'], 'hopen': ['<C-CR>', '<C-s>', '<C-x>'], 'topen': ['<C-t>']}


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


" vim-oscyank {{{1

vnoremap <LocalLeader>o :OSCYank<CR>
nmap <LocalLeader>o <Plug>OSCYank


" vim-polyglot {{{1

let g:polyglot_disabled = ['c/c++', 'c++11']


" YouCompleteMe, vim-rtags {{{1

let g:ycm_python_binary_path = 'python'

let g:ycm_key_list_select_completion = []
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']

nnoremap <LocalLeader>3 :YcmCompleter ClearCompilationFlagCache<CR>
nnoremap <LocalLeader>= :YcmCompleter FixIt<CR>
nnoremap <LocalLeader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <LocalLeader>D :YcmCompleter GoToDefinition<CR>
nnoremap <LocalLeader>/ :YcmDiags<CR>

highlight link YcmErrorSection Error


let g:rtagsUseDefaultMappings = 0

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

colorscheme flattened_dark


" Accessibility {{{1

map <Space><Space> <Tab>
imap jj <Esc>


" Machine-local runtime {{{1

set rtp+=~/.vim/local

" }}}1


" vim: set expandtab foldmethod=marker :
