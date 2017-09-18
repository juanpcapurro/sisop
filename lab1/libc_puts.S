#include <sys/syscall.h>  // SYS_write, SYS_exit

.globl main
main:
    push $msg
    call puts

    pop %eax 
    mov $55, %eax
    ret
.data
msg:
    .asciz "Hello, world!\n"
.set len, . - msg
