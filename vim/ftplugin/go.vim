noremap <buffer> <LocalLeader>i :GoInfo<CR>
noremap <buffer> <LocalLeader>j :GoDef<CR>
noremap <buffer> <LocalLeader>S :split<CR>:GoDef<CR>
noremap <buffer> <LocalLeader>V :vsplit<CR>:GoDef<CR>
noremap <buffer> <LocalLeader>T :split<CR>:GoDef<CR><C-W>T
noremap <buffer> <LocalLeader>f :GoReferrers<CR>
noremap <buffer> <LocalLeader>F :GoCallers<CR>
noremap <buffer> <LocalLeader>w :GoRename<CR>

let g:go_fmt_command = "goimports"
