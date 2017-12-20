# Kit de supervivencia para trabajos prácticos

Listamos aquí un material de referencia sobre un conjunto de conocimientos previos necesarios para la parte práctica de la materia.

Sin prejuicio a  talleres puntuales que se planteen sobre la cursada, se recomienda el estudio individual de aquellas herramientas con las que los estudiantes estén menos familiarizados.

## Software a instalar
{: #tools}

<!-- Work in progress -->

El software indispensable para realizar los trabajos prácticos es:

  - Compiladores GCC (con soporte para 32-bits) y [Clang]
  - glibc (biblioteca estándar de C) y archivos _“include”_ de Linux
  - QEMU (virtualizador de hardware) y seabios (simulador de BIOS)
  - gdb, make, git

En Debian y distribuciones derivadas, se puede instalar mediante:

```
apt-get install make git gdb seabios clang libbsd-dev \
        gcc-multilib libc6-dev linux-libc-dev qemu-system-x86
```

La versión de QEMU debe ser 2.5 o superior, y la versión de seabios 1.10 o superior.

[Clang]: https://en.wikipedia.org/wiki/Clang


### Versión modificada de QEMU

En la arquitectura x86, el sistema se reinicia automáticamente cuando ocurre una “triple falla” _(triple fault)_. QEMU, por omisión, obecede esta especificación.

Sin embargo, durante el desarrollo de sistemas operativos en modo protegido de x86, las triple fallas ocurren casi exclusivamente por un bug en el kernel. Por esto, es más deseable que QEMU detenga la ejecución en lugar de reiniciarse constantemente.

Como parte de la materia, **se ofrece una versión modificada de QEMU que impide los ciclos de reinicio infinito**. Se puede instalar desde el repositorio personal: [launchpad.net/~dato/ppa/qemu][ppa].

[ppa]: https://launchpad.net/~dato/+archive/ubuntu/qemu

El repositorio es válido para versiones de Ubuntu a partir de 16.04. Además, la versión para Ubuntu 17.04 “zesty” también sirve para Debian 9 “stretch”.


## Manejo básico de entornos Unix (WIP)

  - Google-fu
    - https://en.wiktionary.org/wiki/Google-fu
  - Tener una distribución de Linux instalada en hardware real (NO máquina virtual). Esto es necesario para poder correr máquinas virtuales.
  - Utilizar el administrador de paquetes de la distribución instalada (apt, yum, etc) para instalar software.
  - Shell scripting, en bash o shell de su preferencia.
  - Manejo de la línea de comandos:
    - man, vi, cd, ls, mkdir, chmod, chown, grep, sudo, head, tail, ps, cat, less, kill, strace
    - [Guía básica de la materia](https://docs.google.com/spreadsheets/d/1eKCDfeSbdcydg0VPmW0oaIONgv1DPnSSILOk2vQSv4Y/pubhtml)
  - Lenguaje C:
    - Manejo de punteros y memoria dinámica.
    - Uso de debugger gdb.
    - Compilación con gcc: https://gcc.gnu.org
  - Lenguaje Assembler intel X86
    - nasm (Netwide Assembler): http://www.nasm.us/
    - Una referencia rápida: https://www.cs.uaf.edu/2005/fall/cs301/support/x86/index.html
    - Una referencia un poco mas completa: http://www.jegerlehner.ch/intel/IntelCodeTable.pdf
  - Make: uso de la herramienta y archivos Makefile
    - https://www.gnu.org/software/make/manual/html_node/Quick-Reference.html
