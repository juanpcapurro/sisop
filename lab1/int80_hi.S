#include <sys/syscall.h>  // SYS_write, SYS_exit
// See: <https://en.wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux>.

.globl main
main:
    mov $SYS_write, %eax // %eax == syscall number
    mov $1, %ebx         // %ebx == 1st argument (fd)
    mov $msg, %ecx       // %ecx == 2nd argument (buf)
    mov $len, %edx       // %edx == 3rd argument (count)
    int $0x80

    mov $0, %eax
    ret
.data
msg:
    .asciz "Hello, world!\n"
.set len, . - msg
