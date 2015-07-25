function! Echom(msg)
  echom a:msg
endfunction

function! Jumpto(to, dirfrom, dirto)
  let $DESTFILE = substitute(substitute(expand('%:p:r'), '\v(Fwd|_fwd)', '', 'g') . a:to,
                  \          a:dirfrom, a:dirto, 'g')
  let accessible = strlen(glob($DESTFILE))
  let b:create = 0

  if accessible || b:create
    e $DESTFILE
  endif

  return accessible || b:create
endfunction

nnoremap <Leader>c :call eval(       "Jumpto('.C', 'include', 'src') "
                         \    . "\|\| Echom('Source file not found') "
                         \   )<CR>

nnoremap <Leader>h :call eval(       "Jumpto('.h', 'src', 'include')"
                         \    . "\|\| Echom('Header file not found') "
                         \   )<CR>

nnoremap <Leader>f :call eval(       "Jumpto('Fwd.h',  'src', 'include') "
                         \    . "\|\| Jumpto('_fwd.h', 'src', 'include') "
                         \    . "\|\| Echom('Forward declaration file not found') "
                         \   )<CR>

" nmap <Leader>C :let b:create = 1<CR><Leader>c<CR>:let b:create = 0<CR>

