# TP0: Introducción a JOS[^src]

Para esta TP, es suficiente con usar la rama _master_ del [repositorio]:

     $ git clone https://github.com/fisop/jos

El resultado de la [auto-corrección][grade] tiene este aspecto:

```
$ make grade
./grade-lab1
running JOS: (1.0s)
  backtrace count: OK
  backtrace arguments: OK
  backtrace symbols: OK
  backtrace lines: OK
Score: 4/4
```

**IMPORTANTE**: se debe leer antes la [información general sobre TPs con JOS](tps.md) y el [software a instalar](kit.md#tools).

**Modo de entrega**: para el TP0 se debe traer impresa en papel la función `mon_backtrace()` más el archivo de respuestas _TP0.md_.

[repositorio]: tps.md#jos-repo
[grade]: tps.md#grading

[^src]: Material original en inglés: [Lab 1, part 3: The Kernel](https://pdos.csail.mit.edu/6.828/2016/labs/lab1/#Part-3--The-Kernel). El ejercicio 7 se realizó en clase, pero se recomienda repetirlo de manera individual.


## Resumen
{:.no_toc}

Se pide la implementación de una única función `mon_backtrace()`, en el archivo _kern/monitor.c_.[^stat]

[^stat]: La salida de `git diff --stat` que sigue indica, a modo de guía, la cantidad de código en la solución de los docentes al TP. En este caso son solamente 14 líneas de código, todas en el archivo _monitor.c_.

```
$ git diff --stat tp0..tp0_sol
 TP0.md         | 10 +++++++++-
 kern/monitor.c | 14 +++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)
```


## Índice
{:.no_toc}

* TOC
{:toc}


## Convención de llamadas + backtrace

Dada la convención de llamadas en x86, es posible saber la secuencia de llamadas anidadas que condujo al estado actual de ejecución. En particular, mediante la instrucción estándar:

    push %ebp

cada función almacena en el stack una referencia al marco de ejecución de la función inmediatamente anterior. Se puede obtener el punto de retorno y los parámetros de cada llamada “saltando” hacia atrás cada _frame pointer_. (Algo parecido hace el comando `bt` de GDB.)

Se proporcionan dos funciones auxiliares:

  - `read_ebp()`: devuelve el valor actual del registro `%ebp`.

  - `debuginfo_eip()`: usa la información de debug ELF para determinar, dada la dirección de una instrucción, en qué función reside. Proporciona información sobre dicha función en un `struct Eipdebuginfo`:

    ```
    struct Eipdebuginfo {
        const char *eip_file;   // Source code filename for EIP
        int eip_line;           // Source code linenumber for EIP

        const char *eip_fn_name;  // Name of function containing EIP
                                  //     Note: not null terminated!
        int eip_fn_namelen;       // Length of function name
        uintptr_t eip_fn_addr;    // Address of start of function
        int eip_fn_narg;          // Number of function arguments
    };
    ```

La función `mon_backtrace()` visita hacia atrás los sucesivos marcos de ejecución, imprimiendo información sobre cada uno de ellos.

### Tarea: backtrace_eip
{: #backtrace_eip}

Implementar una primera versión de `mon_backtrace()` que, para cada marco de ejecución, imprima en hexadecimal con `cprintf()` el frame pointer, instruction pointer y los cinco primeros argumentos de la función, en este formato:[^args]

      ebp f0109e58  eip f0100a62  args 00000001 f0109e80 f0109e98 f0100ed2 00000031
      ebp f0109ed8  eip f01000d6  args 00000000 00000000 f0100058 f0109f28 00000061
    ␣␣   ␣        ␣␣   ␣        ␣␣

[^args]: Quizás la función tome menos de cinco argumentos. En ese caso, se imprimirá igualmente las posiciones del stack donde _estarían_ esos argumentos.

Para cada función, _ebp_ se refiere al valor del registro `%ebp` (esto es, el valor del _stack pointer_ al entrar a la función), y _eip_ a la instrucción de retorno.

La primera línea se referirá siempre a la función actualmente en ejecución, esto es, siempre será `mon_backtrace()`. La segunda línea refleja quién llamó a `mon_backtrace()`, y así sucesivamente.

El auto-corrector comprueba el comportamiento de esta función llamándola al final de una serie de llamadas recursivas a `test_backtrace()`:

```
$ make grade
running JOS: (0.8s)
  backtrace count: OK
  backtrace arguments: OK
  backtrace symbols: FAIL
  backtrace lines: FAIL
```

**Ayuda**: para saber cuándo se llega al _primer_ marco de ejecución, averiguar si JOS inicializa `%ebp` durante el arranque a algún valor pre-establecido. (Usar, por ejemplo, el comando `git grep -F %ebp`.)


### Tarea: backtrace_cmd
{: #backtrace_cmd}

Añadir en el archivo _monitor.c_ un comando _backtrace_ que llame a la función `mon_backtrace()`. Así, en el monitor interactivo de JOS será posible escribir:

```
$ make qemu-nox
...
Welcome to the JOS kernel monitor!
Type 'help' for a list of commands.

K> help
help - Display this list of commands
kerninfo - Display information about the kernel
backtrace - Display the current backtrace

K> backtrace
  ebp f010ff48  eip f0100a03  args  00000001 f010ff70 00000000 0000000a 00000009
  ebp f010ffc8  eip f0100a48  args  00010094 00010094 f010fff8 f01000e1 00000000
  ebp f010ffd8  eip f01000e1  args  00000000 00001aac 00000644 00000000 00000000
  ebp f010fff8  eip f010003e  args  00111021 00000000 00000000 00000000 00000000
```

### Tarea: backtrace_func_names
{: #backtrace_func_names}

La función auxiliar `debuginfo_eip()` también proporciona el nombre y ubicación de la función a que corresponde `%eip`.

Se pide ampliar la salida de `mon_backtrace()` para que, usando campos adicionales de `Eipdebuginfo`, muestre el archivo y número de línea en que se halla la instrucción, así como el offset de _eip_ respecto a la dirección de comienzo de la función:

```
  ebp f010ff48  eip f0100a01  args  00000001 f010ff70 00000000 0000000a 00000009
         kern/monitor.c:116: runcmd+261
  ...
```

Escribir en el archivo [TP0.md](tps.md#prosa) la salida del comando `backtrace` al arrancar JOS.

**Ayuda**: la familia de funciones _printf_ permite forzar un ancho para el valor a imprimir; por ejemplo:

    printf("%04d", n)

imprime el entero _n_ con un ancho de al menos 4; y:

    printf("%.4f", r)

imprime el float _r_ con cuatro dígitos de precisión.

El ancho y/o la precisión pueden aplicarse vía variables mediante el modificador `'*'`, por ejemplo: `printf("%0*d", ancho, n)` y `printf("%.*4f", precision, r)`.

Esto último es útil para cadenas no terminadas en `'\0'` como  `eip_fn_name`. Para más detalles, consultar la página de manual `printf(3)`.

{% include anchors.html  %}
{% include footnotes.html %}
