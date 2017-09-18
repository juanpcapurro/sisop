#include <bits/errno.h>
#include <sys/syscall.h>

.globl write2
write2:
	push %ebp
	mov %esp, %ebp
	push %edx
	push %ecx
	push %ebx

	mov 16(%ebp),%edx
	mov 12(%ebp),%ecx
	mov 8(%ebp),%ebx
	mov $SYS_write, %eax
	int $0x80
	cmp $0,%eax
	jg  okay
	neg %eax
	mov %eax,%ebx
	call __errno_location
	mov %ebx,(%eax)
	mov $-1,%eax
okay:
	pop %ebx
	pop %ecx
	pop %edx
	mov %ebp, %esp
	pop %ebp
	ret

#ifndef USE_WRITE2
.globl main
main:
	xor %eax, %eax
	ret
#endif
