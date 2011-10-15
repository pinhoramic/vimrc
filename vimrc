
" pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible         " not compatible with the old-fashion vi mode, must be first
set history=50					 " sets how many lines of history VIM has to remember
set autoread             " set to auto read when a file is changed from the outside

filetype on
filetype plugin on
filetype indent on

let mapleader = ","
let g:mapleader = ","

" Fast saving
"nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" when vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set number                " always show line number
"set showcmd		           " display incomplete commands

" for all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7                 " set 7 lines to the curors - when moving vertical..
set wildmenu             " turn on wild menu
set wildchar=<TAB>       " start wild expansion in the command line using <TAB>
set ruler                " always show current position
set cmdheight=2          " the commandbar height
set hid                  " change buffer without saving

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase           " ignore case when searching
set smartcase

set hlsearch             " highlight search things
set incsearch            " make search act like search in modern browsers
set nolazyredraw         " don't redraw while executing macros 

set magic                " set magic on, for regular expressions

set showmatch            " show matching bracets when text indicator is over them
set showmode             " show current mode
set mat=2                " how many tenths of a second to blink

" no sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable            " enable syntax hl

set gfn=Monaco:h12
set shell=/bin/bash
set background=dark

if has("gui_running")
  "set guioptions-=T
  set t_Co=256
  set cursorline         " highlight current line
else
endif
colorscheme ir_black

set encoding=utf8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
try
	set undodir=~/.vim/undodir
	set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

au FileType Makefile set noexpandtab

set lbr
set tw=500

set autoindent            " auto indent
set copyindent		        " copy the previous indentation on autoindenting
set smartindent           " smart indet
set wrap                  " wrap lines


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
set laststatus=2          " always hide the statusline

" format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ path:\ %r%{CurDir()}%h\ \ \ line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
"map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  if g:cmd == g:cmd_edited
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
"map <leader>bd :Bclose<cr>

" Close all the buffers
"map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

"command! Bclose call <SID>BufcloseCloseIt()
"function! <SID>BufcloseCloseIt()
"   let l:currentBufNum = bufnr("%")
"   let l:alternateBufNum = bufnr("#")
"
"   if buflisted(l:alternateBufNum)
"     buffer #
"   else
"     bnext
"   endif
"
"   if bufnr("%") == l:currentBufNum
"     new
"   endif
"
"   if buflisted(l:currentBufNum)
"     execute("bdelete! ".l:currentBufNum)
"   endif
"endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <return> :let @/=""<CR>

" don't use Ex mode, use Q for formatting
map Q gq

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
"vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"if MySys() == "mac"
"  nmap <D-j> <M-j>
"  nmap <D-k> <M-k>
"  vmap <D-j> <M-j>
"  vmap <D-k> <M-k>
"endif

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => View and fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

au BufWinLeave *.cpp,*.h,*.rb mkview
au BufReadPost *.cpp,*.h,*.rb silent loadview
"au BufWinEnter *.cpp,*.h,*.rb silent loadview

set fdm=syntax
set fdc=2
set foldlevel=0
"let g:vimsyn_folding='af'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Programming related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
"map <leader>cc :botright cope<cr>
map <leader>cc :cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
"let g:bufExplorerDefaultHelp=0
"let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
"map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
"map <leader>sn ]s
"map <leader>sp [s
"map <leader>sa zg
"map <leader>s? z=


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc
noremap <leader>j :CommandT<cr>
noremap <leader>y :CommandTFlush<cr>


""""""""""""""""""""""""""""""
" => Taglist plugin
""""""""""""""""""""""""""""""

"let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
"let Tlist_Sort_Type = "name" " order by 
"let Tlist_Use_Right_Window = 1 " split to the right side of the screen
"let Tlist_Compart_Format = 1 " show small meny
"let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
"let Tlist_File_Fold_Auto_Close = 0 " Do not close tags for other files
""let Tlist_Enable_Fold_Column = 0 " Do not show folding tree
"nmap <F4> :TlistToggle<CR>
""map <leader>tl :TlistToggle<CR>


""""""""""""""""""""""""""""""
" => Project plugin
""""""""""""""""""""""""""""""
"nmap <silent> <C-K> <Plug>ToggleProject
"nmap <F2> <Plug>ToggleProject


""""""""""""""""""""""""""""""
" => NERDTree plugin
""""""""""""""""""""""""""""""
nmap <F3> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""
" => vim-latex plugin
""""""""""""""""""""""""""""""

let g:tex_flavor = "latex"
autocmd FileType tex source ~/.vim/latex.vim

""""""""""""""""""""""""""""""
" => vimgdb plugin
""""""""""""""""""""""""""""""

":syntax enable	 				" enable syntax highlighting
":set previewheight=12			" set gdb window initial height
":run macros/gdb_mappings.vim	" source key mappings listed in this document
":set asm=0						" don't showany assembly stuff

""""""""""""""""""""""""""""""
" => Bookmark
""""""""""""""""""""""""""""""

"":set shell=sh shellslash shellcmdflag=-c shellxquote=\" shellpipe=\|\ tee
":amenu Mo2.BookMarks.Add
" \ :let @b=":amenu Mo2.BookMarks.".
"" \ escape(escape(expand("%:t"),'.\'),'\').
" \ escape(escape(expand(":y$"),'.\'),'\').
" \ ' :sp +'.line(".").' '.
" \ escape(expand("%:p"),' \')<CR>
" \ :exe ':!(echo '.@b.' >> ~/.vim/bookmark.vim)'<CR>
" \ :so ~/.vim/bookmark.vim<CR>
":amenu Mo2.BookMarks.Edit :sp ~/.vim/bookmark.vim<CR>
":amenu Mo2.BookMarks.Load :so ~/.vim/bookmark.vim<CR>

"if filereadable(expand("~/.vim/bookmark.vim"))
"	  amenu Mo2.BookMarks.-Sep- :
"	  so ~/.vim//bookmark.vim
"endif


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
"au FileType javascript call JavaScriptFold()
"au FileType javascript setl fen
"au FileType javascript setl nocindent

"au FileType javascript imap <c-t> AJS.log();<esc>hi
"au FileType javascript imap <c-a> alert();<esc>hi

"au FileType javascript inoremap <buffer> $r return 
"au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

"function! JavaScriptFold() 
"    setl foldmethod=syntax
"    setl foldlevelstart=1
"    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"    function! FoldText()
"    return substitute(getline(v:foldstart), '{.*', '{...}', '')
"    endfunction
"    setl foldtext=FoldText()
"endfunction
