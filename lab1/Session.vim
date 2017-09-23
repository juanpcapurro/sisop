let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/sisop/lab1
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 term://.//19560:/usr/bin/zsh
badd +2 makefile
badd +3 kern1.c
badd +798 resolucion.md
badd +1 write.c
badd +19 decls.h
badd +110 ~/.config/nvim/init.vim
argglobal
silent! argdel *
edit decls.h
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
exe '1resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 82 + 82) / 164)
exe '2resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 81 + 82) / 164)
exe '3resize ' . ((&lines * 21 + 33) / 66)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 6 - ((5 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
6
normal! 020|
wincmd w
argglobal
edit kern1.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
7
normal! zo
10
normal! zo
13
normal! zo
let s:l = 23 - ((22 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
23
normal! 0
wincmd w
argglobal
edit term://.//19560:/usr/bin/zsh
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 400 - ((20 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
400
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 82 + 82) / 164)
exe '2resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 81 + 82) / 164)
exe '3resize ' . ((&lines * 21 + 33) / 66)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
