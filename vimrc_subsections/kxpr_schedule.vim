"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Just a silly little bit of vimrc hacking I did years ago...
"
" The local NPR classical station used to have a website that 
" showed which songs they were going to play, and at what time.  
" They were usually accurate to within a minute.
"
" This script would make a small window, download that file, munge 
" its format, and then periodically update its position to show me 
" the 'now playing' for the station.
"
" Apparently something changed such that they weren't legally 
" allowed to provide their schedule up front anymore, so this no
" longer works...
"
" I'm not proud of the code, it's ugly, but it worked. :-)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ,sched :call KXPRSchedule()<cr>

fun! KXPRSchedule()
  let plurl = "http://www.capradio.org/programs/classicalmusic/default.aspx?ShowDate=" . strftime("%m/%d/%Y")
  silent execute(":Nread " . plurl)

  colorscheme ron
  set laststatus=0  " Get rid of the statusbar
  set guioptions-=T " Get rid of the toolbar
  set guioptions-=m " Get rid of the menu
  set lines=6

  silent :v/<a id.\{-}songid=[0-9]*">\(.\{-}\)<\/a>\|<span.\{-}\(ShowDate"\|strpt__ctl[0-9]*_lblTime1"\)>.\{-}<\/span>/d
  silent :%s/.\{-}<a id.\{-}songid=[0-9]*">\(.\{-}\)<\/a>.*/\1/
  silent :%s/.\{-}<span.\{-}>\(.\{-}\)<\/span>.*/\1/
  silent :%s/\(^[0-9]:\)/0\1/g
  silent :%s/\(^[0-9]\{2}:[0-9]\{2}\)a/\1 AM/g
  silent :%s/\(^[0-9]\{2}:[0-9]\{2}\)p/\1 PM/g
  silent :%s/\(^[A-Za-z]\)/  \1/
  " silent :%s/\(^[0-9:]*\)p/\1 PM/g
  execute(":0")

  " Set the titlebar so that we can identify this window
  set titlestring=CPR_Playlist
  set title
  redraw

  while 1
     let repeat = 1
     let loopcounter = 0
     let currentminute = strftime("%M")
     let currenthour = strftime("%I")
     let ampm = strftime("%p")

     while (repeat != 0 && loopcounter < 50)
        let findstring = currenthour . ":"
        
        if(currentminute < 10)
          let findstring = findstring . "0"
        endif
          
        let findstring = findstring . currentminute . " " . ampm

        try
           execute(":0")
           execute("/" . findstring)
           execute("normal zt")
           let repeat = 0
        catch
          let repeat = 1
        endtry

        if currentminute == 0
          let currentminute = 59
          let currenthour = currenthour - 1
          if currenthour == 0
            let currenthour = 12
            if ampm == "AM"
              let ampm = "PM"
            else
              let ampm = "AM"
            endif
          endif
        else
          let currentminute = currentminute - 1
        endif

        let loopcounter = loopcounter + 1
     endwhile

     redraw
     sleep 10
   endwhile

endfun
