% Lab kern2
% Juan Pablo Capurro - 98194
% 13/9/2017

# Conocimientos previos

## asm-inc 

#### Explicar los parámetros de la instrucción `asm` mostrada.
La instrucción hará un incremento(por la instrucción `inc`) de la variable `x`, dándole la libertad al compilador de usar para ello cualquier registro de uso general o hacer acceso directo a memoria(restricción `g`).

#### Describir, usando para ello la salida de objdump -d, la correspondencia entre el código original y las instrucciones assembler generadas tras la compilación

La primer línea es parte del preámbulo de gcc para ejecutar las instrucciones pedidas, que carga el valor de `x` al registro `eax`.
La segunda es la instrucción explicitada, con los parámetros reemplazados, y la tercera es el `return x` de la línea siguiente. GCC prefiere el uso del registro `eax` para ahorrarse una instrucción extra para retornar el valor de `x`
```
00000000 <inc>:
   0:   8b 44 24 04             mov    0x4(%esp),%eax
   4:   40                      inc    %eax
   5:   c3                      ret
```

#### Mostrar, de nuevo usando gcc -c y objdump -d, en qué cambia el código generado para la siguiente versión, y razonar el por qué de las diferencias

El código generado para `int2` fuerza que el incremento se haga en memoria, y que luego el valor incrementado se mueva a la variable `ret`. GCC optimiza el retorno de dicho valor al compilar con `-O1`, no así con `-O0`, caso en el cual copia el resultado del incremento a la posición de memoria que ocupaba `ret`.
compilando con `-O1`
```
00000006 <inc2>:
   6:   ff 44 24 04             incl   0x4(%esp)
   a:   8b 44 24 04             mov    0x4(%esp),%eax
   e:   c3                      ret
```
compilando con `-O0`
```
0000000f <inc2>:
   f:   55                      push   %ebp
  10:   89 e5                   mov    %esp,%ebp
  12:   83 ec 10                sub    $0x10,%esp
  15:   ff 45 08                incl   0x8(%ebp)
  18:   8b 45 08                mov    0x8(%ebp),%eax
  1b:   89 45 fc                mov    %eax,-0x4(%ebp)
  1e:   8b 45 fc                mov    -0x4(%ebp),%eax
  21:   c9                      leave
  22:   c3                      ret
```

##### ¿Sería válido especificar `"m"(x)` si `inc` solo funcionase con un registro como operando?
No, no sería válido ya que a GCC lesería imposible formar una instrucción correcta.

#### Recompilar ambas versiones cambiando incl por inc y, si alguna de las dos versiones no compila, explicar el porqué de la diferencia.

`inc1` compila haciendo el cambio pedido, `inc2` no, con el mensaje de error `Error: no instruction mnemonic suffix given and no register operands; can't size instruction`
`inc1`, al indicársele con `=g` que puede usar cualquier registro, puede saber que el operando en cuestión ocupa una palabra, mientras que `inc2` pide que la instrucción no use registros, por lo que a la hora de generar el código objeto, no hay forma de deducir de qué largo es el operando.

## asm-ptr
#### Se proponen las siguientes tres implementaciones de inc_p(); indicar cuáles funcionan y cuáles no y, examinando el código generado por gcc, explicar por qué

```
0804846b <inc_p_0>:
 804846b:       55                      push   %ebp
 804846c:       89 e5                   mov    %esp,%ebp
 804846e:       ff 45 08                incl   0x8(%ebp)
 8048471:       90                      nop
 8048472:       5d                      pop    %ebp
 8048473:       c3                      ret

08048474 <inc_p_1>:
 8048474:       55                      push   %ebp
 8048475:       89 e5                   mov    %esp,%ebp
 8048477:       8b 45 08                mov    0x8(%ebp),%eax
 804847a:       ff 00                   incl   (%eax)
 804847c:       90                      nop
 804847d:       5d                      pop    %ebp
 804847e:       c3                      ret

0804847f <inc_p_2>:
 804847f:       55                      push   %ebp
 8048480:       89 e5                   mov    %esp,%ebp
 8048482:       8b 45 08                mov    0x8(%ebp),%eax
 8048485:       ff 00                   incl   (%eax)
 8048487:       90                      nop
 8048488:       5d                      pop    %ebp
 8048489:       c3                      ret
```
Sólo funcionan las implementaciones 1 y 2, ya que la 0 no modifica el valor apuntado por `p` sino el valor del puntero `p`, desplazándolo un byte hacia adelante.

| Opciones gcc      | ::"m"(*p) | :"=m"(*p)    |
| ---:              | :---:     | :---:        |
| `-O2`             | n=0       | n = -8013875 |
| `-O2 -fno-inline` | n=1       | n=1          |

Al permitirle a GCC hacer inline automático de las funciones, la variante _1_ se rompe porque no considera a `*p` un operando de salida, y por ende no se guarda en `n` el resultado del incremento. La variante _2_ se rompe porque no considera a `*p` un operando de entrada, por lo que no lee el valor de `n` de memoria antes de incrementarlo. El código correcto sería `asm("incl %0" : "=m"(*p) : "m"(*p));`. Es posible hacerlo con matching constraints (  `asm("incl %0" : "=m"(*p) : "0"(*p));`), pero gcc da warnings de `matching constraint does not allow a register`.


## asm-regs 

#### Completar los constraints en la función my_write, de manera que la llamada al sistema funcione.

`asm("int $0x80" : : "a"(SYS_write), "b"(1), "c"(msg), "d"(count));`

#### ¿En qué cambia el código generado (incluyendo el código de main) si se declara my_write con atributo fastcall?

con _fastcall_:
```
$ gcc -o my_write -O2 -fno-inline -m32 my_write.c && ./my_write
Hello, world!

080482e0 <main>:
 80482e0:       ba 0e 00 00 00          mov    $0xe,%edx
 80482e5:       b9 80 84 04 08          mov    $0x8048480,%ecx
 80482ea:       e8 01 01 00 00          call   80483f0 <my_write>
 80482ef:       31 c0                   xor    %eax,%eax
 80482f1:       c3                      ret

080483f0 <my_write>:
 80483f0:       53                      push   %ebx
 80483f1:       b8 04 00 00 00          mov    $0x4,%eax
 80483f6:       bb 01 00 00 00          mov    $0x1,%ebx
 80483fb:       cd 80                   int    $0x80
 80483fd:       5b                      pop    %ebx
 80483fe:       c3                      ret
 80483ff:       90                      nop

```
sin _fastcall_:
```
$ gcc -o my_write -O2 -fno-inline -m32 my_write.c && ./my_write
Hello, world!

080483f0 <my_write>:
 80483f0:       53                      push   %ebx
 80483f1:       b8 04 00 00 00          mov    $0x4,%eax
 80483f6:       bb 01 00 00 00          mov    $0x1,%ebx
 80483fb:       8b 54 24 0c             mov    0xc(%esp),%edx
 80483ff:       8b 4c 24 08             mov    0x8(%esp),%ecx
 8048403:       cd 80                   int    $0x80
 8048405:       5b                      pop    %ebx
 8048406:       c3                      ret
 8048407:       66 90                   xchg   %ax,%ax
 8048409:       66 90                   xchg   %ax,%ax
 804840b:       66 90                   xchg   %ax,%ax
 804840d:       66 90                   xchg   %ax,%ax
 804840f:       90                      nop

080482e0 <main>:
 80482e0:       6a 0e                   push   $0xe
 80482e2:       68 90 84 04 08          push   $0x8048490
 80482e7:       e8 04 01 00 00          call   80483f0 <my_write>
 80482ec:       58                      pop    %eax
 80482ed:       31 c0                   xor    %eax,%eax
 80482ef:       5a                      pop    %edx
 80482f0:       c3                      ret
```

Con niveles mayores de optimización y _fastcall_, el pasaje de parámetros se hace con registros cuando es posible.

## asm-volatile

#### Indicar qué ocurre al ejecutar el programa con las siguientes modificaciones, explicando por qué funciona, o no:

##### Eliminando el modificador volatile de la instrucción assembler.
El programa imprime `Hello, write2!` como se espera.
##### Con volatile de vuelta en su lugar, eliminando el if (!result) ... de la función main.
El programa imprime `Hello, write2! \n write2 falló`, como se espera, ya que _volatile_ le indica al compilador que las instrucciones dentro del _asm_ tienen _side effects_, por lo que deben ser ejecutadas independientemente de si sus parámetros de salida son usados o no.
##### Eliminando tanto volatile como la comprobación del booleano. ¿Qué código genera gcc para main en este caso? ¿Cambió el código generado para my_write2?
El programa solo imprime `write2 falló`, porque el compilador no ejecuta el contenido de _asm_ si considera que sus parámetros de salida no son relevantes (es decir, no son usados).

#### ¿Por qué no se hizo necesario _volatile_ en el ejercicio asm-regs, ni tampoco en asm-inc?
En `asm-inc,` no es necesario _volatile_ ya que los parámetros de salida de asm son usados (se retornan de la función y luego se imprimen por pantalla más adelante en el código, es decir, son parámetro de entrada de otra operación).
En `asm-regs,` no es necesario _volatile_ ya que si un statement asm no tiene operandos de salida es implícitamente _volatile_.

# Concurrencia cooperativa

## kern2-task
stacks.S:
```asm
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
    .asciz "vga_write from stack1"
msg2:
    .asciz "vga_write from stack2"

former_ebp:
    .long 0
former_esp:
    .long 0

.text
.globl two_stacks
two_stacks:
    // Preámbulo estándar
    push %ebp
    movl %esp, %ebp
    push %ebx

    // Registros para apuntar a stack1 y stack2.
    mov $stack1_top, %eax
    mov $stack2_top, %ebx   // Decidir qué registro usar.

    // Cargar argumentos a ambos stacks en paralelo. Ayuda:
    // usar offsets respecto a %eax ($stack1_top), y lo mismo
    // para el registro usado para stack2_top.
    movl $0x17, -4(%eax)
    movl $0x90, -4(%ebx)

    movl $12, -8(%eax)
    movl $13, -8(%ebx)

    movl $msg1, -12(%eax)
    movl $msg2, -12(%ebx)

    // Realizar primera llamada con stack1. Ayuda: usar LEA
    // con el mismo offset que los últimos MOV para calcular
    // la dirección deseada de ESP.
    movl %ebp, (former_ebp)
    movl %esp, (former_esp)
    movl $0, %ebp
    leal -12(%eax), %esp
    call vga_write

    // Realizar segunda llamada con stack2.
    movl $0, %ebp
    leal -12(%ebx), %esp
    call vga_write

    // Restaurar registros callee-saved, si se usaron.
    movl (former_ebp), %ebp
    movl (former_esp), %esp
    pop %ebx

    leave
    ret
```
En el código propuesto, se proponía restaurar el stack entre las funciones, lo cual no era necesario, ya que se volvía a cargar `stack2` como antes de usar el stack original.
Al restaurar el stack original, no resultó suficiente restaurar `%ebp`, ya que sin restaurar `%esp` se pierde la referencia al tope del stack, y, por ejemplo, hacer `pop %ebx` no funcionaría.

## kern2-exec

kern2.c
```C
#include "decls.h"
#include "multiboot.h"
#define USTACK_SIZE 4096

static uint8_t stack1[USTACK_SIZE] __attribute__((aligned(4096)));
static uint8_t stack2[USTACK_SIZE] __attribute__((aligned(4096)));

void kmain(const multiboot_info_t *mbi) {
    vga_write("kern2 loading.............", 8, 0x70);

    // A remplazar por una llamada a two_stacks(),
    // definida en stacks.S.
    two_stacks_c();
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

    // Segunda llamada con ASM directo.
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
```
tasks.S
```asm
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
```

## kern2-regcall

funcs.S
```asm
.globl vga_write2
vga_write2:
        push %ebp
        movl %esp, %ebp
        
        push %ecx
        push %edx
        push %eax
        call vga_write

        leave
        ret
```
llamada a `vga_write2`
```
001003c0 <kmain>:
  ...
  100400:       8d 05 47 0a 10 00       lea    0x100a47,%eax
  100406:       ba 12 00 00 00          mov    $0x12,%edx
  10040b:       b9 e0 00 00 00          mov    $0xe0,%ecx
  100410:       e8 b3 fc ff ff          call   1000c8 <vga_write2>
  ...
```

## kern2-swap

`contador_run` y una función auxiliar:
```C
void contador_run() {
    uintptr_t* top_stack_verde= (uintptr_t*) stack_verde + USTACK_SIZE -1;
    uintptr_t params_stack_verde[]= {100, 0, 0x2F}; // unicamente necesito poner los argumentos
                                                    // de contador_yield con el stack verde

    uintptr_t* top_stack_rojo= (uintptr_t*) stack_rojo+ USTACK_SIZE -1;
    uintptr_t params_stack_rojo[]= {
        0,                        // los primeros cuatro lugares
        0,                        // los relleno con valores para los registros que
        0,                        // popea task_swap
        0,                        //
        (uintptr_t)contador_yield,// direccion a la que retornara task_swap
                                  // en la primer llamada
        0,                        // direccion a la que retornara contador_yield con el stack rojo
                                  //nomas relleno para que encuentre bien los argumentos
        100,                      //
        1,                        // argumentos de contador_yield
        0x1F                      //
    };
    top_stack_rojo = (uintptr_t*)make_stack(top_stack_rojo, params_stack_rojo, 9);
    esp = (uintptr_t*)top_stack_rojo;
    task_exec((uintptr_t)contador_yield, make_stack(top_stack_verde, params_stack_verde, 3));
}

uintptr_t make_stack(uintptr_t* stack_top, uintptr_t params[], uint8_t param_count){
    stack_top -= param_count;
    for (size_t i = 0; i< param_count; i++){
        stack_top[i]= params[i];
    }
    return (uintptr_t)stack_top;
}
```
task_swap:
```asm
.globl task_swap
task_swap:
    movl 4(%esp), %eax
    push %ebx
    push %ebp
    push %esi
    push %edi

    xchg %esp, (%eax)
    pop %edi
    pop %esi
    pop %ebp
    pop %ebx
    ret
```

## kern2-exit

#### Describir qué error ocurre al reducir el número de iteraciones del segundo contador
Al reducir el número de iteraciones del primer contador, el kernel no crashea pero ambos contadores llegan al primer tope.
Al reducir el segundo tope, el kernel crashea porque intenta retornar de contador_yield con el stack rojo, que no tiene una dirección de retorno válida.

```C
static void exit(){
    uintptr_t* tmp = esp;
    esp = NULL;
    task_swap(&tmp);
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
        (uintptr_t)exit,          // direccion a la que retornara contador_yield con el stack rojo
        100,                      //
        1,                        // argumentos de contador_yield
        0x1F                      //
    };
    top_stack_rojo = (uintptr_t*)make_stack(top_stack_rojo, params_stack_rojo, 9);
    esp = (uintptr_t*)top_stack_rojo;
    task_exec((uintptr_t)contador_yield, make_stack(top_stack_verde, params_stack_verde, 3));
}
```
estas modificaciones solucionan el problema de que el kernel crashea si el segundo contador termina primero, pero no evita que la cuenta del segundo contador siga una vez que finaliza la del primero.


# Interrupciones: reloj y teclado

## kern2-idt
Tras leer las secciones 6.1–6.5 6.10–6.11 de IA32-3A y las definiciones del archivo interrupts.h, responder:

#### ¿Cuántos bytes ocupa una entrada en la IDT?
Cada entrada ocupa 8 bytes.

#### ¿Cuántas entradas como máximo puede albergar la IDT?
Como máximo, puede albergar 256 entradas.

#### ¿Cuál es el valor máximo aceptable para el campo limit del registro IDTR?
El valor máximo admisible es 2047.

#### Indicar qué valor exacto tomará el campo limit para una IDT de 64 descriptores solamente.
511.

#### Consultar la sección 6.1 y explicar la diferencia entre interrupciones (§6.3) y excepciones (§6.4).
La diferencia entre excepciones e interrupciones radica en que las interrupciones pueden ser generadas en cualquier momento por software o hardware, mientras que las excepciones se generan por el propio procesador cuando alguna de las múltiples condiciones que chequea no se cumplen (ejemplo: acceso inválido a memoria o división por cero).

interrupts.c
```
void idt_init(void){
    idtr.base  = (uintptr_t) idt;
    idtr.limit = 256*8-1;
    __asm__("lidt %0" : : "m"(idtr));
}

void idt_install(uint8_t n, void (*handler)(void)) {
    uintptr_t addr = (uintptr_t) handler;

    idt[n].rpl = 0;
    idt[n].type = STS_IG32;
    idt[n].segment = KSEG_CODE;

    idt[n].off_15_0 = addr & 0x0000FFFF;
    idt[n].off_31_16 = addr >> 16;

    idt[n].present = 1;
}
```
## kern2-isr

Nota: `idt_install` es la función que se llama inmediatamente antes de la interrupción _int3_, así que el breakpoint lo pongo ahí, y no en _idt_init_

#### Guiones de GDB

Versión A:
```
(gdb) b idt_install
Breakpoint 1 at 0x100dfe: file interrupts.c, line 17.
(gdb) c
Continuing.

Breakpoint 1, idt_install (n=3 '\003', handler=0x1000e8 <breakpoint>) at interrupts.c:17
17          uintptr_t addr = (uintptr_t) handler;
(gdb) display/i $pc
1: x/i $pc
=> 0x100dfe <idt_install+14>:   mov    0xc(%ebp),%edx
(gdb) finish
Run till exit from #0  idt_install (n=3 '\003', handler=0x1000e8 <breakpoint>) at interrupts.c:17
kmain (mbi=0x9500) at kern2.c:18
18          __asm__("int3");
1: x/i $pc
=> 0x100438 <kmain+104>:        int3
(gdb) disas
Dump of assembler code for function kmain:
 ---
   0x00100406 <+54>:    call   0x1000f0 <vga_write>
   0x0010040b <+59>:    call   0x10002c <two_stacks>
   0x00100410 <+64>:    call   0x100460 <two_stacks_c>
   0x00100415 <+69>:    call   0x100dd0 <idt_init>
   0x0010041a <+74>:    mov    $0x3,%eax
   0x0010041f <+79>:    lea    0x1000e8,%ecx
   0x00100425 <+85>:    movl   $0x3,(%esp)
   0x0010042c <+92>:    mov    %ecx,0x4(%esp)
   0x00100430 <+96>:    mov    %eax,-0x14(%ebp)
   0x00100433 <+99>:    call   0x100df0 <idt_install>
=> 0x00100438 <+104>:   int3
   0x00100439 <+105>:   call   0x100b00 <contador_run>
   0x0010043e <+110>:   lea    0x100eaf,%eax
   0x00100444 <+116>:   mov    $0x12,%edx
   0x00100449 <+121>:   mov    $0xe0,%ecx
   0x0010044e <+126>:   call   0x1000d8 <vga_write2>
   0x00100453 <+131>:   add    $0x24,%esp
   0x00100456 <+134>:   pop    %esi
   0x00100457 <+135>:   pop    %ebp
   0x00100458 <+136>:   ret
End of assembler dump.
(gdb) p $esp
$1 = (void *) 0x104fcc
(gdb) x/xw $esp
0x104fcc:       0x00000003
(gdb) p $cs
$2 = 8
(gdb) p $eflags
$3 = [ ]
(gdb) p/x $eflags
$4 = 0x2
(gdb) stepi
breakpoint () at idt_entry.S:4
4               test %eax, %eax
1: x/i $pc
=> 0x1000e9 <breakpoint+1>:     test   %eax,%eax
(gdb) p $esp
$5 = (void *) 0x104fc0
(gdb) x/4wx $esp
0x104fc0:       0x00100439      0x00000008      0x00000002      0x00000003
(gdb) stepi
5               iret
1: x/i $pc
=> 0x1000eb <breakpoint+3>:     iret
(gdb) p $eflags
$6 = [ PF ]
(gdb) p/x $eflags
$7 = 0x6
(gdb) si
kmain (mbi=0x9500) at kern2.c:19
19          contador_run();
1: x/i $pc
=> 0x100439 <kmain+105>:        call   0x100b00 <contador_run>
(gdb) p $esp
$8 = (void *) 0x104fcc
(gdb) x/xw $esp
0x104fcc:       0x00000003
(gdb) p $cs
$9 = 8
(gdb) p $eflags
$10 = [ ]
(gdb) p/x $eflags
$11 = 0x2
(gdb)
```
#### Cuántas posiciones avanza `esp` al entrar a _breakpoint_? Qué representa cada valor?
`esp` avanza tres palabras, se ve bien claro al usar `x/4wx`, el primer valor pusheado es el registro `EFLAGS`, el segundo el registro `cs`, y el tercero, la dirección a la cual retornar del interrupt.

Versión B:
```
-- No hay diferencia hasta acá
breakpoint () at idt_entry.S:4
4               test %eax, %eax
(gdb) x/4wx $esp
0x104fc0:       0x00100439      0x00000008      0x00000002      0x00000003
(gdb) si
5               ret
(gdb) x/4wx $esp
0x104fc0:       0x00100439      0x00000008      0x00000002      0x00000003
(gdb) si
kmain (mbi=0x9500) at kern2.c:19
19          contador_run();
(gdb) x/4wx $esp
0x104fc4:       0x00000008      0x00000002      0x00000003      0x001000e8
(gdb)
```
##### Explicar qué diferencia hay entre la versión A y B al retornar de _breakpoint_
La diferencia radica en que `ret` saca menos cosas del stack que `iret`, por lo que al retornar del interrupt handler en la versión B quedan en el stack los valores de `cs` y `EFLAGS`. Esto puede ser problemático ya que corrompe el stack de _kmain_.

##### Version definitiva de breakpoint
```

```
#### Responder:
1. Para cada una de las maneras planteadas de guardar/restaurar registros en breakpoint, indicar si es correcto (en el sentido de hacer su ejecución “invisible”), y justificar por qué:

    Para responder esta pregunta primero conviene analizar qué responsabilidades tiene _breakpoint_: Esta debe guardar los caller-saved registers (ya que la llamada a _vga_write_ o _vga_write2_ puede sobreescribirlos), y también guardar los registros que use (para ser _invisible_). De guardar los calle-saved registers se encarga la llamada a _vga_write_ o _vga_write_2. Entonces:
    * **Opcion A**: Es válida, ya que preserva todos los registros de uso general.
    * **Opcion B**: Restaura los caller-saved registers, y la llamada a función no modificará los calle-saved registers, así que es válida.
    * **Opcion C**: No restaura `ecx`, `edx` ni `eax`, que son usados para pasar los parámetros a _vga_write2_

2. Responder de nuevo la pregunta anterior, sustituyendo en el código vga_write2 por vga_write. 
    * **Opcion A**: Es válida, ya que preserva todos los registros de uso general.
    * **Opcion B**: Es válida si se asume que 'el código representado con `...` correspondería a la convención de llamadas' incluye también sacar del stack los parámetros que se pushearon para pasársele a _vga_write_
    * **Opcion C**: No restaura `ecx`, `edx` ni `eax`, que son caller-saved, y _vga_write_ puede modificar, ademas de presentar el mismo problema que la opción anterior.

3. Si la ejecución del manejador debe ser enteramente invisible ¿no sería necesario guardar y restaurar el registro EFLAGS a mano? ¿Por qué?
    
    No es necesario restaurar manualmente EFLAGS ya que la instrucción `iret` se encarga de ello.

4. ¿En qué stack se ejecuta la función _vga_write()_ ?

    _vga_write_ se ejecutará en el mismo stack que _kmain_, y verá a kmain como la función que la llamó, ya que _breakpoint_ no genera un stack frame.



## kern2-irq


## kern2-div


## kern2-kbd ★


