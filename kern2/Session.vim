let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/sisop/kern2
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 makefile
badd +87 term://.//10367:/bin/zsh
badd +9 kern2.c
badd +0 stacks.S
badd +12 boot.S
badd +93 ~/.config/nvim/init.vim
badd +0 resolucion.md
argglobal
silent! argdel *
argadd makefile
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
exe '1resize ' . ((&lines * 35 + 29) / 58)
exe 'vert 1resize ' . ((&columns * 80 + 82) / 164)
exe '2resize ' . ((&lines * 35 + 29) / 58)
exe 'vert 2resize ' . ((&columns * 83 + 82) / 164)
exe '3resize ' . ((&lines * 19 + 29) / 58)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 248 - ((30 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
248
normal! 0
wincmd w
argglobal
edit stacks.S
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 57 - ((24 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
57
normal! 0
wincmd w
argglobal
edit term://.//10367:/bin/zsh
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1010 - ((9 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1010
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 35 + 29) / 58)
exe 'vert 1resize ' . ((&columns * 80 + 82) / 164)
exe '2resize ' . ((&lines * 35 + 29) / 58)
exe 'vert 2resize ' . ((&columns * 83 + 82) / 164)
exe '3resize ' . ((&lines * 19 + 29) / 58)
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
