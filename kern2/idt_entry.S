#define PIC1 0x20
#define ACK_IRQ 0x20

.data
breakpoint_msg:
    .asciz "Hello, breakpoint!"
divzero_msg:
    .asciz "Se divide por ++ebx"

.text
.globl breakpoint
breakpoint:
    pusha

    movl $breakpoint_msg, %eax
    movl $3, %edx
    movl $0x1f, %ecx
    call vga_write2

    popa
    iret

.globl ack_irq
ack_irq:
    movl $ACK_IRQ, %eax
    outb %al, $PIC1
    iret
    
.globl timer_asm
timer_asm:
    pusha
    call timer
    popa
    jmp ack_irq

.globl divzero
divzero:
    push %eax
    push %edx
    push %ecx
    movl $divzero_msg, %eax
    movl $17,%edx
    call vga_write_cyan

    pop %ecx
    pop %edx
    pop %eax
    movl $1, %ebx
    iret
