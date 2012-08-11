
" pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#infect('~/.vim/bundle')
call pathogen#helptags()

set nocompatible         " not compatible with the old-fashion vi mode, must be first
set history=50           " sets how many lines of history VIM has to remember
set autoread             " set to auto read when a file is changed from the outside

filetype on
filetype plugin on
filetype indent on

let mapleader = ","
let g:mapleader = ","

" fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" when vimrc is edited, reload it
autocmd! BufWritePost .vimrc source ~/.vimrc

set number                " always show line number
"set showcmd               " display incomplete commands

set scrolloff=7          " set 7 lines to the curors - when moving vertical
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

"===== colors and fonts ====="

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

set ffs=unix,dos,mac     " default file types


"===== files, backups and undo ====="

set nobackup
set nowb
set noswapfile

" persistent undo
try
	set undodir=~/.vim/undodir
	set undofile
catch
endtry


" tab and indent
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lcs=tab:\.\ ,trail:-
set list

set lbr
set tw=500

set autoindent            " auto indent
set copyindent            " copy the previous indentation on autoindenting
set smartindent           " smart indet
set wrap                  " wrap lines


"===== status line ====="

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


"===== visual mode ====="

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


"===== command mode ====="

" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

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


"===== buffers ====="

" use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" when pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" specify the behavior when switching between buffers
set switchbuf=usetab


"===== parenthesis/bracket expanding ====="

vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>


"===== abbrevs ====="

iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"===== editing mappings ====="

nnoremap <silent> \ :let @/=""<CR>

" don't use Ex mode, use Q for formatting
map Q gq

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


"===== view and fold ====="

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"au BufWinLeave *.cpp,*.h,*.rb,*.js,*.coffee,*.java mkview
"au BufReadPost *.cpp,*.h,*.rb,*,js,*.coffee,*.java silent loadview

function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile'
        " Buffer is marked as not a file
        return 0
    endif
    if empty(glob(expand('%:p')))
        " File does not exist on disk
        return 0
    endif
    return 1
endfunction
augroup vimrcAutoView
    autocmd!
    " Autosave & Load Views.
    au BufWritePost,BufLeave,WinLeave ?* if MakeViewCheck() | mkview | endif
    au BufReadPost ?* if MakeViewCheck() | silent loadview | endif
augroup end

set fdm=syntax
set fdc=2
set foldlevel=0
"let g:vimsyn_folding='af'


"===== programming related ====="

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
"map <C-[> <esc>:po<cr>

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
  let basename = substitute(bufname(""), '.*/', '', '')
  let guard = '_' . substitute(toupper(basename), '\.', '_', "H_")
  call append(0, "#ifndef " . guard)
  call append(1, "#define " . guard)
  call append( line("$"), "#endif // for #ifndef " . guard)
endfun


"===== spell checking ====="
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
"map <leader>sn ]s
"map <leader>sp [s
"map <leader>sa zg
"map <leader>s? z=


"===== plugins ====="

"" cope
"map <leader>cc :botright cope<cr>
map <leader>co :cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"" bufexplorer
"let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>


"" MiniBufExpl
map <leader>b :MiniBufExplorer<cr>
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplModSelTarget = 1


"" mru
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


"" nerdtree plugin
nmap <tab> :NERDTreeToggle<CR>


"" vim-latex plugin
let g:tex_flavor = "latex"
au FileType tex source ~/.vim/latex.vim

" (hack) map these to something else to preserve <C-j> mapping
map <C-I><C-j> <Plug>IMAP_JumpForward
vmap <C-I><C-J> <Plug>IMAP_DeleteAndJumpForward


"" tagbar
nmap <S-tab> :TagbarToggle<CR>


"===== Language specific ====="

"" Makefile
au FileType Makefile set noexpandtab

"" CoffeeScript
au BufNewFile,BufReadPost *.coffee setl fdm=indent nofoldenable


"" JavaScript

au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-l> console.log();<esc>hi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

"" Java
au FileType java shiftwidth=4 tabstop=4

"" ActionScript
au BufNewFile,BufReadPost *.as setl filetype=actionscript
au BufNewFile,BufReadPost *.as setl shiftwidth=4 tabstop=4
