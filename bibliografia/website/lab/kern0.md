# Kernel mínimo en C

Para realizar el lab, se debe [**instalar el software necesario**](../kit.md#tools). La entrega se realiza en horario de clase del día indicado siguiendo las [instrucciones de entrega en papel](../entregas.md#papel).

## Índice
{:.no_toc}

* TOC
{:toc}


## Compilar un kernel y lanzarlo en QEMU
{: #boot}

- Lecturas obligatorias[^bibref]

  - BRY2
    - cap. 1: §1-10

- Lecturas recomendadas

  - BRY2
    - cap. 2: §1-3
{:.biblio}

El siguiente código, una vez lanzado en el procesador, constituye un kernel completo con una única tarea: mantener la computadora prendida.

```nasm
comienzo:
    jmp comienzo
```

Es equivalente al siguiente bucle infinito en C:

```c
void comienzo(void) {
    while (1)
        continue;
}
```

El código se compila con gcc, siempre (en estos labs) en modo 32-bits:

    $ gcc -g -m32 -O1 -c kern0.c

Una vez compilado el código del kernel, se debe generar una imagen binaria que pueda ser ejecutada bien en una computadora física, bien en un simulador como [QEMU]. Para ello, se deben enlazar los objetos  (archivos `*.o`) con las instrucciones de arranque que correspondan según la arquitectura.

El estándar [Multiboot] simplifica enormemente la tarea, pues permite arrancar un kernel directamente en _protected mode_ (32-bits) sin tener que cargar la imagen desde disco, ni realizar el paso desde _real mode_ a mano (ver ejercicio [kern2-mbr](kern0.md#ej-mbr)).  _Grub_ y muchos otros gestores de arranque ofrecen soporte para multiboot; en QEMU se activa mediante la opción `-kernel` (versión 1 de multiboot solamente).

Para indicar al gestor de arranque que configure multiboot se debe incluir, en los primeros bytes del binario final, la constante numérica `0x1BADB002` y el [CRC] adecuado, ambos alineados a 32-bits; por ejemplo, en un archivo _boot.S:_

```nasm
#define MAGIC 0x1BADB002
#define FLAGS 0
#define CRC ( -(MAGIC + FLAGS) )

.align 4
multiboot:
    .long MAGIC
    .long FLAGS
    .long CRC
```

[QEMU]: https://en.wikipedia.org/wiki/QEMU
[Multiboot]: https://en.wikipedia.org/wiki/Multiboot_Specification
[CRC]: https://simple.wikipedia.org/wiki/Cyclic_redundancy_check
[bibliografía]: ../bibliografia.md
[^bibref]: Consultar lista de abreviaturas en la [bibliografía].

Así, el proceso completo para generar la imagen es:

    # Compilar C y ASM
    $ gcc -g -m32 -O1 -c kern0.c boot.S

    # Enlazar
    $ ld -m elf_i386 -Ttext 0x100000 kern0.o boot.o -o kern0

    # Lanzar
    $ qemu-system-i386 -serial mon:stdio -kernel kern0


### Ej: kern0-boot
{: #ej-boot}

Compilar _kern0_ y lanzarlo en QEMU tal y como se ha indicado.
Responder:

  - ¿emite algún aviso el proceso de compilado o enlazado? Si lo hubo, indicar cómo usar la opción [`--entry`] de _ld(1)_ para subsanarlo.

  - ¿cuánta CPU consume el proceso _qemu-system-i386_ mientras ejecuta este kernel? ¿Qué está haciendo?[^top]

[`--entry`]: https://sourceware.org/binutils/docs/ld/Entry-Point.html

[^top]: Se puede comprobar el uso de CPU de cada proceso en el sistema mediante el comando: `top -d 1` (salir pulsando `q`).


### Ej: kern0-quit
{: #ej-quit}

Para finalizar la ejecución de QEMU, se puede cerrar directamente la ventana. Alternativamente, y por haber especificado la opción `-serial mon:stdio`, se puede controlar la simulación desde la terminal en que se lanzó:

1.  Lanzar una vez más el kernel, y verificar que se puede finalizar su ejecución desde la terminal mediante la combinación de teclas `Ctrl-a x`.[^ctrlax]

2.  Asimismo, la combinación `Ctrl-a c` permite entrar al “monitor” de QEMU, desde donde se puede obtener información adicional sobre el entorno de ejecución. Ejecutar el comando `info registers` en el monitor de QEMU, e incluir el resultado en la entrega. (El mismo comando, `info reg`, existe también en GDB.)

Ejemplo:

```
$ qemu-system-i386 -serial mon:stdio -kernel kern0
<Ctrl-a c>

QEMU 2.8.1 monitor - type 'help' for more information
(qemu) info registers↩︎
EAX=...

(qemu) <Ctrl-a x>
QEMU: Terminated
```

[^ctrlax]: Esto es: presionar `Ctrl-a`, soltar, y a continuación teclear la letra `x` en minúscula.


### Ej: kern0-hlt
{: #ej-hlt}

Un sistema operativo debe mantener siempre, al menos, un flujo de ejecución en la CPU. De lo contrario, finalizaría la ejecución del kernel.

El ciclo infinito en `comienzo()` asegura un flujo de ejecución constante, pero mantiene a la CPU permanentemente ocupada.

La instrucción `hlt` se usa para detener la CPU cuando no hay trabajo “real” que realizar. La instrucción se puede incluir directamente en código C así:

```c
void comienzo(void) {
    while (1)
        asm("hlt");
}
```

Leer la página de Wikipedia [HLT (x86 instruction)][wphlt], y responder:

  - una vez invocado `hlt` ¿cuándo se reanuda la ejecución?

Usar el comando [powertop] para comprobar el consumo de recursos de ambas versiones del kernel. En particular, para cada versión, anotar:

  - columna _Usage:_ fragmento de tiempo usado por QEMU en cada segundo.

  - columna _Events/s:_ número de veces por segundo que QEMU reclama la atención de la CPU.


[wphlt]: https://en.wikipedia.org/wiki/HLT_(x86_instruction)
[powertop]: https://en.wikipedia.org/wiki/PowerTOP


### Ej: kern0-gdb
{: #ej-gdb}

- Lecturas obligatorias

  - BRY2
    - cap. 3: §1-5

- Lecturas recomendadas

  - BRY2
    - cap. 3: §6-12

  - yale.edu
    - [**x86 Assembly Guide**](http://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html)
{:.biblio}

Un kernel no puede correr directamente desde GDB, ya que la ejecución de dicho kernel debe ocurrir _afuera_ del sistema operativo sobre el cual corre GDB. No obstante, GDB permite depurar de manera [remota][gdbremote]. Para ello, GDB y el entorno remoto se comunican por red mediante un protocolo específico _([GDB Remote Serial Protocol][gdbserial])_.

En este caso, el “entorno remoto” es QEMU, el cual implementa el protocolo específico de GDB con la opción `-gdb` y un número de puerto TCP. Además, con la opción `-S` se indica a QEMU que no comience la ejecución del sistema hasta que así lo ordene remotamente GDB:

    $ qemu-system-i386 -serial mon:stdio \
                       -S -kernel kern0  \
                       -gdb tcp:127.0.0.1:7508

Entonces, desde otra terminal GDB se puede comunicar con esta ejecución del kernel:

    $ gdb -q -s kern0 -n -ex 'target remote 127.0.0.1:7508'

Mostrar una sesión de GDB en la que se realicen los siguientes pasos:[^powersave]

[^powersave]: Para cuidar tanto el medio ambiente como sus baterías, se recomienda haber completado el ejercicio [kern0-hlt](#ej-hlt) primero.

  - poner un breakpoint en la función _comienzo_ (p.ej. `b comienzo`)

  - continuar la ejecución hasta ese punto (`c`)

  - mostrar el valor del _stack pointer_ en ese momento (`p $esp`), así como del registro _%eax_ en formato hexadecimal (`p/x $eax`).[^gdbregnames] Responder:

      - ¿Por qué hace falta el modificador [`/x`][gdbfmt] al imprimir _%eax_, y no así _%esp_?
      - ¿Qué significado tiene el valor que contiene _%eax_, y cómo llegó hasta ahí? (Revisar la documentación de Multiboot, en particular la sección [Machine state][mbstate].)

  - el estándar Multiboot proporciona cierta informacion ([Multiboot Information][mbinfo]) que se puede consultar desde la función principal vía el registro _%ebx_. Desde el breakpoint en _comienzo_ imprimir, con el comando [`x/4xw`][gdbexam], los cuatro primeros valores enteros de dicha información, y explicar qué significan. A continuación, usar y mostrar las distintas invocaciones de `x/... $ebx + ...` necesarias para imprimir:
      - el campo _flags_ en formato binario
      - la cantidad de memoria “baja” en formato decimal (en [KiB])
      - la línea de comandos o “cadena de arranque” recibida por el kernel (al igual que en C, las expresiones de GDB permiten dereferenciar con el operador `*`)
      - si está presente (¿cómo saberlo?), el nombre del gestor de arranque.
      - la cantidad de memoria “alta”, en [MiB]. (Hacerlo en dos pasos, primero un comando `x` y a continuación una expresión con la variable de GDB [`$__`][gdbconv].)

[mbstate]: https://www.gnu.org/software/grub/manual/multiboot/html_node/Machine-state.html
[mbinfo]: https://www.gnu.org/software/grub/manual/multiboot/html_node/Boot-information-format.html
[gdbremote]: https://sourceware.org/gdb/onlinedocs/gdb/Remote-Debugging.html
[gdbserial]: https://sourceware.org/gdb/onlinedocs/gdb/Remote-Protocol.html
[gdbfmt]: https://sourceware.org/gdb/onlinedocs/gdb/Output-Formats.html
[gdbexam]: https://sourceware.org/gdb/onlinedocs/gdb/Memory.html
[gdbconv]: https://sourceware.org/gdb/onlinedocs/gdb/Convenience-Vars.html
[gdbreg]: https://sourceware.org/gdb/onlinedocs/gdb/Registers.html
[KiB]: https://en.wikipedia.org/wiki/Kibibyte
[MiB]: https://en.wikipedia.org/wiki/Mebibyte

[^gdbregnames]: Existe para cada registro una [variable asociada][gdbreg]. GDB define también cuatro variables genéricas que se definen según la arquitectura actual. En el caso de x86, la asociación es:

      - `$eip :: $pc` _(program counter)_
      - `$esp :: $sp` _(stack pointer)_
      - `$ebp :: $fp` _(frame pointer)_
      - `$eflags :: $ps` _(processor status)_

## Makefile y flags de compilación
{: #make}

- Lecturas obligatorias

  - BRY2
    - cap. 7: §1-3
{:.biblio}

Se puede usar el siguiente archivo _Makefile_ para simplificar la compilación del kernel (utilizando la solución al ejercicio [kern0-boot](#ej-boot) para completar `--entry ???`):

```
CFLAGS := -g -m32 -O1

kern0: boot.o kern0.o
	ld -m elf_i386 -Ttext 0x100000 --entry ??? $^ -o $@
	# Verificar imagen Multiboot v1.
	grub-file --is-x86-multiboot $@

%.o: %.S
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f kern0 *.o core

.PHONY: clean
```

A continuación se proponen unos ejercicios para expandir este _makefile_, y los flags de compilación usados. Referencias útiles sobre _make_:

  - [Implicit rules][implr]
  - [Pattern rules][pattr]
  - [Invoking make][invok]

[implr]: https://www.gnu.org/software/make/manual/html_node/Implicit-Rules.html
[invok]: https://www.gnu.org/software/make/manual/html_node/Running.html
[pattr]: https://www.gnu.org/software/make/manual/html_node/Pattern-Rules.html


### Ej: make-flags
{: #ej-flags}

Todo el código C de la materia debe seguir el estándar [C99]. A continuación se describen las opciones de compilación que se deben usar:

  - Para todo el código C de la materia:

        CFLAGS := -g -std=c99 -Wall -Wextra -Wpedantic

  - Adicionalmente, para código de kernel (labs _kern0_ y _kern2_):

        CFLAGS += -m32 -O1 -ffreestanding

Se pide:

1.  Recompilar el kernel usando `make` y, si ocurre algún error en la línea `asm("hlt")`, explicar por qué ocurre y por qué la opción `-fasm` lo arregla.[^fasm]

2.  ¿Qué compilador usa _make_ por omisión? ¿Es o no gcc? Explicar cómo se podría forzar el uso de [clang]:

      - por una sola vez, desde la línea de comandos.
      - para todas las compilaciones del proyecto.

3.  Leer la sección sobre `-ffreestanding` en [Guide to Bare Metal Programming with GCC][107gcc] (la segunda sección, sobre `-nostdlib`, se cubre en el lab [x86](x86.md)); responder:

    - ¿Se pueden usar booleanos en modo “free standing”?

    - ¿Dónde se definen los tipos `uint8_t`, `int32_t`, etc.?

    - Teniendo en cuenta los tamaños de `char`, `short`, `int`, `long` y `long long`, escribir un archivo _c99int.h_ con las directivas `typedef` necesarias para definir tipos enteros propios de 8, 16, 32 y 64 bits, con signo y sin signo. Por ejemplo:

          typedef short uint16_t;
          typedef unsigned short uint16_t;

      Hacerlo de manera que las mismas directivas puedan usarse en x86 y x86\_64. Se recomienda poner especial atención en el signo de `char` y el tamaño de `long`.

[C99]: https://en.wikipedia.org/wiki/C99
[clang]: https://en.wikipedia.org/wiki/Clang
[107gcc]: https://cs107e.github.io/guides/gcc/

[^fasm]: Para encontrar `-fasm` en la página de manual `gcc(1)`, buscar [`-fno-asm`](https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html).


### Ej: make-pattern
{: #ej-pattern}

  - ¿Cómo funciona la regla que compila _boot.S_ a _boot.o_?
  - ¿Qué son las variables `$@`, `$^` y `$<`?
  - La regla _kern0_ usa `$^` y la regla con _%.S_ usa `$<`. ¿Qué ocurriría si se intercambiaran estas dos variables entre ambas reglas?


### Ej: make-implicit
{: #ej-implicit}

  - ¿Mediante qué regla se genera el archivo _kernel.o_?
  - Eliminar la regla `%.o: %.S` y ejecutar `make clean kern0`:
    - ¿Se llega a generar el archivo _boot.o_?
    - ¿Ocurre algún otro error? (Si no ocurre, mostrar la salida del comando `uname -m`).
    - ¿Se puede subsanar el error sin re-introducir la regla eliminada?


### Ej: make-wildcard
{: #ej-wildcard}

Según aumenta el tamaño del kernel, se hace tedioso especificar uno a uno todos los archivos objeto que componen el kernel. Se pueden usar las funciones [wildcard] y [patsubst] de _make_ para obtener la lista de todos los archivos C del directorio actual, y de ahí derivar la lista de objetos a enlazar.

Reconfigurar el archivo _Makefile_ para que quede así:

```
SRCS := ...  # usar wildcard *.c
OBJS := ...  # usar patsubst sobre SRCS

kern0: boot.o $(OBJS)
	...
```

Inicialmente, `SRCS` contendría tan solo _kern0.c_.

[wildcard]: https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
[patsubst]: https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

#### Reglas QEMU
{: #make-qemu}

Al archivo _Makefile_ se le pueden agregar las siguientes reglas para facilitar la ejecución y depurado con QEMU:

```
QEMU := qemu-system-i386 -serial mon:stdio
KERN := kern0
BOOT := -kernel $(KERN)

qemu: $(KERN)
	$(QEMU) $(BOOT)

qemu-gdb: $(KERN)
	$(QEMU) -kernel kern0 -S -gdb tcp:127.0.0.1:7508 $(BOOT)

gdb:
	gdb -q -s kern0 -n -ex 'target remote 127.0.0.1:7508'

.PHONY: qemu qemu-gdb gdb
```


## El buffer VGA

- Lecturas obligatorias

  - REES
    - cap. 1

- Lecturas recomendadas

  - K&R
    - cap. 5: §1-6
{:.biblio}

El siguiente kernel imprime, de manera bastante rudimentaria, un mensaje por pantalla al arrancar, usando el [buffer VGA][vga]:

```c
#define VGABUF ((volatile char *) 0xb8000)

void comienzo(void) {
    volatile char *buf = VGABUF;

    *buf++ = 79;
    *buf++ = 47;
    *buf++ = 75;
    *buf++ = 47;

    while (1)
        asm("hlt");
}
```

[vga]: http://wiki.osdev.org/Printing_To_Screen


### Ej: kern0-vga
{: #ej-vga}

Explicar el código anterior, en particular:

  - qué se imprime por pantalla al arrancar.
  - qué representan cada uno de los valores enteros (incluyendo `0xb8000`).
  - por qué se usa el modificador _volatile_ para el puntero al buffer.

Ahora, implementar una función más genérica para imprimir en el buffer VGA:

```c
static void
vga_write(const char *s, int8_t linea, uint8_t color) { ... }
```

donde se escribe la cadena en la línea indicada de la pantalla (si `linea` es menor que cero, se empieza a contar desde abajo).

### Ej: kern0-const
{: #ej-const}

Supongamos que se definiera `VGABUF` como una variable global _const_ (de tal manera que no pueda ser modificada y que por tanto apunte siempre al comienzo del buffer):

```c
static const volatile char *VGABUF = (volatile char *) 0xb8000;
```

1.  Explicar los errores o avisos de compilación que ocurren al recompilar el código original con la nueva definición:

    ```c
    void comienzo() {
        volatile char *buf = VGABUF;
        *buf++ = 79;
        *buf++ = 47;
        // ...
    }
    ```

    ¿Es adecuada la declaración de `VGABUF` propuesta? ¿Se puede agregar o quitar algo para subsanar el error?

2.  La declaración de `VGABUF` resultante del punto anterior ¿permite avanzar directamente la variable global? ¿Qué ocurre al añadir la siguiente línea a la función _comienzo_?

    ```c
    void comienzo(void) {
        VGABUF += 80;  // ?!?!

        volatile char *buf = VGABUF;
        // ...
    }
    ```

    ¿Se puede de alguna manera reintroducir el modificador _const_ para que no compile esta nueva versión, pero siga compilando el código original? Justificar y explicar el cambio.

3.  Finalmente, sobre la solución del punto anterior: ¿qué ocurre al ejecutar la siguiente versión?

    ```c
    void comienzo(void) {
        *(VGABUF + 120) += 88;

        volatile char *buf = VGABUF;
        // ...
    }
    ```

    ¿Se podría cambiar el _tipo_ de `VGABUF` para que no se permita el uso directo de `VGABUF`? (Pero siga compilando, _sin modificaciones_, el código original.) Justificar por qué el nuevo tipo produce error al usar `*VGABUF`, y por qué no se hace necesario cambiar el código original.


### Ej: kern0-endian
{: #ej-endian}

1.  Compilar el siguiente programa y justificar la salida que produce en la terminal:

    ```c
    #include <stdio.h>

    int main(void) {
        unsigned int i = 0x00646c72;
        printf("H%x Wo%s\n", 57616, (char *) &i);
    }
    ```

    A continuación, reescribir el código para una arquitectura [big-endian], de manera que imprima exactamente lo mismo.

2.  Cambiar el código de `comienzo()` para imprimir el mismo mensaje original con una sola asignación, “abusando” de un puntero a entero:

    ```c
    static ... *VGABUF = ...

    void comienzo(void) {
        volatile unsigned *p = VGABUF;
        *p = 0x...

        while (1)
            asm("hlt");
    }
    ```

    **Ayuda**: convertir los valores 47, 75 y 79 de base 10 a base 16, y componer directamente una constante entera en hexadecimal.

3.  Usar un puntero a `uint64_t` para imprimir en la segunda línea de la pantalla la palabra `HOLA`, en negro sobre amarillo.

    Realizar la inicialización de “p” de dos maneras distintas:

    ```c
    // Versión 1
    volatile uint64_t *p = VGABUF + 160;
    *p = 0x...

    // Versión 2
    volatile uint64_t *p = VGABUF;
    p += 160;
    *p = 0x...
    ```

    Justificar las diferencias de comportamiento entre ambas versiones.

[big-endian]: https://en.wikipedia.org/wiki/Endianness#Illustration


### Ej: kern0-objdump
{: #ej-objdump}

- Lectura sugerida

  - BRY2
    - cap. 7: §12-13
{:.biblio}

Incluir en la entrega la versión final del archivo _Makefile_ (incluyendo los cambios propuestos en esta tarea), y un archivo _kern0.c_ con:

  - la declaración correcta de la variable `VGABUF`
  - la función **estática** `vga_write()`
  - la función `comienzo()`, ahora con sendas invocaciones a `vga_write()` para imprimir, primero, el mensaje original en la línea 0; a continuación,  `HOLA` en la siguiente línea, en negro sobre amarillo.

Sobre este código:

1.  Obtener el código máquina del binario final usando _objdump:_

        $ make
        $ objdump -d kern0

    Típicamente, se guarda la salida en un archivo con extensión _.asm_ para tenerlo siempre a mano. Se puede usar la funcionalidad de [redirección] del intérprete de comandos:

        $ objdump -d kern0 >kern0.asm

    Añadir al archivo _Makefile_ una invocación de manera que se genere _kern0.asm_ automáticamente tras la fase de enlazado, y se borre como parte de la regla _clean_. Usar la variable `$@` según corresponda.

2.  ¿En qué cambia el código generado si se añade la opción `-fno-inline`?

3.  Buscar la documentación de la opción `-fno-pic` y describir su propósito. Con el commando `diff -u`, mostrar las diferencias en el código generado con ella y sin ella.

4.  Sustituir la opción `-d` de _objdump_ por `-S`, y explicar las diferencias en el resultado.

5.  De la salida de _objdump -S_ sobre el binario compilado con `-fno-inline` y `-fno-pic`, incluir la sección correspondiente a la función `vga_write()` y explicar cada instrucción de assembler en relación al código C original.

[redirección]: http://es.tldp.org/COMO-INSFLUG/COMOs/Bash-Prog-Intro-COMO/Bash-Prog-Intro-COMO-3.html

{% include anchors.html %}
{% include footnotes.html %}
