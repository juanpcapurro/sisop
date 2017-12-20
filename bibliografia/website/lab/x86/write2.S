#include <bits/errno.h>
#include <sys/syscall.h>

.globl write2
write2:
        movl $-1, %eax
        ret
//
// Implementar una función main() porque make lo intenta
// compilar como programa.
//

#ifndef USE_WRITE2
.globl main
main:
        xor %eax, %eax
        ret
#endif
