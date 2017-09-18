.globl main
main:
    push $msg
    call strlen
    push %eax
    push $msg
    push $1
    push ret_addr
    jmp  write
ret_addr:

    push $7
    call _exit

.data
msg:
        .asciz "Hello, world!\n"

.set len, . - msg
