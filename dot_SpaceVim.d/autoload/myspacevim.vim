function! myspacevim#before() abort
  au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown wrap
endf

function! myspacevim#after() abort
endf
