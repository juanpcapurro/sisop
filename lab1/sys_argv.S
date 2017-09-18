#include <sys/syscall.h>

.globl _start
_start:
    push 8(%esp)
    call strlen
    mov %eax, %edx
    pop %ecx
    movb $('\n'),(%ecx,%edx)
    inc %edx   //nota: muestro el largo considerando el '\0'
    mov $SYS_write, %eax
    mov $0x01, %ebx
    int $0x80
    mov %edx,%ebx
    mov $SYS_exit,%eax
    int $0x80
    


