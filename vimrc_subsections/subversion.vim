" ----------------------------------------------------------------------------- 
"                             Subversion Mappings
"
" Haven't used Subversion for a LONG time, but these might come in 
" handy again some day...
" ----------------------------------------------------------------------------- 
map <silent> ,tdiff  :w<CR>:silent !"TortoiseProc.exe /command:diff  /path:"%" /notempfile /closeonend"<CR>
map <silent> ,tblame :call TortoiseBlame()<CR>
map <silent> ,tlog   :w<CR>:silent !"TortoiseProc.exe /command:log   /path:"%" /notempfile /closeonend"<CR>
map <silent> ,trevs  :w<CR>:silent !"TortoiseProc.exe /command:revisiongraph  epath:"%" /notempfile /closeonend"<CR>

fu! TortoiseBlame()
  " Save the file
  silent execute(':w')

  " Now run Tortoise to get the blame dialog to display
  let filename = expand("%")
  let linenum  = line(".")
  silent execute('!TortoiseProc.exe /command:blame /path:"' . filename . '" /line:' . linenum . ' /notempfile /closeonend')
endfunc
