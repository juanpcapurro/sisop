let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/sisop/lab1
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +352 resolucion.md
badd +0 term://.//17984:/usr/bin/zsh
badd +23 backtrace.c
argglobal
silent! argdel *
argadd resolucion.md
edit resolucion.md
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
exe 'vert 1resize ' . ((&columns * 81 + 82) / 164)
exe '2resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 82 + 82) / 164)
exe '3resize ' . ((&lines * 21 + 33) / 66)
argglobal
setlocal fdm=expr
setlocal fde=markdown#FoldLevelOfLine(v:lnum)
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
350
normal! zo
594
normal! zo
595
normal! zo
595
normal! zo
597
normal! zo
599
normal! zo
601
normal! zo
603
normal! zo
let s:l = 603 - ((602 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
603
normal! 0
wincmd w
argglobal
edit backtrace.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 18 - ((17 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
normal! 07|
wincmd w
argglobal
edit term://.//17984:/usr/bin/zsh
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 312 - ((20 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
312
normal! 06|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 81 + 82) / 164)
exe '2resize ' . ((&lines * 41 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 82 + 82) / 164)
exe '3resize ' . ((&lines * 21 + 33) / 66)
tabedit backtrace.c
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
4
normal! zo
10
normal! zo
14
normal! zo
18
normal! zo
22
normal! zo
let s:l = 5 - ((4 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 0
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
