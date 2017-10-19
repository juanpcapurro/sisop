breakpoint_msg:
    .ascii "Hello, breakpoint!"
    

.globl breakpoint
breakpoint:
        nop
        pusha

        movl (breakpoint_msg), %eax
        movl $, %edx
        movl $0x1f, %ecx
        call vga_write2

        popa
        iret
