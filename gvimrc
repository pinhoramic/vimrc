
set mousehide		          " Hide the mouse when typing text
let c_comment_strings=1   " highlighting strings inside C comments

win 203 65

amenu icon=~/.vim/icons/hdd_unmount.icns ToolBar.NerdTree :NERDTreeToggle<CR>
amenu icon=~/.vim/icons/make.icns ToolBar.Latex \ll<CR>

if has("gui_macvim")
  colorscheme ir_black
  set cursorline
  " hide toolbar
  set go-=T
  " set transparency=15
  "let macvim_hig_shift_movement = 1
  "an 10.300 File.Project :ProjectToggle<CR>
  "macm File.Project key=<D-k>
endif
