""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Perforce Stuff
"
" Useful mappings for use with Perforce...
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> ,co mz<F5>:!cmd /c "(p4 login -s \|\| p4 login) && p4 edit "%""<CR>:e!<CR>`z
map <silent> ,diff :update<CR>:silent !cmd /c "(p4 login -s \|\| p4 login) && C:\Progra~1\Perforce\P4.exe diff %:p"<CR>
map <silent> ,hist :update<CR>:silent !"(p4 login -s \|\| p4 login) && p4v -cmd "history %:p"<CR>
