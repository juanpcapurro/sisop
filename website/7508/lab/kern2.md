# Un kernel con reloj y tres tareas

Material de apoyo:

  - [decls.h](decls.h)
  - [interrupts.h](interrupts.h)

## Índice
{:.no_toc}

* TOC
{:toc}


## Conocimientos previos: “inline assembler”
{: #inline-asm}

En labs anteriores se observó que es posible integrar instrucciones en assembler directamente en código C:

```c
void comienzo(void) {
    while (1)
        asm("hlt");
}
```

Existe además una sintaxis extendida:

```c
asm("..." : /* opciones... */);
```

que permite una mayor integración entre el código generado por el compilador, y las instrucciones assembler manuales. Por ejemplo, es posible escribir el valor de una variable a un registro concreto, o extraer el resultado de una instrucción a una variable de la función.

Para los ejercicios de esta parte, se recomienda la siguiente bibliografía:

  - _ibm.com:_ [Inline assembly for x86 in Linux][ibmasm]. Artículo breve, ideal para familiarizarse con el concepto y uso de inline assembly.

  - _ibiblio.org:_ [GCC-Inline-Assembly-HOWTO][inlhowto]. Tutorial más extenso.

  - _gcc.gnu.org:_ [How to Use Inline Assembly Language in C Code][gccasm]. Documentación oficial de GCC; ver, en particular, las secciones [Basic Asm][gccbasic] y [Extended Asm][gccextend].

[ibmasm]: https://www.ibm.com/developerworks/linux/library/l-ia/index.html
[inlhowto]: http://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html
[gccasm]: https://gcc.gnu.org/onlinedocs/gcc/Using-Assembly-Language-with-C.html
[gccbasic]: https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html
[gccextend]: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html


### Ej: asm-inc
{: #inline-inc}

La siguiente función incrementa un entero usando directamente una instrucción `inc` de assembler:

```c
int inc(int x) {
    asm("incl %1" : "=g"(x) : "0"(x));
    return x;
}
```

Se pide:

  - Explicar los parámetros de la instrucción `asm` mostrada.

  - Compilar el código con `gcc -c` y describir, usando para ello la salida de `objdump -d`, la correspondencia entre el código original y las instrucciones assembler generadas tras la compilación.[^defaultO1]

  - Mostrar, de nuevo usando `gcc -c` y `objdump -d`, en qué cambia el código generado para la siguiente versión, y razonar el por qué de las diferencias:

    ```c
    int inc2(int x) {
        int ret;
        asm("incl %1; movl %1, %0" : "=r"(ret) : "m"(x));
        return ret;
    }
    ```

    Responder: ¿Sería válido especificar `"m"(x)` si `inc` solo funcionase con un registro como operando?

  - Recompilar ambas versiones cambiando `incl` por `inc` y, si alguna de las dos versiones no compila, explicar el porqué de la diferencia.


### Ej: asm-ptr
{: #inline-ptr}

La función `inc_p()` incrementa el valor de un entero vía su dirección de memoria:

```c
#include <stdio.h>

void inc_p(int *p) {
    // ...
}

int main(void) {
    int n = 0;
    inc_p(&n);
    printf("n = %d\n", n);
}
```

de tal manera que el programa anterior imprime `n = 1`:[^useO0]

```
$ cc -m32 -O0 inc_p.c && ./a.out
n = 1
```

Se proponen las siguientes tres implementaciones de `inc_p()`; indicar cuáles funcionan y cuáles no y, examinando el código generado por gcc, explicar por qué:

```c
void inc_p(int *p) {
    // (0)
    asm("incl %0" : : "m"(p));

    // (1)
    asm("incl %0" : : "m"(*p));

    // (2)
    asm("incl %0" : "=m"(*p));
}
```

Finalmente, se pide componer una tabla en que se muestre el resultado usando un nivel de optimización mayor en GCC:


| Opciones gcc    | `:: "m"(*p)` | `: "=m"(*p)` |
|-----------------+--------------+--------------|
| -O2             |              |              |
| -O2 -fno-inline |              |              |
{:.gcc_kern2}

Explicar cualquier diferencia en los resultados y, si alguno es incorrecto, intentar mejorar el código para que funcione en todos los casos.[^finline]

[^defaultO1]: Excepto cuando se indique lo contrario, para todos los ejercicios de esta parte es suficiente con usar `-O1 -m32` como opciones de compilación.

[^useO0]: Nótese que el nivel de optimización para este ejercicio es `-O0`, en lugar de `-O1`.

[^finline]: Un tipo de optimización que realiza GCC es “inline automático”, esto es: repetir código en lugar de realizar una llamada a función, incluso si ésta no fue marcada _inline_. En el caso de directivas `asm("...")`, los constraints de entrada y salida deben ser exactamente correctos para que la optimización mantenga la semántica esperada.


### Ej: asm-regs
{: #inline-regs}

En general, los [constraints] genéricos como `"r"` o `"g"` dan libertad al compilador para elegir el registro o ubicación que más convenga según los operandos y el código colindante. Sin embargo, existen constraints particulares [a cada arquitectura][machinecnstr] que permiten forzar el uso de registros específicos.

Se puede hacer uso de estos constraints para, por ejemplo, preparar los parámetros de una llamada al sistema:

```c
#include <sys/types.h>
#include <sys/syscall.h>

void my_write(const char *msg, size_t count) {
    asm("int $0x80" : :
        "?"(SYS_write), "?"(1), "?"(msg), "?"(count));
}

int main(void) {
    my_write("Hello, world!\n", 14);
}
```

Completar los constraints en la función _my_write_, de manera que la llamada al sistema funcione. ¿En qué cambia el código generado (incluyendo el código de _main_) si se declara _my_write_ con atributo [_fastcall_][fastcall]?

[constraints]: https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html
[machinecnstr]: https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html
[fastcall]: https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html


### Ej: asm-volatile
{: #inline-volatile}

Modificar la función _my_write_ del ejercicio anterior para que devuelva un booleano indicando si se escribió el número de bytes esperado (que la llamada al sistema devuelve en _%eax_):

```c
bool my_write2(int fd, const void *buf, size_t count) {
    ssize_t ret;

    asm volatile("int $0x80" : /* ... */(ret) : /* ... */);
    //  ^^^^^^^^

    return (ret > 0 && (size_t) ret == count);
}

int main(void) {
    bool result = my_write2(1, "Hello, write2!\n", 15);
    if (!result)
        puts("write2 falló");
}
```

Indicar qué ocurre al ejecutar el programa con las siguientes modificaciones:

1.  Eliminando el modificador _volatile_ de la instrucción assembler.
2.  Con _volatile_ de vuelta en su lugar, eliminando el `if (!result) ...` de la función _main_.
3.  Eliminando tanto _volatile_ como la comprobación del booleano. ¿Qué código genera gcc para _main_ en este caso? ¿Cambió el código generado para _my_write2_?

Leer la documentación de [asm volatile][asmvol], y explicar:

  - por qué cada uno de 1-3 funciona, o no
  - por qué no se hizo necesario _volatile_ en el ejercicio [asm-regs](#inline-regs), ni tampoco en [asm-inc](#inline-inc)

[asmvol]: https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile


## Concurrencia cooperativa
{: #cooperative}

Dadas dos o más tareas que se desea ejecutar de manera concurrente en un procesador —﻿por ejemplo, el cálculo de números primos o de los dígitos de π, o cualquier otra tarea [CPU-bound][cpu-bound]﻿— lo habitual es asignar a cada un flujo de ejecución separado (ya sean procesos o hilos); y delegar al sistema operativo la implementación de la concurrencia, esto es, la alternancia de ambos flujos.

Suponiendo, para el resto del lab, un sistema con un solo [_core_][core], se presenta ahora la pregunta: ¿es posible implementar concurrencia de algún tipo sin ayuda del sistema operativo?[^noos]

[^noos]: En este contexto, «sin ayuda del sistema operativo» vendría a significar: bien en un solo proceso de usuario sin invocar ninguna llamada al sistema relacionada con la planificación; bien en un kernel básico sin reloj configurado.

La respuesta a esta pregunta es una _planificación cooperativa_ en la que dos o más tareas se cedan mutuamente el uso del procesador por un internalo de tiempo. Como se verá, este tipo de cooperación puede implementarse sin ayuda del sistema operativo; y la implementación más sencilla se consigue proporcionando a cada tarea su propio stack.

[core]: https://unix.stackexchange.com/a/146240
[cpu-bound]: https://en.wikipedia.org/wiki/CPU-bound


### Ej: kern2-task
{: #ej-task}

En el ejercicio [kern1-stack](x86.md#kern1-stack) se vio cómo declarar espacio para stacks adicionales. En este ejercicio se realizarán, en dos stacks separados de 4 KiB, sendas llamadas a la función ya implementada `vga_write()`.

Partiendo de un archivo _kern2.c_ similar a:

```c
#include "decls.h"
#include "multiboot.h"

void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    // A remplazar por una llamada a two_stacks(),
    // definida en stacks.S.
    vga_write("vga_write() from stack1", 12, 0x17);
    vga_write("vga_write() from stack2", 13, 0x90);
}
```

se pide implementar una función `two_stacks()` en assembler que realice las llamadas mostradas en stacks distintos. Se recomienda usar el siguiente segmento de datos:

```nasm
// stacks.S
#define USTACK_SIZE 4096

.data
        .align 4096
stack1:
        .space USTACK_SIZE
stack1_top:

        .p2align 12
stack2:
        .space USTACK_SIZE
stack2_top:

msg1:
        .asciz "vga_write() from stack1"
msg2:
        .asciz "vga_write() from stack2"
```

y el siguiente esqueleto de implementación:

```nasm
// stacks.S continuado
.text
.globl two_stacks
two_stacks:
        // Preámbulo estándar
        push %ebp
        movl %esp, %ebp

        // Registros para apuntar a stack1 y stack2.
        mov $stack1_top, %eax
        mov $stack2_top, ...   // Decidir qué registro usar.

        // Cargar argumentos a ambos stacks en paralelo. Ayuda:
        // usar offsets respecto a %eax ($stack1_top), y lo mismo
        // para el registro usado para stack2_top.
        movl $0x17, ...(%eax)
        movl $0x90, ...(...)

        movl $12, ...
        movl $13, ...

        movl $msg1, ...
        movl $msg2, ...

        // Realizar primera llamada con stack1. Ayuda: usar LEA
        // con el mismo offset que los últimos MOV para calcular
        // la dirección deseada de ESP.
        leal ...(%eax), %esp
        call vga_write

        // Restaurar stack original. ¿Es %ebp suficiente?
        movl ..., %esp

        // Realizar segunda llamada con stack2.
        leal ...(...), %esp
        call vga_write

        // Restaurar registros callee-saved, si se usaron.
        ...

        leave
        ret
```


### Ej: kern2-exec
{: #ej-exec}

Implementar ahora una función en C que realice la misma tarea que `two_stacks()`, realizando las llamadas de escritura de la siguiente manera:

1.  para la primera llamada, definir una función auxiliar en un nuevo archivo _tasks.S:_

    ```c
    // Realiza una llamada a "entry" sobre el stack proporcionado.
    void task_exec(uintptr_t entry, uintptr_t stack);
    ```

2.  para la segunda llamada, realizar la llamada directamente mediante assembler _inline_.

El código en C puede estar en el mismo archivo _kern2.c_, y debe preparar sus stacks de modo análogo a _stacks.S_. Se sugiere el siguiente esqueleto de implementación:

```c
#include "decls.h"
#include "multiboot.h"

#define USTACK_SIZE 4096

void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    two_stacks();
    two_stacks_c();
}

static uint8_t stack1[USTACK_SIZE] __attribute__((aligned(4096)));
static uint8_t stack2[USTACK_SIZE] __attribute__((aligned(4096)));

void two_stacks_c() {
    // Inicializar al *tope* de cada pila.
    uintptr_t *a = ...
    uintptr_t *b = ...

    // Preparar, en stack1, la llamada:
    vga_write("vga_write() from stack1", 15, 0x57);

    // AYUDA 1: se puede usar alguna forma de pre- o post-
    // incremento/decremento, según corresponda:
    //
    //     *(a++) = ...
    //     *(++a) = ...
    //     *(a--) = ...
    //     *(--a) = ...

    // AYUDA 2: para apuntar a la cadena con el mensaje,
    // es suficiente con el siguiente cast:
    //
    //   ... a ... = (uintptr_t) "vga_write() from stack1";

    // Preparar, en s2, la llamada:
    vga_write("vga_write() from stack2", 16, 0xD0);

    // AYUDA 3: para esta segunda llamada, usar esta forma de
    // asignación alternativa:
    b -= 3;
    b[0] = ...
    b[1] = ...
    b[2] = ...

    // Primera llamada usando task_exec().
    task_exec((uintptr_t) vga_write, (uintptr_t) s1);

    // Segunda llamada con ASM directo. Importante: no
    // olvidar restaurar el valor de %esp al terminar, y
    // compilar con: -fasm -fno-omit-frame-pointer.
    asm("...; call *%1; ..."
        : /* no outputs */
        : "r"(s2), "r"(vga_write));
}
```


### Ej: kern2-regcall
{: #ej-regcall}

Para este ejercicio se añadirá una segunda versión de `vga_write()` que toma sus parámetros directamente por registros:

```c
// decls.h
void __attribute__((regparm(3)))
vga_write2(const char *s, int8_t linea, uint8_t color);
```

Se pide, en primer lugar, leer la documentación de la convención de llamadas [regparm] para implementar la función `vga_write2()` en el archivo _funcs.S:_

```nasm
// tasks.S
.globl vga_write2
vga_write2:
        push %ebp
        movl %esp, %ebp

        // ...
        call vga_write

        leave
        ret
```

A continuación, mostrar con `objdump -d` el código generado por GCC para la siguiente llamada a _vga_write2()_ desde la función principal:

```c
void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    two_stacks();
    two_stacks_c();

    vga_write2("Funciona vga_write2?", 18, 0xE0);
}
```

[regparm]: https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html


### Ej: kern2-swap
{: #ej-swap}

En el archivo [contador.c](contador.c) se proporciona una función `contador_yield()` que muestra en el buffer VGA una cuenta desde 0 hasta un número pasado como parámetro. Para simular un retardo entre número y número, a cada incremento se le añade un ciclo _while_ con un número alto de iteraciones (controlado por la macro `DELAY`).

Añadir el archivo a las fuentes de _kern2_ y comprobar que se ejecutan dos contadores (uno verde y otro rojo) al invocar a `contador_run()` desde la función principal:

```c
void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    two_stacks();
    two_stacks_c();
    contador_run();  // Nueva llamada ej. kern2-swap.

    vga_write2("Funciona vga_write2?", 18, 0xE0);
}
```

Al final de cada iteración, esto es, de cada incremento, el código del contador invoca a la función `yield()`.[^yield] Esta función simplemente invoca, pasando una variable estática como parámetro, a la función `task_swap()`, que es el verdadero objetivo de este ejercicio:

```c
// Pone en ejecución la tarea cuyo stack está en ‘*esp’, cuyo
// valor se intercambia por el valor actual de %esp. Guarda y
// restaura todos los callee-called registers.
void task_swap(uintptr_t **esp);
```

En este ejercicio se pide, siguiendo las instrucciones indicadas:

1.  Reescribir la función `contador_run()` para que se ejecute cada contador en un stack separado:

    ```c
    void contador_run() {
        // Configurar stack1 y stack2 con los valores apropiados.
        uintptr_t *a = ...
        uintptr_t *b = ...

        ...

        // Actualizar la variable estática ‘esp’ para que apunte
        // al del segundo contador.
        ...

        // Lanzar el primer contador con task_exec.
        task_exec(...);
    }
    ```

    Consideraciones:

      - la configuración del stack del primer contador, que se ejecuta con `task_exec()`, será muy similar a las realizadas en la función `two_stacks_c()` del ejercicio [kern2-exec](#ej-exec).

      - la configuración del segundo contador es más compleja, y seguramente sea mejor realizarla tras implementar `task_swap()`; pues se debe crear artificialmente el stack tal y como lo hubiera preparado esta función.

    Explicar, para el stack de cada contador, cuántas posiciones se asignan, y qué representa cada una.

2.  Implementar en _tasks.S_ la función `task_swap()`. Como se indicó arriba, esta función recibe como parámetro la ubicación en memoria de la variable _esp_ que apunta al stack de la tarea en “stand-by”. La responsabilidad de esta función es:

      - guardar, en el stack de la tarea actual, los registros que son _callee-saved_

      - cargar en _%esp_ el stack de la nueva tarea, y guardar en la variable _esp_ el valor previo de _%esp_

      - restaurar, desde el nuevo stack, los registros que fueron guardados por una llamada previa a `task_swap()`, y retornar (con la instrucción `ret`) a la nueva tarea.

    Para esta función, se recomienda no usar el preámbulo, esto es, no  modificar el registro _%ebp_ al entrar en la función.

[^yield]: El verbo _yield_ (en inglés, ceder el paso) es el término que se suele usar para indicar que una tarea cede voluntariamente el uso del procesador a otra.


### Ej: kern2-exit ★
{: #ej-exit}

En la función `contador_run()` del ejercicio anterior, se configuran ambos contadores con el mismo número de iteraciones. Reducir ahora el número de iteraciones del _segundo_ contador, y describir qué tipo de error ocurre.

Si la segunda tarea finaliza antes, le corresponde realizar una última llamada a `task_swap()` que:

1.  ceda por una vez más el procesador a la primera tarea
2.  anule la variable _esp_, de manera que la primera tarea no ceda más el control, hasta su finalización

Se podría definir una función a tal efecto:

```c
static void exit() {
    uintptr_t *tmp = ...
    esp = ...
    task_swap(...);
}
```

Completar la definición, y realizar una llamada a la misma al finalizar el ciclo principal de `contador_yield()`: ahora debería funcionar el caso en el que la segunda tarea termina primero.

A continuación, eliminar la llamada explícita a `exit()`, y programar su ejecución vía `contador_run()`, esto es: al preparar el stack del segundo contador.


## Interrupciones: reloj y teclado
{: #interrupts}

Para poder hacer planificación basada en intervalos de tiempo, es necesario tener configurada una interrupción de reloj que de manera periodica devuelva el control de la CPU al kernel. Así, en cada uno de esos instantes el kernel tendrá oportunidad de decidir si corresponde cambiar la tarea en ejecución.

El mismo mecanismo de interrupciones permite también el manejo de dispositivos físicos; por ejemplo, el teclado genera una interrupción para indicar al sistema operativo que se generó un evento (por ejemplo, la pulsación de una tecla).

<!--
En esta parte, se implementará un contador en pantalla que muestre, en segundos, el tiempo transcurrido desde el arranque del sistema. Para ello se configurará el reloj de la CPU para generar interrupciones una vez cada 100 ms. En cada interrupción, el sistema operativo tendrá oportunidad de actualizar el contador, si corresponde.
-->

### Ej: kern2-idt

El mecanismo de interrupciones se describe en detalle en **IA32-3A**, capítulo 6: _Interrupt and Exception Handling_. El objetivo de este primer ejercicio será la configuración de la tabla de interrupciones _(interrupt descriptor table)_. Para ello, se implementarán las siguientes funciones:

```c
// interrupts.c
void idt_init(void);
void idt_install(uint8_t n, void (*handler)(void));

// idt_entry.S
void breakpoint(void);
```

A continuación se proporciona una guía detallada.


#### Definiciones

Tras leer las secciones 6.1–6.5 6.10–6.11 de **IA32-3A** y las definiciones del archivo [interrupts.h](interrupts.h), responder:

1.  ¿Cuántos bytes ocupa una entrada en la IDT?

2.  ¿Cuántas entradas como máximo puede albergar la IDT?

3.  ¿Cuál es el valor máximo aceptable para el campo _limit_ del registro _IDTR_?

4.  Indicar qué valor exacto tomará el campo _limit_ para una IDT de 64 descriptores solamente.

5.  Consultar la sección 6.1 y explicar la diferencia entre interrupciones (§6.3) y excepciones (§6.4).

#### Variables estáticas

Declarar, en un nuevo archivo _interrupts.c_ dos variables globales estáticas para el registro _IDTR_ y para la _IDT_ en sí:

```c
#include "decls.h"
#include "interrupts.h"

static ... idtr;
static ... idt[...];
```

A estas variables se accederá desde `idt_init()` e `idt_install()`.

#### idt_init()

La función _idt_init()_ debe realizar las siguientes tareas:

  - inicializar los campos _base_ y _limit_ de la variable global _idtr:_

    ```c
    idtr.base = (uintptr_t) ...
    idtr.limit = ...
    ```

  - mediante la instrucción LIDT, activar el uso de la IDT configurada (inicialmente vacía). Se puede usar la instrucción:

    ```c
    asm("lidt %0" : : "m"(idtr));
    ```

#### kmain()

Para probar el funcionamiento de las rutinas de interrupción, se puede generar una excepción por software con la instrucción `INT3`. Así, antes de pasar a configurar el reloj, en la función _kmain()_ se añadirá:

```c
void kmain(const multiboot_info_t *mbi) {
    // ...

    two_stacks();
    two_stacks_c();

    // Código ejercicio kern2-idt.
    idt_init();   // (a)
    asm("int3");  // (b)

    vga_write2("Funciona vga_write2?", 18, 0xE0);
}
```

Si la implementación de _idt_init()_ es correcta, el kernel debería ejecutar la llamada **(a)** con éxito y lanzar un “triple fault” al llegar en **(b)** a la instrucción `INT3` (puesto que no se instaló aún una rutina para manejarla).[^commentint3]

[^commentint3]: Se aconseja dejar la instrucción `INT3` comentada hasta que se implemente _idt_init()_ correctamente. Asimismo, para agilizar el desarrollo, se puede dejar comentada la llamada a _contador_run()_.

#### idt_install()

La función _idt_install()_ actualiza en la tabla global `idt` la entrada correspondiente al código de excepción pasado como primer argumento. El segundo argumento es la dirección de la función que manejará la excepción.

En otras palabras, se trata de completar los campos de `idt[n]`:

```c
// Multiboot siempre define "8" como el segmento de código.
// (Ver campo CS en `info registers` de QEMU.)
static const uint8_t KSEG_CODE = 8;

// Identificador de "Interrupt gate de 32 bits" (ver IA32-3A,
// tabla 6-2: IDT Gate Descriptors).
static const uint8_t STS_IG32 = 0xE;

void idt_install(uint8_t n, void (*handler)(void)) {
    uintptr_t addr = (uintptr_t) handler;

    idt[n].rpl = 0;
    idt[n].type = STS_IG32;
    idt[n].segment = KSEG_CODE;

    idt[n].off_15_0 = addr & ...
    idt[n].off_31_16 = addr >> ...

    idt[n].present = 1;
}
```

Una vez implementada, desde _idt_init()_ se deberá instalar el manejador para la excepción _breakpoint_ (`T_BRKPT` definida en _interrupts.h);_ el manejador será la función `breakpoint()`, cuya implementación inicial también se incluye:

```c
void idt_init() {
    // (1) Instalar manejadores ("interrupt service routines").
    idt_install(T_BRKPT, breakpoint);

    // (2) Configurar ubicación de la IDT.
    idtr.base = (uintptr_t) ...
    idtr.limit = ...

    // (3) Activar IDT.
    asm("lidt %0" : : "m"(idtr));
}
```

Definir también, en un nuevo archivo _idt_entry.S_, una primera versión de la función _breakpoint()_ con una única instrucción `IRET`:

```nasm
.globl breakpoint
breakpoint:
        // Manejador mínimo.
        iret
```

Con esta primera definición, _kern2_ debería arrancar sin problemas, llegando hasta la ejecución de `vga_write2()`.

### Ej: kern2-isr
{: #ej-isr}

Cuando ocurre una excepción, la CPU inmediatamente invoca al manejador configurado, esto es, justo tras la instrucción original que produjo la excepción.

Un manejador de interrupciones (en inglés _interrupt service routine)_ es, salvo por algunos detalles, una función común sin parámetros.

Las diferencias principales son:

  - desde el punto de vista del manejador, en `(%esp)` se encuentra la dirección de retorno; la CPU, no obstante, añade alguna información adicional a la pila, tal y como se verá en la sesión de GDB que se solicita a continuación.

  - a diferencia del ejercicio [kern2-swap](#ej-swap), donde la propia tarea solicitaba un relevo con llamando explícitamente a _task_swap()_, ahora la tarea es desalojada de la CPU sin previo aviso. Desde el punto de vista de esa tarea original, la ejecución del manejador debería ser “invisible”, esto es, que el manejador deberá restaurar el estado exacto de la CPU antes de devolver el control de la CPU a la tarea anterior.

En este ejercicio se pide:

1.  Una sesión de GDB que muestre el estado de la pila antes, durante y después de la ejecución del manejador.

2.  Una implementación ampliada de `breakpoint()` que imprima un mensaje en el buffer VGA.

#### Sesión de GDB

Se debe seguir el mismo guión **dos veces**:

  - versión A: usando esta implementación aumentada del manejador:

    ```nasm
    .globl breakpoint
    breakpoint:
            nop
            test %eax, %eax
            iret
    ```

  - versión B: con el mismo manejador, pero cambiando la instrucción `IRET` por una instrucción `RET`.

Los pasos a seguir son:

0.  Activar la impresión de la siguiente instrucción ejecutando:

        display/i $pc

1.  Poner un breakpoint en la función _idt_init()_ y, una vez dentro, finalizar su ejecución con el comando de GDB `finish`. Mostrar, en ese momento, las siguientes instrucciones (con el comando `disas` o `x/10i $pc`): la ejecución debería haberse detenido en la misma instrucción `int3`.[^nobp] Mostrar:

      - el valor de _%esp_ (`print $esp`)
      - el valor de _(%esp)_ (`x/xw $esp`)
      - el valor de `$cs`
      - el resultado de `print $eflags` y `print/x $eflags`

2.  Ejecutar la instrucción `int3` mediante el comando de GDB `stepi`. La ejecución debería saltar directamente a la instrucción `test %eax, %eax`; en ese momento:

      - imprimir el valor de _%esp;_ ¿cuántas posiciones avanzó?
      - si avanzó _N_ posiciones, mostrar (con `x/Nwx $sp`) los _N_ valores correspondientes
      - mostrar el valor de `$eflags`

    Responder: ¿qué representa cada valor? (Ver IA32-3A, §6.12: _Exception and Interrupt Handling_.)

3.  Avanzar una instrucción más con `stepi`, ejecutando la instrucción `TEST`. Mostrar, como anteriormente, el valor del registro _EFLAGS_ (en dos formatos distintos, usando `print` y `print/x`).

4.  Avanzar, por última vez, una instrucción, de manera que se ejecute `IRET` para la sesión A, y `RET` para la sesión B. Mostrar, de nuevo lo pedido que en el punto 1; y explicar cualquier diferencia entre ambas versiones A y B.

[^nobp]: Para este ejercicio, se debe evitar poner un breakpoint en la instrucción `int3` directamente.

#### Versión final de breakpoint()

La versión de _breakpoint()_ a entregar simplemente realiza, desde _idt_entry.S,_ la siguiente llamada:

```c
vga_write2("Hello, breakpoint", 14, 0xB0);
```

siguiendo la estructura:

```nasm
.globl breakpoint
breakpoint:
        // (1) Guardar registros.
        ...
        // (2) Preparar argumentos de la llamada.
        ...
        // (3) Invocar a vga_write2()
        call vga_write2
        // (4) Restaurar registros.
        ...
        // (5) Finalizar ejecución del manejador.
        iret

.data
breakpoint_msg:
        .asciz "Hello, breakpoint"
```

Como se explicó al comienzo del ejercicio, la ejecución del manejador debe resultar invisible para la tarea original (en este caso, la función _kmain)_. Por tanto, se debe asegurar que todos los registros volvieron a su valor original antes de ejecutar `iret`.

Incluir las respuestas a las siguientes cuestiones:

1.  Para cada una de las siguientes maneras de guardar/restaurar registros en _breakpoint_, indicar si es correcto (en el sentido de hacer su ejecución “invisible”), y justificar por qué:

    ```nasm
    // Opción A.
    breakpoint:
        pusha
        ...
        call vga_write2
        popa
        iret

    // Opción B.
    breakpoint:
        push %eax
        push %edx
        push %ecx
        ...
        call vga_write2
        pop %ecx
        pop %edx
        pop %eax
        iret

    // Opción C.
    breakpoint:
        push %ebx
        push %esi
        push %edi
        ...
        call vga_write2
        pop %edi
        pop %esi
        pop %ebx
        iret
    ```

2.  Responder de nuevo la pregunta anterior, sustituyendo en el código `vga_write2` por `vga_write`. (Nota: el código representado con `...` correspondería a la nueva convención de llamadas.)

3.  Si la ejecución del manejador debe ser enteramente invisible ¿no sería necesario guardar y restaurar el registro _EFLAGS_ a mano? ¿Por qué?

4.  ¿En qué stack se ejecuta la función _vga_write()?_


### Ej: kern2-irq
{: #ej-irq}

Los códigos de excepción 0 a 31 forman parte de la definición de la arquitectura x86 (**IA32-3A**, §6.3.1); su significado es fijo. Los códigos 32 a 255 están disponibles para su uso bien por el sistema operativo, bien por dispositivos físicos del sistema.

En la arquitectura PC tradicional, la coordinación entre kernel y dispositivos físicos emplea un _Programmable Interrupt Controller_ (PIC) que, entre otras cosas, permite al sistema operativo:

  - detectar los dispositivos presentes
  - configurar aspectos de algunos de los dispositivos
  - asignar a cada uno de ellos un código de interrupción propio

En particular, el procesador i386 dispone de dos PIC 8259 capaces de manejar 8 fuentes de interrupción cada uno; en este lab, usaremos solamente el primero de ellos.

Al arrancar la máquina, no se genera interrupción alguna hasta que se habilita su uso con la instrucción `STI`. En ese momento, por ejemplo, si se hace uso del teclado, se generaría una interrupción. En _kern2_, esto se hará desde una nueva función _irq_init():_

```c
// interrupts.c
void irq_init() {
    // (1) Redefinir códigos para IRQs.
    ...

    // (2) Instalar manejadores.
    ...

    // (3) Habilitar interrupciones.
    asm("sti");
}

// kern2.c
void kmain(const multiboot_info_t *mbi) {
    // ...
    idt_init();
    irq_init();   // Nueva función.
    asm("int3");

    vga_write2("Funciona vga_write2?", 18, 0xE0);
}
```

Si no se completan los puntos **(1)** y **(2)** de la función _irq_init()_, al ejecutar _kern2_ se producirá de nuevo un “triple fault” porque —entre otras cosas— el reloj del sistema comienza a lanzar interrupciones para las que no hay un manejador. Se deberá instalar uno que al menos comunique al PIC que se procesó la interrupción:

```c
void irq_init() {
    irq_remap();

    idt_install(T_TIMER, ack_irq);
    idt_install(T_KEYBOARD, ack_irq);

    asm("sti");
}
```

definiendo, en _idt_entry.S:_

```nasm
#define PIC1 0x20
#define ACK_IRQ 0x20

.globl ack_irq:
ack_irq:
        // Indicar que se manejó la interrupción.
        movl $ACK_IRQ, %eax
        outb %al, $PIC1
        iret
```

Observaciones:

  - se instala el mismo manejador para el teclado, de manera que tampoco ocurran errores si se presiona una tecla en la ventana de QEMU.

  - por omisión, el modelo PIC 8259 usa el código 0 para el timer, y el código 1 para el teclado; pero estos códigos de excepción están en conflicto con los códigos propios de la arquitectura x86 (el código 0, por ejemplo, corresponde a un error en una operación `DIV`)

  - el propósito de la función `irq_remap()`, cuyo código se incluye a continuación, es desplazar los códigos de interrupción PIC de tal manera que comiencen en 32, y no en 0.

  - las constantes `T_TIMER` y `T_KEYBOARD` se definieron en el archivo _interrupts.h_ con valores 32 y 33, respectivamente.

    ```c
    #define outb(port, data) \
            asm("outb %b0,%w1" : : "a"(data), "d"(port));

    static void irq_remap() {
        outb(0x20, 0x11);
        outb(0xA0, 0x11);
        outb(0x21, 0x20);
        outb(0xA1, 0x28);
        outb(0x21, 0x04);
        outb(0xA1, 0x02);
        outb(0x21, 0x01);
        outb(0xA1, 0x01);
        outb(0x21, 0x0);
        outb(0xA1, 0x0);
    }
    ```

La necesidad de escribir los manejadores en assembler surge de la obligación de usar `iret` y no `ret` para finalizar su ejecución; pero se puede, desde assembler, invocar a rutinas escritas en C, por ejemplo:

```c
// handlers.c
#include "decls.h"

static unsigned ticks;

void timer() {
    if (++ticks == 15) {
        vga_write("Transcurrieron 15 ticks", 20, 0x07);
    }
}
```

Para poder invocar a esta función:

  - definir en _idt_entry.S_ un “trampolín” en assembler:

    ```nasm
    .globl timer_asm
    timer_asm:
            // Guardar registros.
            ...
            call timer
            // Restaurar registros.
            ...
            jmp ack_irq
    ```

  - en _interrupts.c_, instalar `timer_asm` en lugar de `ack_irq` para `T_TIMER`.


### Ej: kern2-div
{: #ej-div}

En este último ejercicio se estudia el subtipo particular de excepción llamado _fault_ (ver **IA32-3A** §6.5 y §6.6).

Cuando ocurre una interrupción, o una excepción de tipo _trap_, se ejecuta inmediatamente el manejador y, una vez finalizado éste, se reanuda la ejecución de la tarea original en la _siguiente_ instrucción. Por el contrario, para excepciones de tipo _fault_, se vuelve a intentar la _misma_ instrucción.[^segfault]

[^segfault]: Esta funcionalidad es principalmente útil cuando comienza a haber procesos no privilegiados de usuario, ya que se da oportunidad al kernel de decidir qué hacer si un programa muestra un comportamiento anómalo (por ejemplo, intentar escribir en una región de memoria de sólo lectura).

La instrucción `DIV` genera una excepción _Divide Error_ (código numérico 0) cuando, entre otros casos, el divisor es 0. Como la división por 0 también es comportamiento no definido en C, usaremos directamente inline assembly para generar la excepción desde _kmain()_.

Se pide:

1.  Modificar la función _kmain()_ como se indica, y verificar que _kern2_ arranca e imprime sus mensajes de manera correcta:

    ```c
    void kmain(const multiboot_info_t *mbi) {
        int8_t linea;
        uint8_t color;

        // ...

        idt_init();
        irq_init();

        asm("div %4"
            : "=a"(linea), "=c"(color)
            : "0"(18), "1"(0xE0), "b"(1), "d"(0));

        vga_write2("Funciona vga_write2?", linea, color);
    }

    ```

2.  Explicar el funcionamiento exacto de la línea `asm(...)` del punto anterior:

      - ¿qué cómputo se está realizando?
      - ¿de dónde sale el valor de la variable _color_?
      - ¿por qué se da valor 0 a _%edx?_

3.  Asignar a _%ebx_ el valor 0 en lugar de 1, y comprobar que se genera una triple falla al ejecutar el kernel.

4.  Definir en _write.c_ una nueva variante de escritura:

    ```c
    void __attribute__((regparm(2)))
    vga_write_cyan(const char *s, int8_t linea) {
        vga_write(s, linea, 0xB0);
    }
    ```

5.  Escribir, en _idt_entry.S_, un manejador `divzero` a instalar desde _idt_init():_

    ```c
    idt_install(T_DIVIDE, divzero);
    ```

    El manejador debe, primero, incrementar el valor de _%ebx_, de manera que cuando se reintente la instrucción, ésta tenga éxito.

    Asimismo, realizar desde assembly la llamada:

    ```c
    vga_write_cyan("Se divide por ++ebx", 17);
    ```

    Requerimiento: no usar `pusha`/`popa`; guardar y restaurar el mínimo número de registros necesarios.

### Ej: kern2-kbd ★
{: #ej-kbd}

En el archivo [handlers.c](handlers.c) se incluyen un par de ejemplos de manejo del timer y del teclado. Sobre el código del teclado se pide:

  - manejar la tecla Shift, y emitir caracteres en mayúsculas cuando esté presionada.

Documentación [de ejemplo](http://www.osdever.net/bkerndev/Docs/keyboard.htm).

## Desalojo
{: #preempt}


## Enlazado y archivos ELF
{: #elf}


{% include anchors.html %}
{% include footnotes.html %}
