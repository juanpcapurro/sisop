let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/sisop/kern2
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +13 inc_p.c
badd +27 ~/.config/nvim/init.vim
badd +0 term://.//5873:/usr/bin/zsh
badd +0 ~/sisop/lab0/resolucion.md
argglobal
silent! argdel *
argadd inc_p.c
edit ~/sisop/lab0/resolucion.md
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
exe '1resize ' . ((&lines * 44 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 82 + 82) / 164)
exe '2resize ' . ((&lines * 44 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 81 + 82) / 164)
exe '3resize ' . ((&lines * 18 + 33) / 66)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 104 - ((36 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
104
normal! 0
wincmd w
argglobal
edit inc_p.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
3
normal! zo
6
normal! zo
9
normal! zo
13
normal! zo
let s:l = 13 - ((9 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 0
wincmd w
argglobal
edit term://.//5873:/usr/bin/zsh
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 3 - ((1 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
3
normal! 0
wincmd w
exe '1resize ' . ((&lines * 44 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 82 + 82) / 164)
exe '2resize ' . ((&lines * 44 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 81 + 82) / 164)
exe '3resize ' . ((&lines * 18 + 33) / 66)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
