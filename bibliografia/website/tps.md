# Trabajos prácticos con JOS

En 2017, los TPs se implementan sobre **JOS**, el exokernel educativo con licencia libre del grupo de [Sistemas Operativos Distribuidos][pdos] del MIT.

En cada consigna, se referenciará el contenido original equivalente (en inglés) en la página de su materia [6.828: Operating Systems Engineering][6828]. Se recomienda su uso como complemento a la consigna en castellano.

> The programming assignments […] are not easy. **It is far from unusual for a single one-line bug to take two days to track down.**
>
> — Carnegie Mellon University, [Operating System Design and Implementation][410].

[pdos]: https://pdos.csail.mit.edu/
[6828]: https://pdos.csail.mit.edu/6.828/2016/
[410]: https://www.cs.cmu.edu/~410/expectations.html


## Índice
{:.no_toc}

* TOC
{:toc}


## Código fuente
{: #jos-repo}

La copia de JOS para la materia se encuentra en el repositorio [fisop/jos] de GitHub:

    $ git clone https://github.com/fisop/jos

En la rama _master_ se encuentra el esqueleto para el [TP0](tp0.md). Cada TP posterior tiene una rama con el código adicional que se proporciona como base para la entrega. Lo más fácil, para progresar al siguiente TP, es añadir un commit con los cambios del alumno, e integrar en el repositorio la nueva base:

    $ git add kern/pmap.c
    $ git commit -m "Solución TP1"
    $ git fetch
    $ git merge origin/tp2
    $ git tag base_tp2

Alternativamente, se puede clonar directamente la rama de un TP en un directorio nuevo:

    $ git clone --branch tp2 https://github.com/fisop/jos sisop_tp2
    $ cd sisop_tp2

    # Copiar cambios de "pmap.c" del TP1 a mano...

    $ git add kern/pmap.c
    $ git commit -m "Solución TP1"
    $ git tag base_tp2

[fisop/jos]: https://github.com/fisop/jos/


## Compilación y depurado

La compilación se realiza mediante `make`. En el directorio `obj/kern` se puede encontrar:

  - _kernel_ — el binario ELF con el kernel
  - _kernel.asm_ — assembler asociado al binario

Para correr JOS, se puede usar `make qemu` o `make qemu-nox`.

### GDB

El _Makefile_ de JOS incluye dos reglas para correr QEMU junto con GDB. En dos terminales distintas:

```
$ make qemu-gdb
***
*** Now run 'make gdb'.
***
qemu-system-i386 ...
```

y:

```
$ make gdb
gdb -q -ex 'target remote ...' -n -x .gdbinit
Reading symbols from obj/kern/kernel...done.
Remote debugging using 127.0.0.1:...
0x0000fff0 in ?? ()
(gdb)
```

Para más información, consultar [esta guía][labguide].

[labguide]: https://pdos.csail.mit.edu/6.828/2016/labguide.html


## Modo de entrega

Los trabajos prácticos realizados sobre JOS se entregan:

  1. en papel, imprimiendo la salida de `git diff` y `make grade`
  2. (opcional) vía Git, en un repositorio proporcionado por la cátedra

El código entregado _debería_ pasar las pruebas de auto-corrección. **En caso de no pasar las pruebas, se debe indicar explícitamente en el material entregado**.

_Una entrega que no pase las pruebas **y no lo indique** no cuenta como entrega._{:.deadline} (Por el contrario, una entrega que no pasa todas las pruebas, pero así lo indica, es perfectamente aceptable.)

### git diff en papel

En lugar de archivos completos, para los trabajos prácticos con JOS se imprimen solamente los cambios realizados en el código; esto es, estrictamente la solución al TP.

Se debe imprimir el resultado de `git diff` entre la base del TP y la solución. Antes, se debe correr `make format` para que el código quede conforme a la guía de estilo.

También se debe incluir la salida de `make grade`, indicando si el código pasa las pruebas de auto-corrección, o no.

La ‘base’ del TP es el “merge” realizado entre la solución al TP anterior y la base del actual. Por ejemplo, usando la etiqueta _base_tp2_ mostrada anteriormente:

    $ make format
    $ git diff base_tp2 >imprimir_tp2.txt
    $ make grade


### Entrega opcional vía Git

Para obtener un repositorio privado, se debe crear una cuenta en el [sitio Gerrit de la materia][gerrit] y, para trabajos grupales, completar el siguiente [formulario][ghform].

[gerrit]: https://git.turing.pink
[ghform]: https://goo.gl/forms/4bWqlu56FeTnzzW93


### Respuestas en prosa

Algunos ejercicios de los TPs consisten en responder en prosa ciertas preguntas breves. Estas se deben responder en el archivo _TP1.md_, _TP2.md_, … del repositorio. Se pueden imprimir como parte del diff, o como archivos aparte (por ejemplo, convertidos a PDF con [pandoc]).

[pandoc]: http://pandoc.org/

<!-- TODO: dar ejemplo de gdb session -->


## Auto-corrección
{: #grading}

La mayoría de los TPs incluyen un auto-corrector que informa al alumno sobre su progreso:

```
$ make grade
./grade-lab2
running JOS: (1.2s)
  Physical page allocator: OK
  Page management: OK
  Kernel page directory: OK
  Page management 2: OK
Score: 4/4
```

{% include footnotes.html %}
{::options toc_levels="2" /}
