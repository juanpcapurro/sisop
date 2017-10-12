#include "decls.h"
#include "multiboot.h"
#define USTACK_SIZE 4096

static uint8_t stack1[USTACK_SIZE] __attribute__((aligned(4096)));
static uint8_t stack2[USTACK_SIZE] __attribute__((aligned(4096)));

void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    // A remplazar por una llamada a two_stacks(),
    // definida en stacks.S.
    two_stacks();
    two_stacks_c();
    contador_run();
    vga_write2("Funciona vga_write2?", 18, 0xE0);
}

void two_stacks_c() {
    // Inicializar al *tope* de cada pila.
    uintptr_t *s1 = (uintptr_t*)stack1+USTACK_SIZE-1;
    uintptr_t *s2 = (uintptr_t*)stack2+USTACK_SIZE-1;

    *--s1 = 0x57;
    *--s1 = 15;
    *--s1 = (uintptr_t)"vga_write() from stack1";

    // AYUDA 3: para esta segunda llamada, usar esta forma de
    // asignación alternativa:
    s2 -= 3;
    s2[0] = (uintptr_t)"vga_write() from stack2";
    s2[1] = 16;
    s2[2] = 0xD0;

    // Primera llamada usando task_exec().
    task_exec((uintptr_t) vga_write, (uintptr_t) s1);

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
