.data
former_ebp:
    .long 0
former_esp:
    .long 0

.text
.globl task_exec
task_exec:
    push %ebp
    movl %esp, %ebp
    movl %ebp, (former_ebp)
    movl %esp, (former_esp)

    mov 8(%ebp),%eax
    mov 12(%ebp),%esp
    mov $0,%ebp
    call *%eax

    movl (former_ebp), %ebp
    movl (former_esp), %esp
    leave
    ret
