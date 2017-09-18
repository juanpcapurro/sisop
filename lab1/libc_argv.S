.globl main
main:
    push %ebp
    mov %esp,%ebp

    mov 12(%ebp),%eax
    add $4,%eax
    mov (%eax),%eax
    mov %eax,%ebx
    push %eax
    call strlen
    movb $('\n'),(%ebx,%eax)
    inc %eax  //vuelvo a considerar el largo con el '\0'
    push %eax
    push %ebx
    push $1
    call write

    mov %ebp,%esp
    pop %ebp
    ret
