# Lab kern0

## kern0-boot:
##### ¿Emite algún aviso el proceso de compilado o enlazado? Si lo hubo, indicar cómo usar la opción `--entry` de `ld(1)` para subsanarlo.

El enlazado lanzó un error `ld: warning: cannot find entry symbol _start; defaulting to 0000000000100000`.
Puede solucionarse agregando la opción `-e 0x100000`, que explicita qué direccion definir como entry point.

##### ¿Cuánta CPU consume el proceso qemu-system-i386 mientras ejecuta este kernel? ¿Qué está haciendo?

El proceso consume el 100% del tiempo de procesamiento atrapado en la ejecución del bucle infinito definido en `kern0.c`

##### Una vez invocado hlt ¿cuándo se reanuda la ejecución?

La ejecución se reanuda cuando el CPU tiene que procesar algún _interrupt_.


## kern0-quit
Salida de `info registers`

```
(qemu) info registers
EAX=2badb002 EBX=00009500 ECX=00100000 EDX=00000511
ESI=00000000 EDI=00102000 EBP=00000000 ESP=00006f0c
EIP=00100000 EFL=00000006 [-----P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
CS =0008 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
FS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
GS =0010 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
GDT=     000caa68 00000027
IDT=     00000000 000003ff
CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
EFER=0000000000000000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000
```

## kern0-hlt
Comparación entre loop infinito e instrucción halt
| Version           | Usage    | Events/S |
| ---               | :---:    | :---:    |
| Loop infinito     | 978 ms/s | 229      |
| Instruccion `hlt` | 2 ms/S   | 60       |

## kern0-gdb

##### ¿Por qué hace falta el modificador `/x` al imprimir `%eax`, y no así `%esp`?

Es necesario dicho modificador porque `eax` es el registro acumulador, que puede representar cualquier tipo de dato, y por eso es necesario especificar en qué formato se desea verlo.
`esp`, en cambio, es el _stack pointer_, y por ende solo tiene sentido que guarde una dirección de memoria, las cuales siempre son visualizadas en formato heaxadecimal.

##### ¿Qué significado tiene el valor que contiene `%eax`, y cómo llegó hasta ahí?

El valor que contiene `%eax`, `0x2BADB002`, es un número mágico que el bootloader deja en el registro para indicarle al kernel que fue cargado por un bootloader compatible con multiboot.

##### Imprimir, con el comando `x/4xw`, los cuatro primeros valores enteros de dicha información, y explicar qué significan.

`0x0000024f 0x0000027f  0x0001fb80  0x8000ffff`
Ese es el contenido de las primeras cuatro palabras (conjunto de 4 bytes cada una) del área de memoria apuntada por `ebx`.
Se corresponden con los campos _flags_, _mem\_lower_, _mem\_upper_ y _boot\_device_ de la información que le provee el bootloader al kernel según el estandar multiboot.

##### Mostrar el campo _flags_ en formato binario

`x/1tw $ebx`

##### Mostrar la cantidad de memoria 'baja' en formato decimal:

`x/1dw $ebx + 4`

##### Mostar la "cadena de arranque" recibida por el kernel:

`x/s *($ebx + 16)` Dicha cadena se encuentra disponible si está activado el bit 2 de _flags_

##### Si está presente (¿cómo saberlo?), el nombre del gestor de arranque:

Si está presente el nombre del gestor de arranque, el bit 9 de _flags_ estará en `1`.
`x/s *($ebx + 64)`

##### Mostrar la cantidad de memoria “alta”, en MiB

```
x/1dw $ebx + 8
p $__ /1024
```
### Sesión de gdb

```
Reading symbols from kern0...done.
Remote debugging using 127.0.0.1:7508
0x0000fff0 in ?? ()
(gdb) b comienzo
Breakpoint 1 at 0x100000: file kern0.c, line 3.
(gdb) c
Continuing.

Breakpoint 1, comienzo () at kern0.c:3
3               asm("hlt");
(gdb) p/x $eax
$1 = 0x2badb002
(gdb) x/1tw $ebx
0x9500: 00000000000000000000001001001111
(gdb) x/1dw $ebx + 4
0x9504: 639
(gdb) x/s *($ebx + 16)
0x101000:       "kern0 "
(gdb) x/1tw $ebx #Miro el bit 9 de flag
0x9500: 00000000000000000000001001001111
(gdb) x/s *($ebx + 64)
0x101007:       "qemu"
(gdb) x/1dw $ebx + 8
0x9508: 129920
(gdb) p $__ /1024
$4 = 126
(gdb)
```
## make-flags

##### Recompilar el kernel usando make y, si ocurre algún error en la línea asm("hlt"), explicar por qué ocurre y por qué la opción -fasm lo arregla.

Ocurre un error `kern0.c:3: undefined reference to 'asm'`, ya que `-std=c99` implica `-fno-asm`, lo que desconoce la keyword `asm` haciendo que intentar agregar _inline assembly_ sea interpretado como una llamada a una función `asm()` que no fue definida. Para arreglarlo no me funcionó la opción `-fasm`, por lo que pasé a usar la keyword `__asm__`

##### ¿Qué compilador usa make por omisión? ¿Es o no gcc? Explicar cómo se podría forzar el uso de clang:
    * por una sola vez, desde la línea de comandos.
    * para todas las compilaciones del proyecto.

GNU Make usa gcc por omisión. 
Para cambiar esto por una sola ejecución, basta con llamar a make especificándole la variable `CC`, mediante `make CC=clang`.
Para cambiarlo para todas las veces que se use ese makefile, habría que definir dentro del mismo la variable `CC:=clang`

##### ¿Se pueden usar booleanos en modo “free standing”?

Sí, es posible incluyendo `<stdbool.h>`

##### ¿Dónde se definen los tipos uint8_t, int32_t, etc.?

Son definidos en `<stdint.h>`

_c99int.h_

```C
#ifndef C_99_INT_H
#define C_99_INT_H

typedef char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long int64_t;
typedef long long int64_t;

typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed long int64_t;
typedef signed long long int64_t;

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long uint64_t;
typedef unsigned long long uint64_t;

#endif

```
Para saber si `char` por defecto es `signed` o `unsigned`, ya que según el estándar de C es dependiente de la implementación, usé el siguiente programa: 

_foo.c_
```C
#include<stdio.h>
#include<limits.h>

int main(){
    printf("%d\n",CHAR_MIN);
    return 0;
}

```

## make-pattern

##### ¿Cómo funciona la regla que compila boot.S a boot.o?

La regla que compila _boot.S_ a _boot.O_ es `%.o: %.S`. Lo que hace es tomar cada uno de los archivos que terminan en _.S_, y mediante las instrucciones definidas en la misma, genera el archivo _.o_ con el mismo nombre.

##### ¿Qué son las variables `$@`, `$^` y `$<`?

* `$@` contiene el nombre del archivo que es _target_ de la regla
* `$^` contiene los nombres de todos los requisitos de la regla, separados por espacios.
* `$<` contiene el nombre del primer requisito.

##### La regla _kern0_ usa `$^` y la regla con _%.S_ usa `$<`. ¿Qué ocurriría si se intercambiaran estas dos variables entre ambas reglas?

Si se intercambian las variables, la regla _kern0_ dejaría de funcionar ya que le pasaría a `ld` solamente _boot.o_ como archivo a linkear.
Sin embargo, la regla con _%.S_ seguiría funcionando igual, ya que para cada invocación de la misma tiene un solo requisito.

## make-implicit

##### ¿Mediante qué regla se genera el archivo kernel.o? 

El archivo _kernel.o_ se genera con una regla implícita (viene por defecto con make) que genera archivos _.o_ a partir de archivos _.c_.

##### Eliminar la regla %.o: %.S y ejecutar make clean kern0:

##### ¿Se llega a generar el archivo _boot.o_?

Sí, el archivo _boot.o_ se genera mediante una regla implícita.

##### ¿Ocurre algún otro error? (Si no ocurre, mostrar la salida del comando uname -m).

Sí, ocurre un error porque el _boot.o_ generado no es valido para crear un ejecutable de la arquitectura pedida.

##### ¿Se puede subsanar el error sin re-introducir la regla eliminada?

Se puede subsanar definiendo `ASFLAGS := -m32`, para que la regla implícita genere el _boot.o_ de 32 bits.

## make-wildcard

makefile terminado al final de la entrega.

## kern0-vga

>Explicar el código anterior, en particular:
1. qué se imprime por pantalla al arrancar.
1. qué representan cada uno de los valores enteros (incluyendo `0xb8000`).
1. por qué se usa el modificador _volatile_ para el puntero al buffer.

1. Se imprime `OK` en fondo verde con letras blancas
1. El `0xb8000` es la dirección de memoria de la salida VGA en color, los `79` y `75` son los códigos ASCII de los caracteres `O` y `K`, respectivamente, mientras que `47` se corresponde con el patron de bits necesario para especificar que se escriba en letra blanca sobre fondo verde.
1. El modificador _volatile_ se usa para indicar que la memoria a la que hace referencia la variable puede ser modificada fuera del contexto en el que se está ejecutando el código actual, por ejemplo, por otro thread o una rutina de _interrupt_. Evita que el compilador haga optimizaciones sobre la lectura de esa variable, fetcheándola de memoria cada vez que se busca su valor, en vez de, por ejemplo, aprovechar si por operaciones anteriores quedó en algún registro.

>Ahora, implementar una función más genérica para imprimir en el buffer VGA:

```C
static void vga_write(const char *s, int8_t linea, uint8_t color) { ... }
```
donde se escribe la cadena en la línea indicada de la pantalla (si linea es menor que cero, se empieza a contar desde abajo.

Implementación:

```C
static void vga_write(const char *string, int8_t linea, uint8_t color){
    if(linea<0)
        linea = CANT_LINEAS-linea;

    volatile char *buf = VGABUF+ 2*linea*LARGO_LINEA;//multiplico por dos para contemplar el byte de color
    bool reached_EOS   = false;
    
    for (uint8_t i = 0; i<LARGO_LINEA;i++){
        if(!string[i])
            reached_EOS=true;

        uint8_t color_index     = 2*i+1;
        uint8_t character_index = 2*i;

        buf[color_index]     = (char) color;
        buf[character_index] = reached_EOS ? 0 : string[i];
    }
```

## kern0-const

##### Explicar los errores o avisos de compilación que ocurren al recompilar el código original con la nueva definición:

El warning que da GCC es `initializing 'volatile char *' with an expression of type 'const volatile char *' discards qualifiers`.

##### ¿Es adecuada la declaración de VGABUF propuesta? ¿Se puede agregar o quitar algo para subsanar el error?

La declaración es incorrecta, ya que prohibe modificar la memoria a la que apunta el puntero pero no el valor del mismo.
Lo que se busca es justamente lo contrario, poder modificar la memoria a la que apunta pero no reubicar el puntero.
Para eso, la declaración debería ser: `static volatile char* const VGABUF = (volatile char*) 0xb8000;`
nota: imagino que esto estaba con la idea de introducir casteos explícitos para que el código funcione igual. Probé eso como primera opción, pero me pareció muy fisura como para dejarlo en la entrega.

##### La declaración de `VGABUF` resultante del punto anterior ¿permite avanzar directamente la variable global? ¿Qué ocurre al añadir la siguiente línea a la función comienzo?

Sí, la declaración anterior permite mover el puntero. Al añadir dicha línea, no se genera ningún warning extra.

##### ¿Se puede de alguna manera reintroducir el modificador const para que no compile esta nueva versión, pero siga compilando el código original? Justificar y explicar el cambio.

Sí, ya lo expliqué en un item anterior.

##### Finalmente, sobre la solución del punto anterior: ¿qué ocurre al ejecutar la siguiente versión?

El código propuesto no da errores al compilar y escribe una `x` a mitad de la primer línea de consola.

##### ¿Se podría cambiar el tipo de VGABUF para que no se permita el uso directo de VGABUF? (Pero siga compilando, sin modificaciones, el código original) Justificar por qué el nuevo tipo produce error al usar *VGABUF, y por qué no se hace necesario cambiar el código original.

No encontré cómo. Probé hacer constante también la dirección del puntero, pero esto genera el error que se describen en el primer item de este ejercicio. Investigué el modificador `restricted`, pero parece lograr exactamente lo opuesto.

## kern0-endian

##### Compilar el siguiente programa y justificar la salida que produce en la terminal:

`printf` muestra, secuencialmente:

* la letra 'H'.

* la representación hexadecimal(con letras minúsculas) del numero `57616`, que es `e110`.
Esto no muestra el contenido de la memoria, sino el valor que representa.

* el contenido de la memoria de `i`, interpretado como un string (debido a %s).
Como la arquitectura en la que ejecuto el programa es little-endian, en memoria es `72 6c 64 00`. 
Al leer esto como string, se corresponde con la cadena de caracteres ASCII `'r'`,  `'l'`,  `'d'`,  `'\0'`. 

##### A continuación, reescribir el código para una arquitectura big-endian, de manera que imprima exactamente lo mismo.

_big-endian.c_

```C
#include <stdio.h>

int main(void) {
    unsigned int i = 0x726c6400;
    printf("H%x Wo%s\n", 57616, (char *) &i);
}
```
##### Cambiar el código de comienzo() para imprimir el mismo mensaje original con una sola asignación, “abusando” de un puntero a entero:

```C
void comienzo(void){
    volatile uint32_t *buf = (volatile uint32_t *)VGABUF;
    *buf = 0x2f4b2f4f;

    while(1) 
        __asm__("hlt");
}
```
##### Usar un puntero a uint64_t para imprimir en la segunda línea de la pantalla la palabra HOLA, en negro sobre amarillo.
Realizar la inicialización de “p” de dos maneras distintas:
    ```C
    // Versión 1
    uint64_t *p = VGABUF + 160;
    *p = 0x...

    // Versión 2
    uint64_t *p = VGABUF;
    p += 160;
    *p = 0x...
    ```
Justificar las diferencias de comportamiento entre ambas versiones.

La diferencia en el comportamiento de ambas versiones radica en la aritmética de punteros, en la versión 1 la suma de punteros se hace entre en términos de `char`s, que ocupan un byte cada uno, avanzando el puntero 160 bytes. En la versión 2, la suma se hace entre `uint64_t*`, y como cada `uint64_t` ocupa 8bytes, el puntero se avanza 1280 bytes, por lo que se escribe varias líneas más abajo.


# kern0.c

```C
#define LARGO_LINEA 80
#define CANT_LINEAS 25
#define GREEN_ON_GREEN 0x2a
#define DOS_BSOD_COLORS 0x1f
#define BLACK_ON_YELLOW 0xe0

#include<stdbool.h>
#include<stdint.h>

static volatile char* const VGABUF = (volatile char*) 0xb8000;

inline static void vga_write(const char *string, int8_t linea, uint8_t color);

void comienzo(void){
    vga_write("OK", 1, GREEN_ON_GREEN);
    vga_write("HOLA",2, BLACK_ON_YELLOW);

    while(1) 
        __asm__("hlt");

}

inline static void vga_write(const char *string, int8_t linea, uint8_t color){
    if(linea<0)
        linea = CANT_LINEAS-linea;

    volatile char *buf = VGABUF+ 2*linea*LARGO_LINEA;//multiplico por dos para contemplar el byte de color
    bool reached_EOS   = false;
    
    for (uint8_t i = 0; i<LARGO_LINEA;i++){
        if(!string[i])
            reached_EOS=true;

        uint8_t color_index     = 2*i+1;
        uint8_t character_index = 2*i;

        buf[color_index]     = (char) color;
        buf[character_index] = reached_EOS ? 0 : string[i];
    }

}
```

# Makefile 

```makefile
CFLAGS  := -m32 -O1 -ffreestanding -g -Wconversion -std=c99 -Wall -Wextra -Wpedantic 
CC      := clang
ASFLAGS := -m32
SOURCES := $(wildcard *.c)
OBJECTS := $(patsubst %.c,%.o,$(wildcard *.c))
QEMU    := qemu-system-i386 -serial mon:stdio
KERN    := kern0
BOOT    := -kernel $(KERN)

$(KERN): boot.o $(OBJECTS)
	ld -m elf_i386 -Ttext 0x100000 -e 0x100000 $^ -o $@
	# Verificar imagen Multiboot v1.
	grub-file --is-x86-multiboot $@
	objdump -d $@ >$@.asm

clean:
	rm -f kern0 *.o core $(KERN).asm

qemu: $(KERN)
	$(QEMU) $(BOOT)

qemu-gdb: $(KERN)
	$(QEMU) -kernel kern0 -S -gdb tcp:127.0.0.1:7508 $(BOOT)

gdb:
	gdb -q -s kern0 -n -ex 'target remote 127.0.0.1:7508'


.PHONY: clean qemu gdb qemu-gdb
```
