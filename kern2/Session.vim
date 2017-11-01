let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/sisop/kern2
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +638 resolucion.md
badd +133 term://.//7134:/usr/bin/zsh
badd +21 idt_entry.S
badd +44 interrupts.c
badd +16 kern2.c
badd +1 funcs.S
badd +8 write.c
badd +62 interrupts.h
badd +19 boot.S
badd +1 stacks.S
badd +10 ~/sisop/lab1/write2.S
badd +20 ~/sisop/lab1/sys_strlen.S
badd +6 handlers.c
badd +1 ~/sisop/lab0/makefile
badd +7 makefile
argglobal
silent! argdel *
argadd resolucion.md
edit interrupts.c
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
exe '1resize ' . ((&lines * 36 + 29) / 58)
exe 'vert 1resize ' . ((&columns * 80 + 76) / 153)
exe '2resize ' . ((&lines * 36 + 29) / 58)
exe 'vert 2resize ' . ((&columns * 72 + 76) / 153)
exe '3resize ' . ((&lines * 18 + 29) / 58)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
10
normal! zo
19
normal! zo
32
normal! zo
45
normal! zo
let s:l = 48 - ((32 * winheight(0) + 18) / 36)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
48
normal! 02|
wincmd w
argglobal
edit kern2.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
9
normal! zo
let s:l = 1 - ((0 * winheight(0) + 18) / 36)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit term://.//7134:/usr/bin/zsh
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 915 - ((17 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
915
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 36 + 29) / 58)
exe 'vert 1resize ' . ((&columns * 80 + 76) / 153)
exe '2resize ' . ((&lines * 36 + 29) / 58)
exe 'vert 2resize ' . ((&columns * 72 + 76) / 153)
exe '3resize ' . ((&lines * 18 + 29) / 58)
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
