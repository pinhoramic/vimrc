
set mousehide		          " Hide the mouse when typing text
let c_comment_strings=1   " highlighting strings inside C comments

win 203 53

amenu icon=~/.vim/icons/hdd_unmount.icns ToolBar.NerdTree :NERDTreeToggle<CR>
amenu icon=~/.vim/icons/make.icns ToolBar.Latex \ll<CR>

if has("gui_macvim")
  " disable the original Cmd-T (open new tab) and map Cmd-T to the CommandT plugin
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
  " hide toolbar
  set go-=T
  set transparency=15
  "let macvim_hig_shift_movement = 1
  "an 10.300 File.Project :ProjectToggle<CR>
  "macm File.Project key=<D-k>
endif
