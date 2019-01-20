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
" S-F5: Unused
" M-F5: Change to project root (based on current file)
"
" F6: Swap header/source
" S-F6: Swap header/source (h/cpp only)
"
" F7: Not used
"
" F8: Comment out selection, or current line
" S-F8: Uncomment out selection, or current line
" M-F8: I forget, what's different here?
"
" F9:   Unused
" S-F9: Unused
" M-F9: Unused
"
" F10:  Unused
"
" F11: Go to next error
" S-F11: go to previous error
" M-F11: Next error in next file
" M-F11: Previous error in previous file
"
" Deprecated... reused
" F12: Save file
" S-F12: Revert
" M-F12: Reload (built in)

scriptencoding utf-8
set encoding=utf-8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  Clean up old settings in case we're reloading...
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
mapc                         " remove all previous mappings
abc                          " remove all previous abbreviations

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  Load machine specific settings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let host_config_file=$HOME."/.vimrc_host.vim"
if !filereadable(host_config_file)
   echo "Creating a template machine_specific configuration file in ".$HOME

   let host_config_lines=[]
   let host_config_lines=host_config_lines+["\"-------- fonts --------"]

   if(has("mac"))
      let host_config_lines=host_config_lines+["let font_base=\"Monaco\""]
   elseif(has("unix"))
      let host_config_lines=host_config_lines+["let font_base=\"Ubuntu Mono\""]
   else
      let host_config_lines=host_config_lines+["let font_base=\"Consolas\""]
   endif

   let host_config_lines=host_config_lines+["let initialfontindex=2"]
   let host_config_lines=host_config_lines+[""]
   let host_config_lines=host_config_lines+["\"-------- other --------"]
   let host_config_lines=host_config_lines+["let defaultprojectconfig=$HOME.\"/.vim/projects/default\""]
   let host_config_lines=host_config_lines+[""]
   let host_config_lines=host_config_lines+["\"---------- plugins ---------"]
   let host_config_lines=host_config_lines+["set runtimepath^=~/.vim/bundle/Align"]
   let host_config_lines=host_config_lines+["set runtimepath^=~/.vim/bundle/ctrlp.vim"]
   let host_config_lines=host_config_lines+["set runtimepath^=~/.vim/bundle/vim-abolish"]
   let host_config_lines=host_config_lines+["set runtimepath^=~/.vim/bundle/vim-vinegar"]
   let host_config_lines=host_config_lines+[""]
   let host_config_lines=host_config_lines+["let g:ctrlp_regexp = 1"]
   let host_config_lines=host_config_lines+[""]
   let host_config_lines=host_config_lines+["\"---------- consider moving to project config ---------"]
   let host_config_lines=host_config_lines+["\" set makeprg=ninja\ -C\ <<project build folder>>"]
   let host_config_lines=host_config_lines+[""]
   let host_config_lines=host_config_lines+["\" let g:projectRoot=\"<<project source root folder>>\""]
   let host_config_lines=host_config_lines+["\" let g:projectName=\"<<project name>>\""]
   let host_config_lines=host_config_lines+["\" let g:companyName=\"<<company name>>\""]

   call writefile(host_config_lines, host_config_file)
endif

exec ":source ".host_config_file

if filereadable(defaultprojectconfig)
   exec ":source ".defaultprojectconfig
endif




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
set number                   " Always show line numbers
set swb=useopen              " switchbuf, use already open buffer in current tab
set nrformats+=alpha         " Used with CTRL-A and CTRL-X to increment and decrement the letter under the cursor
set nrformats-=octal         " Used with CTRL-A and CTRL-X to increment and decrement the letter under the cursor
syntax on                    " Syntax highlighting
set hlsearch                 " Highlight Search, highlight all matches when searching
set is                       " Incremental Search (show next search result as you type it
set linebreak                " Cause wrap to wrap in a sane way (break on word, rather than mid-word)
set nowrap                   " Don't wrap lines by default
set showcmd                  " Show how many lines/characters are selected in visual mode [off by default in mvim]
set showbreak=\ \ >>>\       " Characters to show on edges of wrapped lines
set textwidth=0              " never wrap on paste
set scrolloff=5              " Keep some lines above/below the cursor when scrolling
set grepprg=rg\ --vimgrep    " Use ripgrep

" Write grep/make output to a file for faster I/O
if has("unix")
set shellpipe=2>&1\|tee\ ~/.vim/shellpipe.txt\ %s\ >\ /dev/null
endif

inoremap jk <esc>
inoremap kj <esc>

let comment_string=""
set nolisp

set visualbell


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  This whole augroup block is really old... there are better
"        ways to do this now with filetype plugins... need to research
"        and refactor.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup quixfix
    " automatically open cwindow after grep/make
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow 10
    autocmd QuickFixCmdPost l*    lwindow 10
augroup END

augroup aft
  au BufWrite,BufNewFile,BufRead,BufEnter *.aft set noet
augroup END

augroup cprog
  au!
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set list
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set nolisp
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set filetype=cpp syntax=cpp.doxygen
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set formatoptions=crql cindent comments=sr:/*,mb:*,el:*/,:///,:// isk-=$
  au BufWrite,BufNewFile,Bufread,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc let comment_string = "//"
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set cinkeys=0{,0},:,0#,!^F,o,O,e
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc let c_no_curly_error=1
  au BufWrite,BufNewFile,BufRead,BufEnter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc set foldcolumn=3
  au bufwrite,bufnewfile,bufread,bufenter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc syntax match dangerous_stuff "scoped_lock\s*(\|QMutexLocker\s*(\|\(unique_lock\|lock_guard\)\s*<.*>\s*("
  au bufwrite,bufnewfile,bufread,bufenter *.hpp,*.h,*.c,*.cpp,*.ipp,*.icc highlight Dangerous_Stuff ctermbg=red guibg=#FF0000 gui=bold
  au BufWrite,BufNewFile,Bufread,BufEnter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match RKTEMP ".*RK\(ERR\)\=\s*TEMP.*"
  au BufWrite,BufNewFile,Bufread,BufEnter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight RKTEMP  ctermbg=darkmagenta ctermfg=white guibg=#6F1DF2 gui=bold guifg=#000000
  au BufWrite,BufNewFile,Bufread,BufEnter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match RKTODO ".*RK\(ERR\)\=\s*TODO.*"
  au BufWrite,BufNewFile,Bufread,BufEnter *.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight RKTODO  ctermbg=darkyellow ctermfg=white guibg=#444400 gui=bold guifg=#000000
augroup END

augroup cmake
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter CMakeLists.txt,*.cmake let comment_string="#"
  au BufWrite,BufNewFile,Bufread,BufEnter CMakeLists.txt,*.cmake set comments=:#
augroup END

augroup Perl
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm set isk+=$
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm let comment_string = "#"
  au BufWrite,BufNewFile,Bufread,BufEnter *.pl,*.pm set cinkeys="0{,0},:,!^F,o,O,e"
  au BufWrite,BufNewFile,BufRead,BufEnter *.pl,*.pm set formatoptions=crql cindent
augroup END

augroup pyc
    " Ooops... opened that stupid pyc file again in the file browser... no problem!
    au! 
    au BufRead *.pyc exec ':edit ' . substitute(bufname("%"), "\.pyc", ".py", "")
augroup END

augroup Python
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.py set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.py set ft=python  " for some reason I sometimes don't get syntax highlighting, especially after the *.pyc autocmd
  au BufWrite,BufNewFile,Bufread,BufEnter *.py inoremap <buffer> # X<BS>#
  au BufWrite,BufNewFile,BufRead,BufEnter *.py set nocindent smartindent
  au BufWrite,BufNewFile,BufRead,BufEnter *.py set shiftwidth=4 softtabstop=4 tabstop=4 expandtab 
  au BufWrite,BufNewFile,BufRead,BufEnter *.py set cinwords=if,elif,else,for,while,try,except,finally,def,class
  au BufWrite,BufNewFile,Bufread,BufEnter *.py set formatoptions=crq2
  au BufWrite,BufNewFile,Bufread,BufEnter *.py let comment_string = "#"
  au BufWrite,BufNewFile,Bufread,BufEnter,FileType python setlocal equalprg=autopep8\ -
augroup END

augroup json
  au!
  au BufWrite,BufNewFile,BufRead,BufEnter,FileType json setlocal equalprg=python\ -m\ json.tool
augroup END

augroup Vimrc
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter _vimrc,.vimrc,*.vim set nolisp
  au BufWrite,BufNewFile,Bufread,BufEnter _vimrc,.vimrc,*.vim let comment_string = "\""
augroup END

augroup Lisp
  au!
  au BufWrite,BufNewFile,Bufread,BufEnter *.lsp,*.lisp,*.cl,*.el set lisp
  au BufWrite,BufNewFile,Bufread,BufEnter *.lsp,*.lisp,*.cl,*.el let comment_string = ";"
augroup END

augroup Latex
   au!
   au BufWrite,BufNewFile,Bufread,BufEnter *.tex set foldmethod=marker
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex let comment_string = "%"
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex syntax match texUseProperTags "etc[^\}]\|\.\.\.\|etc"
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex highlight texUseProperTags guibg=#D00000 guifg=White
   au BufWrite,BufNewFile,BufRead,BufEnter *.tex set spell
augroup END

augroup LogFiles
   au!
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGWARN ".*<WARN\s\+.*"
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGERROR ".*<ERROR.*"
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGFATAL ".*<FATAL.*"
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* syntax match VLOGTEMP  ".*RKTEMP:.*"

   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGWARN guibg=#FFE900 guifg=#000000
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGERROR guibg=#F77B7D guifg=#000000
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGFATAL guibg=#FF0000 gui=bold guifg=#000000
   au BufWrite,BufNewFile,Bufread,BufEnter *.log,*.log.* highlight VLOGTEMP  guibg=#6F1DF2 gui=bold guifg=#000000
augroup END

augroup qml
  au!
  "au FileType * set formatoptions=tcq nocindent comments&
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml set nolisp
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml set filetype=javascript syntax=javascript
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml set formatoptions=crql cindent comments=sr:/*,mb:*,el:*/,:///,:// isk-=$
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml set cindent
  au BufWrite,BufNewFile,Bufread,BufEnter *.qml let comment_string = "//"
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml set cinkeys=0{,0},:,0#,!^F,o,O,e
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml let c_no_curly_error=1
  au BufWrite,BufNewFile,BufRead,BufEnter *.qml set foldcolumn=3
  au BufWrite,BufNewFile,Bufread,BufEnter *.qml syntax match RKTEMP ".*RK\(ERR\)\=\s*TEMP.*"
  au BufWrite,BufNewFile,Bufread,BufEnter *.qml highlight RKTEMP  ctermbg=darkmagenta ctermfg=white guibg=#6F1DF2 gui=bold guifg=#000000
augroup END

augroup vim_behavior
   au!
   au BufEnter,VimResized * call AutoResize()
augroup END

map <silent> ,ar :call ToggleAutoResize()<CR>

let g:autoResize = 0

fun! ToggleAutoResize()
   if g:autoResize > 0
      let g:autoResize = 0
      set equalalways
      exe "normal \<c-w>="
   else 
      let g:autoResize = 1
      set noequalalways
      call AutoResize()
   endif 

   echo 'Auto Resize:  '.(g:autoResize?"ON":"OFF")
endfun

fun! AutoResize()
   " Don't auto resize if equalalways is on...
   if !&ea && g:autoResize
      exe "normal \<c-w>_\<c-w>\|"
   endif
endfun


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

"Toggle highlighting of stray whitespace
map <silent> ,ws :call ToggleHightlightStrayWS()<CR>

let g:HighlightStrayWhitespace=1

fun! ToggleHightlightStrayWS()
   if g:HighlightStrayWhitespace > 0
      let g:HighlightStrayWhitespace = 0
   else 
      let g:HighlightStrayWhitespace = 1
   endif 

   call UpdateWSHighlights()

   echo 'Highlight Stray WS:  '.(g:HighlightStrayWhitespace?"ON":"OFF")
endfun

fun! UpdateWSHighlights()
   if g:HighlightStrayWhitespace > 0
      au bufwrite,bufnewfile,bufread,bufenter *.py,*.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match straytabs "\t"
      au bufwrite,bufnewfile,bufread,bufenter *.py,*.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax match strayspaces "\s\+$"
      au bufwrite,bufnewfile,bufread,bufenter *.py,*.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight StrayTabs guibg=#454545 gui=bold
      au bufwrite,bufnewfile,bufread,bufenter *.py,*.h,*.c,*.cpp,*.pl,*.ipp,*.icc highlight StraySpaces guibg=#353030 gui=bold

      syntax match straytabs "\t"
      syntax match strayspaces "\s\+$"
      highlight StrayTabs guibg=#454545 gui=bold
      highlight StraySpaces guibg=#353030 gui=bold
   else
      au bufwrite,bufnewfile,bufread,bufenter *.py,*.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax clear straytabs
      au bufwrite,bufnewfile,bufread,bufenter *.py,*.h,*.c,*.cpp,*.pl,*.ipp,*.icc syntax clear strayspaces

      syntax clear straytabs
      syntax clear strayspaces
   endif
endfun

call UpdateWSHighlights()


" Make the statusline red for read-only files and blue for read-write files -- also makes the filename on the tab red
au BufNew,BufAdd,BufWrite,BufNewFile,BufRead,BufEnter,FileChangedRO * :if &ro | hi StatusLine guifg=Red guibg=black ctermbg=black ctermfg=red | :else | hi StatusLine guibg=White guifg=blue ctermbg=white ctermfg=blue | endif 
au BufNew,BufAdd,BufWrite,BufNewFile,BufRead,BufEnter,FileChangedRO * :if &ro | hi TabLineSel guifg=Red ctermfg=red | :else | hi TabLineSel guifg=gray ctermfg=gray | endif 

map ,python :!python %<CR>

" Make * search for the entire highlighted string when in visual select mode, rather than just the word under the cursor
vmap <silent> * y/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '\\n', 'g')<CR><CR>

map <C-A> ggVG
map ,all mzggVG"*y`z

map ,fo V%:fo<CR>
vmap ,fo %:fo<CR>

" Set up the statusline (stl)
set stl=%f%h%m%r\ %{Options()}%=%l,%c%V\ %{line('$')}
"" augroup statusline
""    au!
""    au BufEnter,VimResized * call UpdateStatusline()
"" augroup END
"" 
"" function! UpdateStatusline()
""    if(winwidth(0) > 50)
""       set stl=%f%h%m%r\ %{Options()}%=%l,%c%V\ %{line('$')}
""    else
""       " set stl=%f%h%m%r\ %{Options()}%=%l,%c%V\ %{line('$')}
""       set stl=%f%h%m%r\ %y%=%l,%c%V\ %{line('$')}
""    endif
"" endfun

fu! Options()
  let opt="ai".PlusOpt(&ai)
  let opt=opt." rap".PlusOpt(&wrap)
  let opt=opt." ic".PlusOpt(&ic)
  let opt=opt." et".PlusOpt(&et)
  let opt=opt." ar".(g:autoResize?"+":"-")
  let opt=opt." sp".PlusOpt(&spell)
  let opt=opt." ".&ff
  let opt=opt." ".&ft

  if &ft==?"cpp" || &ft==?"perl"
    let text=" {f:" . FindCurrentFunction(0) . "}"
    let opt=opt.text
  endif

  if exists("g:projectName")
    let text=" {p:" . g:projectName . "}"
    let opt=opt.text
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

set listchars=trail:·,precedes:<,extends:>,tab:→\ 

map ,fdos :set fileformat=dos<NL>
map ,funix :set fileformat=unix<NL>

" copy the full filename into the system clipboard
map ,fname :let @+ = fnamemodify(bufname("%"), ":p:")<CR>:<BS>

map ,path :let @+ = fnamemodify(bufname("%"), ":p:h")<CR>:<BS>

map ,ym :let @* = matchstr(getline("."), @/)<CR>:<BS>

if(has("mac") || has("unix"))
    set dir=~/.vim/vimswap
    set bdir=~/.vim/vimswap
    set udir=~/.vim/vimswap
    if(!isdirectory(&dir))
        silent! execute("!mkdir -p " . &dir)
    endif
else
    set dir=$TEMP\vimswap
    set bdir=$TEMP\vimswap
    if(!isdirectory(&dir))
        silent! execute("!mkdir " . &dir)
    endif
endif


set shiftwidth=4
set tabstop=4
set showmatch     " briefly jump to matching bracket
set expandtab     " replace tabs with spaces
set nowrapscan    " don't search past end of file
set ignorecase
set autoindent
set backspace=2   "  =indent,eol,start
set laststatus=2  " always show status line on last window
set cmdheight=2   " number of lines for cmd wndow
set cinoptions=g0 " scope declarations at column 0 of class

map ,cd :call ConditionalCD()<CR>
map <F5> ,cd
map <M-F5> :call ProjectRootCD()<CR>
map <F11> :cn<CR>
map <s-f11> :cp<CR>
map <m-F11> :cnf<CR>
map <m-s-F11> :cpf<CR>

fun! ConditionalCD()
  let folder=expand("%:p:h")
  if (folder != "")
    exec("cd ".folder)
    echo "pwd is now:  ".folder
  else
    :echohl WarningMsg | echo "Unable to determine path of current file." | echohl None
  endif
endfun

fun! ProjectRootCD()
    let folder = FindGitRoot()
    if(folder == "")
        if !exists("g:projectRoot")
            :echohl WarningMsg | echo "Unable to find project root (set default in hosts as g:projectRoot)." | echohl None
            return
        else
            let folder=g:projectRoot
        endif
    endif

    exec("cd ".folder)
    echo "Changed to project root folder:  ".folder
endfun

map ,explorer :call LaunchExplorerPWD()<CR>

fun! LaunchExplorerPWD()
   silent exec("!explorer %:p:h")
endfun


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" TODO:  This stuff should probably go in the .gvimrc...
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> :call CycleFonts(1)<CR>
map <S-F2> :call CycleFonts(-1)<CR>
map <M-F2> :let fontindex=g:initialfontindex<CR>:call CycleFonts(0)<CR>
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

" make current window 5 taller or shorter
map ,5 <C-W>5+
map ,% <C-W>5-

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
map ,ahk :e $USERPROFILE\DOCUMENTS\AutoHotkey.ahk<CR>:set ft=autohotkey<CR>

" Swap the word under the cursor with the current buffer
map ,sw ciw<C-R>0<ESC>

" Sort the selected lines
vmap ,s :!sort<CR>

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

" Creates a row of === below the current line, same length as line
map ,= yyp:s/[^=]/=/ge<NL>:noh<NL>

"map ,:: O<ESC>"%p$?\.<NL>Dbd0A::<ESC>gJ:noh<NL>
map ,:: :let @" = expand("%:r") . "::"<CR>:<BS>P
map ,iifdef ggO<ESC>"%p$?\.<NL>Dbd00gU$A_H_<ESC>:r!uuidgen<CR>kgJviWUviW:s/-/_/g<CR>,ifdef<NL>:noh<NL>:g/pragma\s*once/d<CR>
map ,ifdef mzyyppkkI#ifndef <ESC>jI#define <ESC>jI#endif // <ESC>ddGo<ESC>po<ESC>`z:noh<NL>

" Include my header:  Add a #include for the matching header to the top of a cpp file
map ,imh :0<CR>O#include "<C-R>=expand("%:t:r")<CR>.h"<ESC>

" Include my Qt MOC:  Add a #include for the matching Qt moc to the bottom of a cpp file (for unit tests, etc)
map ,imm Go<CR>#include "<C-R>=expand("%:t:r")<CR>.moc"<CR><ESC>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful python header stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ,pyhead ggO#!/usr/bin/python<CR># -*- coding: utf-8 -*-<ESC>
ab pyhead #!/usr/bin/python<CR># -*- coding: utf-8 -*-



"imap <M-[> {<ESC>mza<NL>}<ESC>`za<NL>
if(has("mac"))
   imap <D-[> {<NL>}<ESC>O
else
   imap <M-[> {<NL>}<ESC>O
endif


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

map ,cw <ESC>mzggO<c-r>=comment_string<CR> Copyright (c) <c-r>=strftime("%Y")<cr>, <c-r>=g:companyName<cr>, All Rights Reserved<ESC>`z

" this will be overwritten by the .gvimrc if using gvim to change the colorscheme instead
map ,light :let &background="light"<CR>
map ,dark :let &background="dark"<CR>

" Abbrevations
func! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

" Remember... <ctrl-v><space> to actually type these things w/o expansion
iabbr <silent> vptr vtkSmartPointer<C-R>=Eatchar('\s')<CR>
iabbr <silent> cdcast dynamic_cast<C-R>=Eatchar('\s')<CR>
iabbr <silent> cscast static_cast<C-R>=Eatchar('\s')<CR>
iabbr <silent> crcast reinterpret_cast<C-R>=Eatchar('\s')<CR>
iabbr <silent> qdcast qSharedPointerDynamicCast<C-R>=Eatchar('\s')<CR>
iabbr <silent> qscast qSharedPointerCast<C-R>=Eatchar('\s')<CR>

map ,dos2unix mz:%s/<C-Q><C-M>$//g<NL>:noh<NL>`z
"map ,tblfmt :perl -S tblfmt.pl "FS=," "OFS= | "


map ,et :call ToggleOption("expandtab")<NL><C-L>
map ,ic :call ToggleOption("ignorecase")<NL><C-L>
map ,ai :call ToggleOption("autoindent")<NL><C-L>
map ,rap :call ToggleOption("wrap")<NL><C-L>
map ,nu :call ToggleOption("number")<NL><C-L>
map ,cuc : call ToggleOption("cuc")<NL><C-L>
map ,cul : call ToggleOption("cul")<NL><C-L>
map ,sp :call ToggleOption("spell")<NL><C-L>


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

    " file wasn't readable, try replacing Inc w/ Src and Src w/ Inc
    "  -- quick and dirty implementation...  I'm sure I could do something
    "     cleaner if I wanted to think about it
    let result = substitute(result, 'Inc', 'Src', '')

    if filereadable(result)
      break
    endif

    let result = substitute(result, 'Src', 'Inc', '')

    if filereadable(result)
      break
    endif

    let result = ""
  endwhile

  let &magic = oldmagic
  return result
endfunction

function! CycleFonts(amount)
   let sizes = [ 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36 ]

   let g:fontindex = g:fontindex + a:amount
   let g:fontindex = max([g:fontindex, 0])
   let g:fontindex = min([g:fontindex, len(sizes) - 1])

   if(has("mac"))
      let f = g:font_base . ":h" . sizes[g:fontindex]
   elseif(has("unix"))
      let f = g:font_base . " " . sizes[g:fontindex]
   else
      let f = g:font_base . ":h" . sizes[g:fontindex]
   endif

   let &guifont = f
endfunction

"fontindex is global for use in the CycleFonts() function
"but we won't reset the font if we've already started
if !exists("fontindex")
  let fontindex=g:initialfontindex
  call CycleFonts(0)
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


map ,fixname :let @z = fnamemodify(bufname("%"), ":p:")<CR>:bd<CR>:e <C-R>z<CR>
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

map ,err :let @z = tempname()<CR>:w! <C-R>z<CR>:cf %<CR>
map ,[I [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

unmap <C-A>
unmap <C-X>

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

".bak,~,.o,.h,.info,.swp,.obj
set suffixes-=.h
set wildignore+=*~

" Minimum number of lines to search backwards for syntax highlighting context
"       http://vim.wikia.com/wiki/Fix_syntax_highlighting
let c_minlines=500


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
if(has("mac"))
   vmap <D-[> :call WrapCurlyBracketsVisual()<CR>mz[{=%`z
else
   vmap <M-[> :call WrapCurlyBracketsVisual()<CR>mz[{=%`z
endif

function! WrapCurlyBracketsVisual() range
  let line1 = a:firstline
  let line2 = a:lastline
  call append(line2, "}")
  call append(line1-1, "{")
endfun

" tags configuration
set tags=./tags;

if has("unix")
  :nmap ,t :!(cd %:p:h;ctags *.[ch])&
else
  :nmap ,t :!"cd %:p:h & ctags -V *"<CR>
endif

:nmap ,rtags :call GenRTags()<CR>

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

" selects most recently put text:
"     http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" takes yanked function definition and creates the implementation for it
fun! PutPrependedFunc()
  let oldmagic = &magic
  let &magic = 1

  let classname = FindCurrentFunction(1)
  let classname = matchstr(classname, '\s*\w\+\s*::')

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
      let newfun = substitute(newfun, '\(override\|virtual\|static\|;\)', "", "g")
      let newfun = substitute(newfun, "\s*=\s*[^),]*\ze[),]", "", "g")

      call append(line(".")-1, newfun)
      call append(line(".")-1, "{")
      call append(line(".")-1, "    // RKERR TODO:  Implement")
      call append(line(".")-1, "}")
      call append(line(".")-1, "")
      let lines=lines+5
    endif
  endwhile

  if (lines > 0)
    exec "normal =" . lines . "k"
  endif

  let &magic = oldmagic

endfun

map ,puf :call PutPrependedFunc()<CR>


" -----------------------------------------------------------------------------
"                                 git stuff
" -----------------------------------------------------------------------------
map ,gdt !git difftool -d %<CR>

" copy the relative path and filename of the current file, relative to the gitroot

map ,gname :call FilenameGitRelative()<CR>

" -----------------------------------------------------------------------------
"                                GDB helpers
" -----------------------------------------------------------------------------
" break here: puts command to add breakpoint command for the current file and line in the clipboard
map ,bh :let @+ = 'b '.fnamemodify(bufname("%"), ":p:").':'.line('.')<CR>:<BS>
map ,bf :let @+ = 'rb '.FindCurrentFunction(0)<CR>:echo @+<CR>


" -----------------------------------------------------------------------------
" Create a TODO comment in the form of 
"
"      // TODO JIRA-1234 : 
"
" Assumes that the current folder is a git branch named after a Jira task.
"
" -----------------------------------------------------------------------------
fun! TaskTodoFunc()
   let taskid = GetJiraTaskID()
   let comment = g:comment_string . ' TODO ' . taskid . ': '

   put! =comment
   exec "normal =="

   startinsert!
endfun

" Create a todo with task ID
map ,do :call TaskTodoFunc()<CR>

fun! FindTaskTodos()
   call ProjectRootCD()

   let taskid = GetJiraTaskID()

   exec ":grep \"".taskid."\""
endfun

map ,ft :call FindTaskTodos()<CR><CR>

" -----------------------------------------------------------------------------
"                       grep searches for current word
" -----------------------------------------------------------------------------
:nnoremap gr :call ProjectRootCD()<CR>:grep '\b<cword>\b'<CR><CR>
:nnoremap sgr :call ProjectRootCD()<CR>:grep -g "*.h" -g "*.cpp" '\b<cword>\b'<CR><CR>

" -----------------------------------------------------------------------------
"                              equalprg formatters
" -----------------------------------------------------------------------------
map ,fjson :setlocal equalprg=python\ -m\ json.tool<CR>
map ,fpy :setlocal equalprg=autopep8\ -<CR>



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

" create a stub bash script
map ,bscript :set ft=sh<CR>I#/usr/bin/env bash<CR><CR>Usage() {<CR>cat << USAGE<CR>Usage:  $(basename $0) [-h]<CR>  -h: This help<CR><C-U>USAGE<CR>}<CR><CR>while getopts "h" opt ; do<CR>case $opt in<CR>h) Usage; exit 0;;<CR>*) Fail "Unrecognized option";;<CR>esac<CR>done<CR>shift $((OPTIND - 1))<CR><CR><ESC>


" -----------------------------------------------------------------------------

fun! SelectProjectConfig()
   let projectfiles=globpath($HOME."/.vim/projects/","*")
   if(projectfiles=='')
      call confirm("No project files to load!", "ok", 1)
   else
      let selectedproject=confirm("Which project would you like to load?", projectfiles, 1, "Question")

      if(selectedproject != 0)
         let projects=split(projectfiles,"\n")
         exec ":source ".projects[selectedproject - 1]
      else
         echo "Fine, be that way... I'll leave the project settings alone!"
      endif
   endif
endfun

map ,proj :call SelectProjectConfig()<CR>


fun! FindGitRoot()
    let gitfolder=expand("%:p:h")

    while(!isdirectory(gitfolder."/.git"))
        if(gitfolder == "" || gitfolder == $HOME)
            return ""
        endif

        let gitfolder = fnamemodify(gitfolder, ':h')
    endwhile

    return gitfolder
endfun

fun! FilenameGitRelative()
    let gitpath  = FindGitRoot()
    let fullpath = fnamemodify(bufname("%"), ":p:")

    let @+ = substitute(fullpath, gitpath."/", '', '')
endfun

fun! GenRTags()
    let folder = FindGitRoot()
    if(folder == "")
        :echohl WarningMsg | echo "Unable to find project root" | echohl None
        return
    endif

    echo "Generating tags in:  ".folder
    silent exec("!ctags -R --fields=+i -f ".folder."/tags ".folder."/*" )
    echo "Done generating tags in:  ".folder
endfun

fun! GetJiraTaskID()
    let branch = substitute(system('git symbolic-ref -q HEAD'), 'refs/heads/', '', '')
    let taskid = substitute(branch, '^\([A-Z]\+-[0-9]\+\)*.*', '\1', '')
    return taskid
endfun

