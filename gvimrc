
set mousehide		" Hide the mouse when typing text
let c_comment_strings=1 " highlighting strings inside C comments

win 180 50

"amenu icon=~/.vim/icons/hdd_unmount.icns ToolBar.Project :ProjectToggle<CR>
amenu icon=~/.vim/icons/make.icns ToolBar.Latex \ll<CR>

if has("gui_macvim")
   macmenu &File.New\ Tab key=<nop>     " disable the original Cmd-T (open new tab)
   map <D-t> :CommandT<CR>              " map Cmd-T to the CommandT plugin
  "let macvim_hig_shift_movement = 1
  "an 10.300 File.Project :ProjectToggle<CR>
  "macm File.Project key=<D-k>
endif
