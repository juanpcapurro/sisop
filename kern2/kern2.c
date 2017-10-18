#include "decls.h"
#include "multiboot.h"
#include "interrupts.h"
#define USTACK_SIZE 4096

static uint8_t stack1[USTACK_SIZE] __attribute__((aligned(4096)));
static uint8_t stack2[USTACK_SIZE] __attribute__((aligned(4096)));

void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    // A remplazar por una llamada a two_stacks(),
    // definida en stacks.S.
    two_stacks();
    two_stacks_c();
    idt_init();
    idt_install(T_BRKPT, breakpoint);
    __asm__("int3"); 
    contador_run();
    vga_write2("Funciona vga_write2?", 18, 0xE0);
}

void two_stacks_c() {
    // Inicializar al *tope* de cada pila.
    uintptr_t *s1 = (uintptr_t*)stack1+USTACK_SIZE-1;
    uintptr_t *s2 = (uintptr_t*)stack2+USTACK_SIZE-1;

    uintptr_t params_s1[] = {(uintptr_t)"vga_write() from stack1", 15, 0x57};
    task_exec((uintptr_t)vga_write, make_stack(s1,params_s1,3));

    uintptr_t params_s2[] = {(uintptr_t)"vga_write() from stack2", 16, 0xD0};
    s2= (uintptr_t*)make_stack(s2, params_s2,3);
    // Segunda llamada con ASM directo. Importante: no
    // olvidar restaurar el valor de %esp al terminar, y
    // compilar con -fno-omit-frame-pointer.
    __asm__("movl %%esp, %%esi\n\t"
            "movl %%ebp, %%ebx\n\t"
            "movl %0, %%esp\n\t"
            "movl $0,%%ebp\n\t"
            "call *%1\n\t"
            "movl %%esi, %%esp\n\t"
            "movl %%ebx, %%ebp"
        : /* no outputs */
        : "r"(s2), "r"(vga_write)
        : "%esi", "%ebx");
}

uintptr_t make_stack(uintptr_t* stack_top, uintptr_t params[], uint8_t param_count){
    stack_top -= param_count;
    for (size_t i = 0; i< param_count; i++){
        stack_top[i]= params[i];
    }
    return (uintptr_t)stack_top;
}
