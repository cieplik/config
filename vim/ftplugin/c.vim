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


" clang-format {{{1

map <buffer> = <Plug>(operator-clang-format)


" vim: set expandtab foldmethod=marker :
