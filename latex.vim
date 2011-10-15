let g:Tex_MultipleCompileFormats='pdf'

set spell

filetype plugin indent on
"let g:Tex_ViewRule_pdf = 'Preview'

" autoformatting
set textwidth=72 formatoptions=qntc

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
