let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/sisop/kern2
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +469 resolucion.md
badd +193 term://.//23739:/bin/zsh
badd +49 interrupts.h
badd +26 interrupts.c
badd +1 makefile
badd +15 kern2.c
badd +4 idt_entry.S
argglobal
silent! argdel *
argadd resolucion.md
edit kern2.c
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
exe '1resize ' . ((&lines * 33 + 23) / 46)
exe 'vert 1resize ' . ((&columns * 80 + 85) / 170)
exe '2resize ' . ((&lines * 33 + 23) / 46)
exe 'vert 2resize ' . ((&columns * 89 + 85) / 170)
exe '3resize ' . ((&lines * 9 + 23) / 46)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
8
normal! zo
let s:l = 16 - ((15 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
16
normal! 0
wincmd w
argglobal
edit makefile
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 8 - ((7 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 061|
wincmd w
argglobal
edit term://.//23739:/bin/zsh
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 176 - ((8 * winheight(0) + 4) / 9)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
176
normal! 010|
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 33 + 23) / 46)
exe 'vert 1resize ' . ((&columns * 80 + 85) / 170)
exe '2resize ' . ((&lines * 33 + 23) / 46)
exe 'vert 2resize ' . ((&columns * 89 + 85) / 170)
exe '3resize ' . ((&lines * 9 + 23) / 46)
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
