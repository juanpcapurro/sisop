
.globl main
main:
    push %ebp
    mov %esp,%ebp

    mov 12(%ebp),%eax
    mov %eax,%edi
    mov $0,%ebx
loop:
    push (%edi,%ebx,4)
    call puts
    inc %ebx
    cmp %ebx,8(%ebp)
    jg loop
    mov %ebx,%eax

    mov %ebp,%esp
    pop %ebp
    ret
