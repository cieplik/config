if ! exists('*s:jumpto')
  function s:jumpto(place, force)
    let l:place = s:jumpto_places[a:place]
    for l:way in l:place
      let l:destfile = substitute(expand('%:p:r'), '\C\v(Fwd|_fwd)', '', 'g') . l:way.to

      if exists('l:way.df')
        let l:destfile = substitute(l:destfile, l:way.df, l:way.dt, 'g')
      endif

      if strlen(glob(l:destfile)) || a:force  " check if accessible
        exe 'e' l:destfile
        return 1
      endif
    endfor

    echo printf('File not found (tried %s)', string(map(copy(l:place), 'v:val.to')))
  endfunction

  let s:jumpto_places =
  \ {
  \   'c': [{'to': '.cpp'},
  \         {'to': '.c'},
  \         {'to': '.cc'},
  \         {'to': '.C', 'df': 'include', 'dt': 'src'},
  \         {'to': '.cpp', 'df': '\v/include/[^/]+/', 'dt': '/src/'}
  \   ],
  \   'h': [{'to': '.h'},
  \         {'to': '.h', 'df': '\v/([^/]+)/src/([^/]+)$', 'dt': '/\1/include/\1/\2'}
  \   ]
  \ }
endif

nnoremap <buffer> <LocalLeader>c :call <SID>jumpto('c', 0)<CR>
nnoremap <buffer> <LocalLeader>C :call <SID>jumpto('c', 1)<CR>
nnoremap <buffer> <LocalLeader>h :call <SID>jumpto('h', 0)<CR>
nnoremap <buffer> <LocalLeader>H :call <SID>jumpto('h', 1)<CR>
" nnoremap <Leader>f :call Jumpto(g:jumpto_places['f'], 0)<CR>
" nnoremap <Leader>F :call Jumpto(g:jumpto_places['f'], 1)<CR>


" vim-rtags {{{1

noremap <buffer> <LocalLeader>i :call rtags#SymbolInfo()<CR>
noremap <buffer> <LocalLeader>j :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <buffer> <LocalLeader>S :call rtags#JumpTo(g:H_SPLIT)<CR>
noremap <buffer> <LocalLeader>V :call rtags#JumpTo(g:V_SPLIT)<CR>
noremap <buffer> <LocalLeader>T :call rtags#JumpTo(g:NEW_TAB)<CR>
noremap <buffer> <LocalLeader>p :call rtags#JumpToParent()<CR>
noremap <buffer> <LocalLeader>f :call rtags#FindRefs()<CR>
noremap <buffer> <LocalLeader>F :call rtags#FindRefsCallTree()<CR>
noremap <buffer> <LocalLeader>n :call rtags#FindRefsByName(input("(find refs) pattern: ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <buffer> <LocalLeader>s :call rtags#FindSymbols(input("(find symbols) pattern: ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <buffer> <LocalLeader>t :call FindClassTree()<CR>
noremap <buffer> <LocalLeader>r :call rtags#ReindexFile()<CR>
noremap <buffer> <LocalLeader>l :call rtags#ProjectList()<CR>
noremap <buffer> <LocalLeader>w :call rtags#RenameSymbolUnderCursor()<CR>
noremap <buffer> <LocalLeader>v :call rtags#FindVirtuals()<CR>


" clang-format {{{1

map <buffer> = <Plug>(operator-clang-format)


" vim: set expandtab foldmethod=marker :
