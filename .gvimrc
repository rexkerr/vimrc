if(v:version >= 700)
   set guitablabel=%N\ %t\ %m
endif
"
" I almost always use a black background...
set background=dark          

" My preferred colors
colorscheme torte

" Set a reasonable color scheme for the UGLY autocompletion popup
highlight Pmenu guibg=brown gui=bold 

" set lines=100   " gvim automatically limits its height, this basically
"                 " means 'as tall as possible'
"                 " THIS WAS 1000, BUT CAUSING PROBLEMS IN UNITY
" set co=80

" These resize the gvim window itself.  The CTRL-SHIFT versions for
" manipulating the split size are stored in the .vimrc since they also
" work at the console
map <M-S-UP>    :set lines+=5<CR>
map <M-S-DOWN>  :set lines-=5<CR>
map <M-S-LEFT>  :set co-=5<CR>
map <M-S-RIGHT> :set co+=5<CR>

" Hide the menu since I seldom use it, and it gets in my way
set go-=m

" Hide the toolbar, since I never use it
set go-=T

" Make the tabline text rather than graphical
set go-=e

" vim: nowrap
