# Ejercicios sobre el estándar POSIX

Cada ejercicio tiene un identificador con el cual se puede referenciar en la lista de correo. Los ejercicios marcados con ★ son de mayor dificultad.


## Índice
{:.no_toc}
* TOC
{:toc}


## Files and file descriptors

### _safe-cp_

Implementar una versión simplificada del comando `cp(1)` de Unix. El comportamiento debe ser como sigue:

```
$ echo hola >f1
$ echo adios >f2

$ ./cp f1 g
$ echo $?; cat g
0
hola

$ ./cp f2 g >/dev/null
ERROR: ya existe ‘g’
$ echo $?; cat g
1
hola

$ ./cp -f f2 g
$ echo $?; cat g
0
adios

$ mkdir d
$ ./cp f2 d
ERROR: ‘d’ es un directorio
```

El programa no debe exhibir _race conditions_, en particular:

1.  Al copiar el archivo destino, no debe quedar resquicio posible entre la comprobación de que no existe, y la apertura para escritura. La solución será crear el archivo para escritura _de manera exclusiva;_ ver al respecto el uso del flag `O_EXCL` en **\[KERR §5.1\]**.

2.  Al comprobar que el archivo origen no sea un directorio, no debe quedar resquicio en que se pudiera borrar el archivo y recrear como directorio, pues fallaría la lectura. La solución será realizar la comprobación con _fstat_ y `S_ISDIR` después de haber hecho _open_; en lugar de usar _stat_ primero, y luego _open_.

Funciones recomendadas: `open`, `fstat`, `read`, `write`, `close`.


### _simple-ls_



<!--
## Procesos

### _fork-exec_

Escribir una función que reciba la ruta de un binario como parámetro y lo ejecute en un proceso separado, esperando hasta su finalización. La función debe devolver:

  - el estado de salida del proceso si este terminó con normalidad (por ejemplo 0, 1 o 2).

  - el identificador de señal en negativo si el programa fue abortado por una señal (por ejemplo -9 si el programa fue abortado con SIGKILL, o -11 si murió por _segmentation fault_).

  - el valor 127 si no se pudo lanzar el proceso (esto es, fallaron _fork_ o _exec_).

Prototipo:

    int fork_exec(const char *ruta);

Pre-condiciones:

   - el binario existe y se tienen permisos de ejecución.

Funciones recomendadas: `fork()`, `execl()`, `waitpid()`, `_exit()`.


### _exec-redir_

Escribir una función que lance un ejecutable en un proceso separado, con la posibilidad de configurar redirección de los flujos estándar.

La función recibe la ruta del binario, más un _struct redir_ que indica las redirecciones a realizar.

Prototipo:

    struct redir {
        const char *ruta_in;   // Si es NULL, no se redirige fd 0.
        const char *ruta_out;  // Ídem, fd 1.
        bool append;           // No truncar archivo ‘ruta_out’, si existe.
    };

    int exec_redir(const char *ruta_binario, const struct redir *r);

La función debe devolver el PID del proceso creado, sin esperar a su finalización, o -1 en caso de ocurrir algún error.

El error podría ocurrir en la secuencia _fork/exec_ o en el manejo de archivos (rutas que no existen, no se tienen permisos para escribir, etc.). En todos los casos, la función no debe dejar ningún archivo abierto sin cerrar.

Funciones recomendadas: `open()`, `fork()`, `execl()`, `dup2()`, `_exit()`. Funciones **no** permitidas: `fcntl()` y, en el proceso hijo, `close()`.


### _spawn-check_ ★

Escribir una función que reciba la ruta de un binario como parámetro y lo lance en un proceso separado (sin esperar a su finalización). La función debe devolver:

  - el PID del proceso, por ejemplo 23879, si se pudo lanzar el ejecutable.

  - el código de error en negativo, por ejemplo -ENOMEM, si no se pudo llevar a cabo la ejecución. El error podría venir de la llamada a _fork_, o de la llamada a _exec_.

    Como la llamada a _exec_ ocurre después de _fork_, el proceso hijo deberá tener una manera de comunicar al padre el resultado de _exec_. Sugerencia: una tubería o _pipe_.

Prototipo:

    int spawn_check(const char *ruta);

Funciones permitidas: `fork()`, `execv()`, `pipe()`, `fcntl()`. Funciones **no** permitidas: `pipe2()`.

Recomendación: escribir la solución usando primero `pipe2()`, después convertirla a `pipe()` + `fcntl()` (con el comando `F_SETFD`).


### _daemon-start_

Escribir una función que permita lanzar un ejecutable como demonio. Un demonio es un proceso que se ejecuta de manera no interactiva y sin tener una terminal asociada.

Luego de iniciar el demonio, se deben cumplir las siguientes condiciones:

  - El identificador del proceso (PID) se encuentra escrito como texto en un archivo pasado como parámetro. Este archivo no debe quedar abierto en ningún proceso.

  - stdout y stderr se encuentran conectados al archivo de log.

  - El proceso no tiene ninguna terminal asociada.

  - El proceso continúa en ejecución luego de finalizado el proceso padre y el shell utilizado para lanzar al padre.

  - El proceso tiene como padre a init (PID 1).

  - En caso de error en la apertura del archivo de pid, el demonio no debe ejecutarse.

  - En caso de error en la ejecución del demonio, el archivo no debe quedar escrito.

Prototipo:

    int daemon_start(const char *ruta, const char *log, const char *pid);

Funciones recomendadas: `open()`, `fork()`, `execl()`, `dup2()`, `write()`, `setsid()`.

Recomendación páginas de manual de los comandos _kill_ y _ps_.


### _daemon-stop_

Escribir una función que reciba como parámetro la ruta a un archivo de PID y detenga el proceso asociado.

Para terminar el proceso se debe intentar utilizar SIGTERM. Si al cabo de 30 segundos el proceso continúa en ejecución, se debe enviar SIGKILL. Luego de detener exitosamente el proceso, se debe eliminar el archivo PID.

La función debe devolver 0 en caso que haya podido terminar el proceso o  -1 ante cualquier error.

Prototipo:

    int daemon_stop(const char *ruta_pid);

Funciones recomendadas: `open()`, `read()`,`waitpid()`, `unlink()`, `kill()`.

-->

{% include anchors.html %}
