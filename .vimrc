"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" NOTE TO READERS
"
"    This .vimrc file is the result of many many years of just dumping junk in
"    here... some of it was dumped in for some one-off solution to some long
"    forgotten problem, some of it was inherited from a friend who got me back
"    into the habit of using vim, some of it was stuff that I set so long ago
"    that in my mind 'that's just how vim works', some of it was written for
"    very old versions of vim that didn't have better ways to do them...
"
"    I've tried to clean it up some and document it, but as long as it does
"    what I need, I continue to trudge along with this messy version of it.
"
"    If you find something useful here, please feel free to grab it. If you
"    have suggestions for improvements, I'd be glad to hear them...  If you
"    think it's just a pile of junk... oh well. :-)
"
"    TODO:
"
"      - Need to extract machine specific elements so that I have less churn in
"        my primary file & it stays the same across all of my machines, easing 
"        maintenance
"
"      - Extract Windows specific vs. Unix specific references to OS specific
"        files
"
"      - More cleanup
"      
"      - More documentation
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Function keys, documentation:
" F1:  Not used, built in help
" 
" F2: Increase font size
" S-F2: Decrease font size
" M-F2: Go to default font size
"
" F3: Edit alternate file  (:e #)
"
" F4: Open filename under cursor in the other open window
" S-F4: Open filename under the cursor in this window
"
" F5: Change the current directory to that of the current file
" S-F5: Change the current directory to the root directory
"
" F6: Swap header/source
" S-F6: I forget, what's different?
"
" F7: Not used
" 
" F8: Comment out selection, or current line
" S-F8: Uncomment out selection, or current line
" M-F8: I forget, what's different here?
"
" F9: Open/Close taglist plugin window
" S-F9: Sync the taglist plugin window
" M-F9: Go to the taglist plugin window (or leftmost window)
"
" F10:  Unused
"
" F11: Go to next error
" S-F11: go to previous error
" M-F11: (??Show status of build??)
" 
" Deprecated... reused
" F12: Save file
" S-F12: Revert
" M-F12: Reload (built in)



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  Clean up old settings in case we're reloading...
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
mapc                         " remove all previous mappings
abc                          " remove all previous abbreviations


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on                  " enable filetype detection
filetype plugin on           " 
filetype indent on           "

set nocompatible             " Leave vi in the past
set nobackup                 " Don't litter the filesystem with junk!
set viminfo='20,\"50         " Remember up to 20 previous files, 50 lines per register
set history=50               " keep 50 last commands
set showtabline=2            " Always show the tabline, even if there is only one tab
set ruler                    " Show the line & column number of the cursor position
set makeef=$TEMP\vim##.err   " makeeef, make error file
set swb=useopen              " switchbuf, use already open buffer in current tab
set nrformats+=alpha         " Used with CTRL-A and CTRL-X to increment and decrement the letter under the cursor
set nrformats-=octal         " Used with CTRL-A and CTRL-X to increment and decrement the letter under the cursor
syntax on                    " Syntax highlighting
set hlsearch                 " Highlight Search, highlight all matches when searching
set is                       " Incremental Search (show next search result as you type it

if has("win32")
  source $VIMRUNTIME/mswin.vim
endif

let comment_string=""
set nolisp

set background=dark          " I almost always use a black background...


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" TODO:  This whole augroup block is really old... there are better 
"        ways to do this now with filetype plugins... need to research 
"        and refactor.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup aft
  au BufWrite,BufNewFile,BufRead,BufEnter *.aft set noet
augroup END

augroup cprog
  au!
  "au FileType * set formatoptions=tcq nocindent comments&
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set nolisp
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set filetype=cpp syntax=cpp
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set formatoptions=crql nowrap cindent comments=sr:/*,mb:*,el:*/,:///,:// isk-=$
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set cindent
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set number
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set syntax=cpp.doxygen
  au BufWrite,BufNewFile,Bufread,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc let comment_string = "//"
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set cinkeys=0{,0},:,0#,!^F,o,O,e
  "au BufWrite,BufNewFile,BufRead,BufEnter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc
  au BufWrite,BufNewFile,BufRead,BufEnter *.c,*.cpp set fdc=3 
  au bufwrite,bufnewfile,bufread,bufenter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match dangerous_stuff "scoped_lock\s*("
  au bufwrite,bufnewfile,bufread,bufenter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match straytabs "\t"
  au bufwrite,bufnewfile,bufread,bufenter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match strayspaces "\s\+$"
  au bufwrite,bufnewfile,bufread,bufenter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight Dangerous_Stuff guibg=#FF0000 gui=bold
  au bufwrite,bufnewfile,bufread,bufenter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight StrayTabs guibg=#252525 gui=bold
  au bufwrite,bufnewfile,bufread,bufenter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight StraySpaces guibg=#151010 gui=bold
augroup END

augroup html
  au!
  au BufWrite,BufNewFile,BufRead,BufEnter *.htm,*.html set nowrap tw=0
augroup END

augroup rc
  au!
  au BufWrite,BufNewFile,BufRead,BufEnter *.rc set nowrap
augroup END

augroup plg
  au!
  " set errorformat+=%f(%l) : error %t%n: %m
  au BufWrite,BufNewFile,BufRead,BufEnter *.plg set nowrap
  au BufWrite,BufNewFile,BufRead,BufEnter *.plg call CleanErrorFile()
augroup END


augroup Perl
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm set isk+=$
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm let comment_string = "#"
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm set cinkeys="0{,0},:,!^F,o,O,e"
  au BufWrite,BufNewFile,BufRead,BufEnter *.pl,*.pm set formatoptions=crql nowrap cindent number
augroup END

augroup Python
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.py set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.py inoremap <buffer> # X<BS>#
  au BufWrite,BufNewFile,BufRead,BufEnter *.py set nocindent smartindent
  au BufWrite,BufNewFile,BufRead,BufEnter *.py set shiftwidth=4 softtabstop=4 tabstop=4 tw=0 nowrap et
  au BufWrite,BufNewFile,BufRead,BufEnter *.py set cinwords=if,elif,else,for,while,try,except,finally,def,class
  au BufWrite,BufNewFile,Bufread,BufEnter *.py set formatoptions=crq2
  au BufWrite,BufNewFile,Bufread,BufEnter *.py let comment_string = "#"
augroup END

augroup Matlab
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.m set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.m set formatoptions=crq2 tw=0
  au BufWrite,BufNewFile,Bufread,BufEnter *.m let comment_string = "%"
augroup END

augroup Vimrc
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter _vimrc,.vimrc,*.vim set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter _vimrc,.vimrc,*.vim set tw=0 nowrap
  au BufWrite,BufNewFile,Bufread,BufEnter _vimrc,.vimrc,*.vim let comment_string = "\""
augroup END

augroup Lisp
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.lsp,*.lisp,*.cl,*.el set lisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.lsp,*.lisp,*.cl,*.el let comment_string = ";"
augroup END

augroup Latex
   au!
   au BufWrite,BufNewFile,Bufread,BufEnter *.tex set nowrap
   au BufWrite,BufNewFile,Bufread,BufEnter *.tex set foldmethod=marker
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex let comment_string = "%"
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex syntax match texUseProperTags "etc[^\}]\|\.\.\."
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex highlight texUseProperTags guibg=#D00000 guifg=White
   if(v:version >= 700)
      au BufWrite,BufNewFile,BufRead,BufEnter *.tex set spell
   endif
augroup END

augroup LogFiles
   au!
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* set nowrap
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGWARN ".*WARN\s\+-.*"
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGERROR ".*ERROR\s\+-.*"
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGFATAL ".*FATAL\s\+-.*"

   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGWARN guibg=#FFE900 guifg=#000000
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGERROR guibg=#F77B7D guifg=#000000
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGFATAL guibg=#FF0000 gui=bold guifg=#000000
augroup END

" Turn off syntax highlighting, etc. for large files
let g:LargeFile= 10     " in megabytes 
let g:LargeFile= g:LargeFile*1024*1024 
augroup LargeFile 
   au BufReadPre * 
   \ let f=expand("<afile>") | 
   \  if getfsize(f) >= g:LargeFile | 
   \  let b:eikeep= &ei | 
   \  let b:ulkeep= &ul | 
   \  set ei=FileType | 
   \  setlocal noswf bh=unload | 
   \  let f=escape(substitute(f,'\','/','g'),' ') | 
"   \  exe "au LargeFile BufEnter ".f." set ul=-1" | 
   \  exe "au LargeFile BufEnter ".f." set ul=2" | 
   \  exe "au LargeFile BufLeave ".f." let &ul=".b:ulkeep."|set ei=".b:eikeep | 
   \  exe "au LargeFile BufUnload ".f." au! LargeFile * ". f | 
   \  echomsg "***note*** handling a large file" | 
   \ endif 
augroup END

map ,py :!python %<CR>

set grepprg=egrep\ -n

" Make * search for the entire highlighted string when in visual select mode, rather than just the word under the cursor
vmap <silent> * y/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '\\n', 'g')<CR><CR>

map <C-A> ggVG
map ,all mzggVG"*y`z

map ,fo V%:fo<CR>
vmap ,fo %:fo<CR>

" Set up the statusline (stl)
set stl=%f%h%m%r\ %{Options()}%=%l,%c%V\ %{line('$')} 
fu! Options()
  let opt="ai".PlusOpt(&ai)
  let opt=opt." rap".PlusOpt(&wrap)
  let opt=opt." ic".PlusOpt(&ic)
  let opt=opt." et".PlusOpt(&et)
   if(v:version >= 700)
     let opt=opt." sp".PlusOpt(&spell)
   endif
  let opt=opt." ".&ff
  let opt=opt." ".&ft

  if &ft==?"cpp" || &ft==?"perl"
    let text = "{" . FindCurrentFunction(0) . "}"
    let opt= opt.text
  endif

  return opt
endf

fu! PlusOpt(opt)
  let option = a:opt
  if option
    return "+"
  else
    return "-"
  endif
endf


set listchars=tab:»·,trail:·

map ,getbom :execute("edit " . g:reference_dir . g:bom_file)<CR>
map ,getnt :execute("edit " . g:reference_dir . g:nt_file)<CR>



set textwidth=70
map ,fdos :set fileformat=dos<NL>
map ,funix :set fileformat=unix<NL>

" copy the full filename into the system clipboard
map ,fname :let @* = fnamemodify(bufname("%"), ":p:")<CR>:<BS>

map ,ym :let @* = matchstr(getline("."), @/)<CR>:<BS>

if has("unix")
"   set dir=$TEMP
"   set bdir=$TEMP  
else
  set dir=$TEMP\vimswap
  set bdir=$TEMP\vimswap
  if !isdirectory(&dir)
    execute("!mkdir " . &dir)
  endif
endif


set shiftwidth=3
set tabstop=3
set showmatch
set expandtab
set nowrapscan
set ignorecase
set sm ai
set bs=2
set laststatus=2
set cmdheight=2
set cinoptions=g0
set noequalalways
set splitright
set splitbelow

map ,cd :call ConditionalCD()<CR><C-L>:<BS>
map <F5> ,cd
map <F11> :cn<CR>
map <s-f11> :cp<CR>
map <m-F11> 0/([0-9][0-9]*) :<CR>l"zyiw0:noh<CR><F4>:exe "normal <C-R>zG"<CR>:<BS>z<CR>,wj

fun! ConditionalCD()
  if (expand("%:h") != "")
    exec("cd %:h")
  endif
endfun


map ,explorer :call LaunchExplorerPWD()<CR>

fun! LaunchExplorerPWD()
   silent exec("!explorer %:p:h")
endfun

map <S-F5> :cd \<NL>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  This stuff should probably go in the .gvimrc...
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> :call CycleFonts(1)<CR>
map <S-F2> :call CycleFonts(-1)<CR>
map <M-F2> :let fontindex = 0<NL><F2>
map <F3> <C-^>
map <F6> :call LoadHeaderOrSrcFile(0)<CR>
map <S-F6> :call LoadHeaderOrSrcFile(1)<CR>
map <M-F6> ,2<F6>
map <F8>  ,_nfcomment
map <M-F8>  ,_ncomment
map <S-F8>  ,_nuncomment

"map <F12> :w<CR>
"Alt-F12 will reload the file
"map <S-F12> :e!<NL>


imap <F2> <ESC><F2>a
imap <F3> <ESC><F3>a
imap <F5> <ESC><F5>a
imap <F6> <ESC><F6>a
imap <F7> <ESC><F7>a
imap <M-F7> <ESC><M-F7>a
imap <C-F7> <ESC><C-F7>a
imap <F12> <ESC><F12>a
imap <S-F12> <ESC><S-F12>
imap <F8> <ESC><F8>a
imap <F9> <ESC><F9>a


map ,80 :set co=80<CR>
map ,max :set lines=1000<CR>

map ,> :%:s/^[> ]*//ge<NL>:noh<NL>
map ,$> :.,$:s/^[> ]*//ge<NL>:noh<NL>

" Move between buffers
map <C-DOWN> <C-W>j
map <C-UP> <C-W>k
map <C-LEFT> <C-W>h
map <C-RIGHT> <C-W>l
map <M-j> <C-W>j
map <M-k> <C-W>k
map <M-h> <C-W>h
map <M-l> <C-W>l

imap <C-DOWN> <ESC><C-W>j
imap <C-UP> <ESC><C-W>k
imap <C-LEFT> <ESC><C-W>h
imap <C-RIGHT> <ESC><C-W>l
imap <M-j> <ESC><C-W>j
imap <M-k> <ESC><C-W>k
imap <M-h> <ESC><C-W>h
imap <M-l> <ESC><C-W>l

" Increase/Decrease the window size a bit
map <C-S-UP> 5<C-W>+
map <C-S-DOWN> 5<C-W>-
map <C-S-LEFT> 5<C-W><
map <C-S-RIGHT> 5<C-W>>

" Split windows, 2 to split the current window in half, v to split it vertically
map ,2 <C-W>s
map ,v <C-W>v

" Make windows equal size
map ,equal <C-W>=

" Make current window bigger
map ,tall <C-W>_
map ,wide <C-W>\|
map ,big ,tall,wide


" Redo
" map U <C-R>




" Quick commands for editing this file
map ,svimrc  :source $HOME/.vimrc<NL>
map ,evimrc  :edit   $HOME/.vimrc<NL>
map ,egvimrc :edit   $HOME/.gvimrc<NL>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  Move this to a machine specific file
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map ,ahk :e C:\Program Files\AutoHotkey\AutoHotkey.ini<CR>:set ft=autohotkey<CR>
map ,ahk :e $HOME\My Documents\AutoHotkey.ahk<CR>:set ft=autohotkey<CR>

" Swap the word under the cursor with the current buffer
map ,sw ciw<C-R>0<ESC>

" Mark Swap:  swap word at mark a and mark b
map ,msw mz`a"zyiw`b"yyiw`aciw<C-R>y<ESC>`bciw<C-R>z<ESC>`z

" insert the current date into the file
map ,date o<ESC>"=strftime("%Y.%m.%d")<NL>p

map ,dtime o<ESC>"=strftime("%Y.%m.%d %I:%M %p")<NL>p

" Make the current file writable
map ,hijack :! attrib -r <C-R>%<NL>


" replace the character with a carriage return
map ,no; :s/;/<C-Q><C-M>/ge<NL>:noh<NL>
map ,no, :s/,/<C-Q><C-M>/ge<NL>:noh<NL>
map ,nosp :s/ /<C-Q><C-M>/ge<NL>:noh<NL>

"replace spaces with the character
map ,yes; :s/ /;/ge<NL>:noh<NL>:noh<NL>
map ,yes, :s/ /,/ge<NL>:noh<NL>:noh<NL>
map ,;j :s/  */;/ge<NL>:noh<NL>


"remove trailing spaces
map ,rts :%s/\s\+$//<CR>

map ,= yyp:s/[^=]/=/ge<NL>:noh<NL>

"map ,:: O<ESC>"%p$?\.<NL>Dbd0A::<ESC>gJ:noh<NL>
map ,:: :let @" = expand("%:r") . "::"<CR>:<BS>P
map ,iifdef O<ESC>"%p$?\.<NL>Dbd00gU$A_H<ESC>,ifdef<NL>:noh<NL>
map ,ifdef mzyyppkkI#ifndef <ESC>jI#define <ESC>jI#endif // <ESC>ddGp`z:noh<NL>


"imap <M-[> {<ESC>mza<NL>}<ESC>`za<NL>
imap <M-[> {<NL>}<ESC>O


"map ,fixconeline 0i<C-F><ESC>
"map ,cfix :normal ,fixconeline<NL>
"map ,ffix /{<NL>v%,cfix<NL>:noh<NL>


map ,cpp ,2<C-W>w,gc<C-W>w1G/clas<NL>Mjjyy,wPd0ywI::<ESC>0PO<ESC>PI#include

map ,_comment 0i<C-R>=comment_string<CR><ESC>
map ,_ncomment :normal ,_comment<NL>
map ,_fcomment I<C-R>=comment_string<CR><ESC>

map ,_nfcomment :normal ,_fcomment<NL>
map ,_uncomment :let @z = @/<CR>:s/^\(\s*\)<C-R>=escape(comment_string, '/')<CR>/\1/e<NL>:let @/ = @z<CR>:<BS>
map ,_nuncomment :normal ,_uncomment<NL>

" TODO:  Move this to a company specific file...
map ,cw <ESC>mzggO// Copyright (c) 2013, <COMPANY NAME>, All Rights Reserved<ESC>`z

" Remove all rational rose comments and extra spaces inserted by rose
map ,norose :%s@^.*//##.*\n\(\s*\n\)*@@ge<CR>
vmap ,norose :s@^.*//##.*\n\(\s*\n\)*@@ge<CR>

" Backup, checkout, and merge local writable copy of a file
map ,merge :!copy % %.backup.cpp<CR>:!attrib +r %<CR>,co:!"\Program Files\winmerge\winmerge" % %.backup.cpp<CR>

map ,bgswap :let &background = ( &background == "dark"? "light" : "dark" )<CR>


" for C++
ab p_b push_back
ab d_c< dynamic_cast<
ab s_c< static_cast<
ab r_c< reinterpret_cast<
ab vectint std::vector< int >
ab vectfloat std::vector< float >
ab vectdouble std::vector< double >

map ,dos2unix mz:%s/<C-Q><C-M>$//g<NL>:noh<NL>`z
"map ,tblfmt :perl -S tblfmt.pl "FS=," "OFS= | "


map ,et :call ToggleOption("expandtab")<NL><C-L>
map ,ic :call ToggleOption("ignorecase")<NL><C-L>
map ,ai :call ToggleOption("autoindent")<NL><C-L>
map ,rap :call ToggleOption("wrap")<NL><C-L>
map ,nu :call ToggleOption("number")<NL><C-L>

if(v:version >= 700)
  map ,sp :call ToggleOption("spell")<NL><C-L>
endif

noremap <C-K> <C-V>


vmap ,ali :call AlignThingy()<CR>

" This general-purpose function must escape it's arguments carefully.
fu! AlignThingy (...) range
  " Deal with TABs
  let originaletvalue = &expandtab
  exe 'set et'
  exe a:firstline . "," . a:lastline . "retab"
  
  if (a:0 == 0)
    let alignchar = input("Input align character: ")
  endif
  if (strlen( alignchar ) == 1)
    let alignchar = escape( alignchar, ".*[^$" )
    call AlignComments (alignchar, a:firstline, a:lastline )
  endif
endf


" Originally for Comment alignment, this function is actually general-purpose.
fu! AlignComments (opencomm, firstln, lastln)
    let opencomm = a:opencomm
    let midln = a:firstln
    let lastln = a:lastln
    let maxcol = 0
    let newcol = 0
    " find the most indented comment
    while midln <= lastln
        let midlnStr = getline(midln)  
        let newcol = match ( midlnStr, opencomm )
        if newcol > maxcol
            let maxcol = newcol
        endif
        let midln = midln + 1
    endwhile


    let midln = a:firstln
    while midln <= lastln
        let midlnStr = getline(midln)  
        let curcol = match ( midlnStr, opencomm )
        let spaces = maxcol - curcol
        let spaceStr = ""
        while spaces > 0
            let spaceStr = spaceStr . " "
            let spaces = spaces - 1
        endwhile
        call SubstLine ( midln, opencomm, spaceStr . '&', "" )
        let midln = midln + 1
    endwhile
endf


" Perform substitution on the existing line
" args :linenum s/pat/rep/flags
fu! SubstLine ( linenum, pat, rep, flags )
    let thislineStr = getline( a:linenum )
    let thislineStr = substitute( thislineStr, a:pat, a:rep, a:flags )
    call setline( a:linenum, thislineStr )
endf



function! OptSet(name,value)
  let name=a:name
  let value=a:value
  execute("let &".name."=".value)
endfunction



function! ToggleOption(option)
  let option = a:option
  execute ("set inv".option)
endf


function! LoadHeaderOrSrcFile(force_h_cpp)
  let fnew = GetHeaderOrSrcFile(a:force_h_cpp)
  if strlen(fnew) != 0
    execute('edit ' . fnew)
  endif
endf

"An empty string is a failure
function! GetHeaderOrSrcFile(force_h_cpp)
  let extensions = 'h,ipp,cpp,c,h,'
  if (a:force_h_cpp)
    let extensions = 'h,cpp,h,'
  endif

  let oldmagic = &magic
  let &magic = 1

  let f_ext    = fnamemodify(bufname('%'), ':e')
  let f_root   = fnamemodify(bufname('%'), ':r')

  let result = ""
  let ext_begin = match(extensions, f_ext ) + 1

  while 1
    let ext_begin = match(extensions, ',', ext_begin ) + 1

    if ext_begin == 0
      break
    endif

    let ext_end = match(extensions, ',', ext_begin)
    let ext     = strpart(extensions, ext_begin, ext_end - ext_begin)
    let result  = f_root . '.' . ext

    if filereadable(result)
      break
    endif

    let result = ""
  endwhile

  let &magic = oldmagic
  return result
endfunction

function! CycleFonts(amount)
   if(has("unix"))
      let font_base ="Anonymous Pro"
   else
      let font_base = "Consolas"
   endif

   let sizes = [ 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36 ]

   let g:fontindex = g:fontindex + a:amount
   let g:fontindex = max([g:fontindex, 0])
   let g:fontindex = min([g:fontindex, len(sizes) - 1])
   if(has("unix"))
      let f = font_base . " " . sizes[g:fontindex]
   else
      let f = font_base . ":h" . sizes[g:fontindex]
   endif
   let &guifont = f
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  Move the setting of this to a machine specific file
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"fontindex is global for use in the CycleFonts() function
"but we won't reset the font if we've already started
if !exists("fontindex")
  if ( hostname() == 'debdesk' )
    let fontindex=2
  elseif ( hostname() == 'lus-rkerr' )
     let fontindex=2
  elseif ( hostname() == 'ramen' )
     let fontindex=3
  else
    let fontindex=0
  endif

  call CycleFonts(1)
endif



" @r prints a ruler across the screen that looks something like this:
" ....+....1....+....2....+..
map @r O<ESC>:call RulerStr()<NL>0P0j

function! RulerStr()
  let columns = &columns
  let inc = 0
  let str = ""
  while (inc < columns)
    let inc10 = inc / 10 + 1
    let buffer = "."
    if (inc10 > 9)
      let buffer = ""
    endif
    let str = str . "....+..." . buffer . inc10
    let inc = inc + 10
  endwhile
  let str = strpart(str, 0, columns)
  let @@ = str
endfunction


nn ,getfileotherwin :call GetFileInOtherWindow()<NL>
map <F4> ,getfileotherwin


nn ,getfilethiswin :call GetFileInThisWindow()<NL>
map <S-F4> ,getfilethiswin 


fun! GetFileInOtherWindow()
  call AddPath()
  "exe'norm'.nr2char(23).'f'
  let fname = expand('<cfile>')
  let v:errmsg = ""
  if NumWindows()>1
    exe'norm'.nr2char(23).'W'
    exe'find ' . fname
  else
    exe'sfind ' . fname
  endif
  if v:errmsg != ""
    exe'norm'.nr2char(12)
    exe'norm'.nr2char(23).'w'
    call confirm("File '" . fname . "' could not be found.\nAre you sure you're in the right directory?", "ok", 1 )
  endif
  call RestorePath()
endfun


fun! GetFileInThisWindow()
  "call AddPath()
  let v:errmsg = ""
  let fname = expand('<cfile>')
  silent! execute('find ' . fname)
  if v:errmsg != ""
    call confirm("File '" . fname . "' could not be found.\nAre you sure you're in the right directory?", "ok", 1 )
  endif
  "call RestorePath()
endfun


fun! AddPath()
  if g:pathShouldBeCorrected
    call RestorePath()
  endif
  let g:pathShouldBeCorrected = 1
  
  let g:oldPath = &path
  let pathadd = fnamemodify(bufname('%'), ':p')


  let pathadd1 = substitute(pathadd, 'src', 'include', '')
  let pathadd2 = substitute(pathadd, 'include', 'src', '')
  let pathToAdd = ""


  if pathadd == pathadd1 && pathadd == pathadd2
    return
  endif


  if isdirectory(pathadd1)
    let &path = &path . ',' . pathadd1
  endif
  if pathadd1 != pathadd2
    if isdirectory(pathadd2)
      let &path = &path . ',' . pathadd1
    endif
  endif
endfun


fun! RestorePath()
  if g:pathShouldBeCorrected != 0
    let g:pathShouldBeCorrected = 0
    let &path = g:oldPath
  endif
endfun


let oldPath = &path
let pathShouldBeCorrected = 0


fun! NumWindows()
  let i=1
  while (winbufnr(i) != -1)
    let i = i + 1
  endwhile
  return i-1
endfun


"leave this around because I might want to get number after ':'
function! GetSmartFilename_old()
  let i=col(".")
  let line=getline(".")
  let lower = i
  let higher = i-1
  let finished = 0


  while (lower > 0 && !finished)
    let cmpstr = strpart(line, lower-1, 1)
    if match(cmpstr, '[ <"]') >= 0
      let finished = 1
    else
      let lower = lower - 1
    endif
  endwhile


  let finished = 0
  while (higher <= strlen(line) && !finished)
    let cmpstr = strpart(line, higher, 1)
    if match(cmpstr, '[ >:"]') >= 0
      let finished = 1
    else
      let higher = higher + 1
    endif
  endwhile


  if (higher > lower) 
    return strpart(line, lower, higher-lower)
  else
    return ""
  end
endfunction




"one time settings only
if !exists("g:singleinit")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  Move some of this stuff to machine specific file
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   let &path = &path . "," . g:source_path
"
"  if has("win32") && isdirectory($MSVCDIR)
"    set path+=$MSVCDIR\Include
"    set path+=$MSVCDIR\SRC
"    set path+=$MSVCDIR\MFC\Include
"    set path+=$MSVCDIR\MFC\SRC
"  endif


  " Set up numbering for text files
  let i=0
  while (i<60)
    let &comments=&comments.',fb:'.i.'.'
    let &comments=&comments.',fb:'.i.':'
    let &comments=&comments.',fb:'.i.')'
    let i = i + 1
  endwhile
  
  " Some more text style bullets
  set comments+=fb:-
  set comments+=fb:--
endif

noremap <M-=> <C-A>
noremap <M--> <C-X>


map ,rnum r1jr2jr3jr4jr5jr6jr7jr8jr9
map ,rose mz:%s/Vec3/CVector3/ge<CR> :%s/^ \+//ge<CR> :%s/{.*}//ge<CR> :%s/;[^;]*$//ge<CR> :%s/\/\/.*$//ge<CR> :%s/^inline//ge<CR> :%s/\(^.*\) \([^ ]*\) *(\(.*\)$/\2(\3 : \1/e<CR> :%s/\([(,]\) *\([^,)]\+\) \+\([^,)]\+\) */\1 \3 : \2 /ge<CR>:noh<CR>`z 

map ,fixname :let @z = fnamemodify(bufname("%"), ":p:")<CR>:bd<CR>:e <C-R>z<CR>
map ,ea :set ea<CR>:set noea<CR>:<BS>
map ,go [<C-I>

set shm+=I
set shm+=a
let singleinit=1

"map ,print y:let @x = expand("%:p")<CR>:new<CR>P:let @z = substitute(tempname(), "tmp$", "cpp","")<CR>:w! <C-R>z<CR>:let @y = expand("%:p:h") .  "\\out.ps"<CR>:!a2ps -f7 --center-title="<C-R>x" -o <C-R>y <C-R>z<CR>:!<C-R>y<CR>:bd!<CR>:!del <C-R>z <C-R>y<CR> 
 map ,print y:let @x = expand("%:p")<CR>:new<CR>P:let @z = substitute(tempname(), "tmp$", "cpp","")<CR>:w! <C-R>z<CR>:!PRFILE32 %<CR>:!del <C-R>z<C-R>:bd!<CR>


map ,ubbq mz0I[quote]<ESC>$A[/quote]<ESC>`z
map ,ubbu mz0I[url="<C-V>"]<ESC>$A[/url]<ESC>`z

vmap ,ubbq "zxi[quote][/quote]<ESC>7h"zP
vmap ,ubbu "zxi[url="<C-V>"][/url]<ESC>5h"zP

"myfind . -name "name" -exec "egrep" "-n" "pattern" "{}" ";"
map ,err :let @z = tempname()<CR>:w! <C-R>z<CR>:cf %<CR>
map ,[I [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

unmap <C-A>
unmap <C-X>


map ,s1 :%!perl -S fixdata.pl<CR>
map ,s2 1G"_dG

" set makeprg=msdev\ C:\PROSIM\ProSim_VPS.dsw\ /make\ \"PROSIM\ -\ Win32\ Debug\"


"set errorformat=%f(%l):\.\*
"source $VIM\tagmenu.vim

map j gj
map k gk

" remap o and O to get rid of C++ style comments when opening a line
" above/below a comment
"nmap o o<ESC>xxa
"nmap O O<ESC>xxa
" Hrm, doesn't work... messes up indentation when opening on {

vmap * y/<C-R>"<CR>
vmap <C-J> j
"example of find, but not in a C++ comment:
"/^\s*\/\{,1}[^/]\{-}snafu/e

let g:explDetailedList=0
let g:explSuffixesLast=0

".bak,~,.o,.h,.info,.swp,.obj
set suffixes-=.h
set wildignore+=*~
let c_minlines=200


"set mp=como -A --no_microsoft -D_WCHAR_T_DEFINED -D_MSC_VER -D__cdecl=
set sp=2>

" Creates mv commands to rename files with %20 in their names to actual spaces
map ,mst  y$:s/%20/ /g<cr>imv "<esc>A"<esc>0whi <esc>pj0

fu! FindCurrentFunction(or_prev)
  let text =''

  let curcol  = col('.')
  let curline = line('.')

  let oldmagic = &magic
  let &magic = 1

  call cursor(curline+1, curcol)

  let operators='operator\s*\%((\s*)\|\[]\|[+*/%^&|~!=<>-]\|[+*/%^&|!<>=-]=\|[<>&|+-]\{2}\|>>=\|<<=\|->\*\|,\|->\|(\s*)\)\s*'
"  let func_string = '\%('.operators.'\|[[:alnum:]][[:alnum:]_]*\)\ze\s*('
  let class_func_string = '\([[:alpha:]_]\w*\s*::\s*\)*\%(\~\1\|'.operators
  let class_func_string = class_func_string . '\|[[:alnum:]][[:alnum:]_]*\)\ze\s*('

  let searchstring = '\_^\S.\{-}\%('.operators
  let searchstring = searchstring.'\|[[:alnum:]][[:alnum:]_]*\)\s*(.*\n\%(\_^\s.*\n\)*\_^{'

  let l = search(searchstring, 'bW')

  if l != 0
    let m = search('\_^}', 'W')
    if m >= curline || a:or_prev
      let line_text = getline(l)
      let matched_text = matchstr(line_text, class_func_string)
"      if (matched_text == '')
"        let matched_text = matchstr(line_text, func_string)
"      endif
      let matched_text = substitute(matched_text, '\s', '', 'g')
      let text = matched_text
    endif
  endif

  call cursor(curline, curcol)

  let &magic = oldmagic

  return text
endf
" Function to put curly braces around a selection
vmap <M-[> :call WrapCurlyBracketsVisual()<CR>mz[{=%`z

function! WrapCurlyBracketsVisual() range
  let line1 = a:firstline
  let line2 = a:lastline
  call append(line2, "}")
  call append(line1-1, "{")
endfun

" taglist configuration
nnoremap <silent> ,tlist :Tlist<CR>
nnoremap <silent> <F9> :Tlist<CR>
nnoremap <silent> <S-F9> :TlistSync<CR>
nnoremap <A-F9> 10<C-W>h

" TODO:  Move to machine specific file
if has("unix")
  let Tlist_Ctags_Cmd = '/usr/bin/ctags-exuberant'
else
  let Tlist_Ctags_Cmd = 'c:\vim\ctags.exe'
endif

let Tlist_Sort_Type = "name"
" let Tlist_Display_Prototype = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

" tags configuration
set tags=/home/rkerr/p4root/tags

if has("unix")
  :nmap ,t :!(cd %:p:h;ctags *.[ch])&
else
  :nmap ,t :!"cd %:p:h & ctags -V *"<CR>
endif

:nmap ,rtags :!"ctags -R --fields=+i -V -f C:\Development\project\tags C:\Development\project\*"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  Move browser locations to machine specific file
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save and preview the current file in firefox
map ,firefox :w<CR>:!"c:\Program Files\Mozilla Firefox\firefox.exe" %<CR>
map ,iexplorer :w<CR>:!"C:\Program Files\Internet Explorer\IEXPLORE.EXE" %<CR>
" Create HTML syntax highlighting from the current file, save it in a temp file, and launch it in firefox.
map ,ffpreview :TOhtml<NL>:execute ("saveas " . tempname())<CR>,firefox :q<CR>
map ,iepreview :TOhtml<NL>:execute ("saveas " . tempname() . ".html")<CR>,iexplorer :q<CR>

" Don't make me hit enter after compiling!!!
map ,make :make<CR><CR>


" Get rid of stupid Win32 specific mappings
if has("win32")
    unmap <C-Y>
endif

" Working on some new stuff for automatically using the error file
map ,rembrackets gg/^[<CR>V/^]<CR>dgg/^[<CR>V/^]<CR>d
function! CleanErrorFile()
  silent :%s/<.*>//ge
  silent g/.obj/de
  silent g/.lib/de
  silent g/Creating/de
  silent g/^$/de
  silent execute "normal ,rembrackets"
  "Look at FindCurrentFunction for ways to improve the searching and find the lines to delete
endfunction



" Recent stuff to play with
fun! ReverseRowsVisual() range
  let l1 = a:firstline
  let l2 = a:lastline
  call ReverseRows(l1,l2)
endfun

fun! ReverseRows(line1,line2)
  let l1 = a:line1
  let l2 = a:line2

  while l1<l2
    let s1 = getline(l1)
    let s2 = getline(l2)

    call setline(l1, s2)
    call setline(l2, s1)

    let l1 = l1 + 1
    let l2 = l2 - 1
  endwhile
endfun

vmap ,rev :call ReverseRowsVisual()<CR>


" put #if0 / #endif around selected lines of code
vmap ,if0 :call IfdefVisual()<CR>

fun! IfdefVisual() range
  call append(a:lastline, "#endif")
  call append(a:firstline-1, "#if 0")

  let str = "" . a:firstline . "," . (a:lastline+2) . "fold"
  exec str
endfun


" takes yanked function definition and creates the implementation for it
fun! PutPrependedFunc()
  let oldmagic = &magic
  let &magic = 1

  let classname = FindCurrentFunction(1)
  let classname = matchstr(classname, '\w\+\s*::')

  let multi_line = strtrans(@0) 
  let match_template = '\S\+\s*('

  let result = ""
  let lines=0

  while strlen(multi_line) > 0
    let single_line = matchstr(multi_line, '^.\{-}\(\^@\|$\)')
    let index = strlen(single_line)
    let single_line = substitute(single_line, '\^@', '', 'g')

    let result = result . "{{" . single_line . "}}\n"

    let multi_line  = strpart(multi_line, index)

    let single_line = substitute(single_line, '//.*$', '', '')
    let newfun = single_line
    let index = match(newfun, match_template)

    if match(single_line, '\S') != -1 && index != -1
      let newfun = strpart(newfun,0,index) . classname . strpart(newfun, index)
      "let newfun = substitute(newfun, match_template, classname.'&', "")
      let newfun = substitute(newfun, '\(virtual\|static\|;\)', "", "g")
      let newfun = substitute(newfun, "\s*=\s*[^),]*\ze[),]", "", "g")

      call append(line(".")-1, newfun)
      call append(line(".")-1, "{")
      call append(line(".")-1, "}")
      call append(line(".")-1, "")
      let lines=lines+4
    endif
  endwhile

  if (lines > 0)
    exec "normal =" . lines . "k"
  endif

  let &magic = oldmagic

endfun

map ,puf :call PutPrependedFunc()<CR>




" An idea to implement...
" map ,find :new<CR>:r!find . -iname *.cpp -exec grep -Hi <C-R>0 {} ;<CR>




" ----------------------------------------------------------------------------- 
"                       C++ Language helper functions
" ----------------------------------------------------------------------------- 

" C++ casts
map ,cshort  wbistatic_cast<short>(<ESC>ea)<ESC>
map ,cint    wbistatic_cast<int>(<ESC>ea)<ESC>
map ,cdouble wbistatic_cast<double>(<ESC>ea)<ESC>
map ,cfloat  wbistatic_cast<float>(<ESC>ea)<ESC>

" Swap the first & second variables in a comparison to make the constant first
map ,reif :s/if\s*(\s*\(.\{-\}\)\s*\([!=]=\)\s*\(.\{-\}\)\s*)/if(\3 \2 \1)/<CR>:nohl<CR>

" Comment out function parameter
map ,unp     ebi/*<ESC>ea*/<ESC>
map <F12> ,unp

" create a stub c++ program
map ,main :set ft=cpp<CR>I#include <iostream><CR><CR>namespace<CR>{<CR>}<CR><CR>int main()<CR>{<CR>}<CR><ESC>2k

" ----------------------------------------------------------------------------- 

" vim: nowrap
