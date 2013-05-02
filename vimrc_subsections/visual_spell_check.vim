""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Visual Spell Check:  run aspell on a selection
"
" A little chuck of code that I forgot that I had.  I think this used 
" the aspell interactive spell checker rather than the one built in to vim.
"
" It's been a long time and when I tested this last it no longer worked,
" didn't spend any time troubleshooting.  Not sure if I'll ever use this
" again...
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap ,sp :call SpellcheckVisual()<CR>
fun! SpellcheckVisual() range
  let line1 = a:firstline
  let line2 = a:lastline
  let range = line1 . ',' . line2
  let spellfile = tempname()

  " Write the selected lines out to the temp file
  silent execute ":'<,'>w " . spellfile

  " Spell check the temp file
  silent execute '!aspell -c ' . spellfile 

  " Delete the lines that we spell checked
  silent execute range . "d"

  " read the fixed lines in from the temp file
  silent execute ":" . line1 - 1 . "r " . spellfile
endfun
