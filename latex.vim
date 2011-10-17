let g:Tex_MultipleCompileFormats='pdf'
"let g:Tex_ViewRule_pdf = 'Preview'

set spell
set textwidth=72
set formatoptions=qntc

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
