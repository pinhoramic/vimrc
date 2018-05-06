
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-scripts/DirDiff.vim'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'vim-scripts/mru.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-latex/vim-latex'

call vundle#end()

filetype plugin indent on
syntax on

let mapleader = ","
let g:mapleader = ","

map <leader>e :e! ~/.vimrc<cr>
autocmd! BufWritePost .vimrc source ~/.vimrc

set number
set laststatus=2
set ruler
set showcmd
set wildmenu
set cmdheight=2
set hidden

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

set hlsearch
set incsearch
nnoremap <silent> \ :let @/=""<CR>

set nolazyredraw
set magic
set showmatch
set showmode
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax enable
set background=dark
set t_Co=256

set fdm=syntax
set fdc=2
set foldlevel=0

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <right> :bn<cr>
map <left> :bp<cr>
map leader<cd> :cd %:p:h<cr>
" set switchbuf=usetab

set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lcs=tab:\.\ ,trail:-
set list

set lbr

set autoindent
set copyindent
set smartindent
set wrap


"===== Plugins ====="

let g:vundle_default_git_proto='git'

"" cope
map <leader>cc :botright cope<cr>
map <leader>co :cope<cr>

"" bufexplorer
"let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>

"" nerdtree
nmap <tab> :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.o$', '\.obj$', '\.a$', '\.so$']

""airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

"" ctrlp
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup
    \ --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ --ignore review
    \ --ignore .cache
    \ -g ""'
let g:ctrlp_show_hidden = 0

"" tagbar
nmap <S-tab> :TagbarToggle<CR>

"" mru
" let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

"" vim-latex plugin
let g:tex_flavor = "latex"


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
au filetype actionscript set noexpandtab

"" Python
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
