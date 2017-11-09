setlocal foldmethod=expr


function! CMakeFoldExpr(lnum)
  if   getline(a:lnum-2) =~? '\v.*(add_definitions|add_executable|add_library|foreach|set)[^)]*$'
  \ && getline(a:lnum-1) !~? '\v.*\).*$'
  \ && getline(a:lnum)   !~? '\v.*\).*$'
  \ && getline(a:lnum+1) !~? '\v.*\).*$'
    return '1'
  elseif getline(a:lnum)   !~? '\v.*\).*'
  \ &&   getline(a:lnum+1) !~? '\v.*\).*'
  \ &&   getline(a:lnum+2) =~? '\v.*\).*'
    return '<1'
  endif

  return '-1'
endfunction

setlocal foldexpr=CMakeFoldExpr(v:lnum)


function! CMakeFoldText()
  return getline(v:foldstart) . '    (' . (v:foldend - v:foldstart + 1) . ' lines) '
endfunction

setlocal foldtext=CMakeFoldText()
