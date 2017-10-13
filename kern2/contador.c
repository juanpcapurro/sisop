#include "decls.h"

#define COUNTLEN 20
#define TICKS (1ULL << 15)
#define DELAY(x) (TICKS << (x))
#define USTACK_SIZE 4096

static volatile char *const VGABUF = (volatile void *) 0xb8000;

static uintptr_t *esp;
static uint8_t stack_verde[USTACK_SIZE] __attribute__((aligned(4096)));
static uint8_t stack_rojo[USTACK_SIZE] __attribute__((aligned(4096)));

static void yield() {
    if (esp)
        task_swap(&esp);
}
static void exit(){
    uintptr_t* tmp = esp;
    esp = NULL;
    task_swap(&tmp);
}

static void contador_yield(unsigned lim, uint8_t linea, char color) {
    char counter[COUNTLEN] = {'0'};  // ASCII digit counter (RTL).

    while (lim--) {
        char *c = &counter[COUNTLEN];
        volatile char *buf = VGABUF + 160 * linea + 2 * (80 - COUNTLEN);

        unsigned p = 0;
        unsigned long long i = 0;

        while (i++ < DELAY(7))  // Usar un entero menor si va demasiado lento.
            ;

        while (counter[p] == '9') {
            counter[p++] = '0';
        }

        if (!counter[p]++) {
            counter[p] = '1';
        }

        while (c-- > counter) {
            *buf++ = *c;
            *buf++ = color;
        }

        yield();
    }
}

void contador_run() {
    uintptr_t* top_stack_verde= (uintptr_t*) stack_verde + USTACK_SIZE -1;
    uintptr_t params_stack_verde[]= {150, 0, 0x2F}; // unicamente necesito poner los argumentos
                                                    // de contador_yield con el stack verde

    uintptr_t* top_stack_rojo= (uintptr_t*) stack_rojo+ USTACK_SIZE -1;
    uintptr_t params_stack_rojo[]= {
        0,                        // los primeros cuatro lugares
        0,                        // los relleno con valores para los registros que
        0,                        // popea task_swap
        0,                        //
        (uintptr_t)contador_yield,// direccion a la que retornara task_swap
                                  // en la primer llamada
        (uintptr_t)exit,                        // direccion a la que retornara contador_yield con el stack rojo
                                  //nomas relleno para que encuentre bien los argumentos
        100,                      //
        1,                        // argumentos de contador_yield
        0x1F                      //
    };
    top_stack_rojo = (uintptr_t*)make_stack(top_stack_rojo, params_stack_rojo, 9);
    esp = (uintptr_t*)top_stack_rojo;
    task_exec((uintptr_t)contador_yield, make_stack(top_stack_verde, params_stack_verde, 3));
}
