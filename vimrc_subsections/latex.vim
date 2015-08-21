" ----------------------------------------------------------------------------- 
"                                LaTeX mappings
"
"  Just some shortcuts that I find useful for editing LaTeX files.
"
" ----------------------------------------------------------------------------- 
map ,dvi ,cd<CR>:!texify --clean --run-viewer %<CR>
"map ,pdf ,cd<CR>:!texify --clean --pdf --run-viewer  --tex-option=-shell-escape %<CR>
map ,pdf ,cd<CR>:!latexmk --pv --pdf -shell-escape %<CR>
map ,tt ebi\texttt{<ESC>ea}<ESC>
map ,tbf ebi\textbf{<ESC>ea}<ESC>
map ,tit ebi\textit{<ESC>ea}<ESC>


map ,ldoc :set ft=tex<CR>i\documentclass{article}<CR>\usepackage{times}<CR>\usepackage{graphicx}<CR>%\usepackage{hyperref}<CR><CR><CR>\title{}<CR>\author{Rex Kerr}<CR>\date{}<CR><CR><CR>\begin{document}<CR>\maketitle<CR>\tableofcontents<CR>\newpage<CR><CR>\section{}<CR><CR><CR><CR>\end{document}<ESC>14kba
map ,lfig i\begin{figure}[h]<CR>  \begin{center}<CR>  \includegraphics[width=.75\textwidth]{C:/filename.png}<CR>\caption{}<CR>\label{}<CR><BS><BS>\end{center}<CR><BS><BS>\end{figure}<ESC>4k$3bciw
"ab  lfig \begin{figure}[h]<CR>  \begin{center}<CR>  \includegraphics[width=.75\textwidth]{C:/filename.png}<CR>\caption{}<CR>\label{}<CR><BS><BS>\end{center}<CR><BS><BS>\end{figure}
map ,ltable i\begin{table}[!h]<CR>  \begin{tabular}{\|l\|l\|}<CR>

map ,lbullets i\begin{itemize}<CR>  \item <CR><BS><BS>\end{itemize}<ESC>k$A
ab  lbullets  \begin{itemize}<CR>  \item<CR><BS><BS>\end{itemize}<ESC>k$A
ab  lenumlist \begin{enumerate}<CR>  \item<CR><BS><BS>\end{enumerate}<ESC>k$A

ab lltrow \multicolumn{2}{\|l\|} {heading} \\ \nopagebreak<CR>& \\<CR>\hline<ESC>kk$F{ci{

