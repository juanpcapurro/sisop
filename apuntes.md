# Introduccion: definiciones

* Sistema operativo: capa de software de más bajo nivel que interactúa directamente con el hardware y:
    * Provee abstracciones para que los procesos usen el hardware, y un entorno consistente para que vivan (pegamento).
    * Le hace creer a cada proceso que tiene todos los recursos de la computadora (ilusionista).
    * Aloja recursos para cada proceso y evita que cada uno avance sobre los recursos de los otros (referee).
    * Maneja fallas de los procesos y evita que crashee todo el sistema.
Por fuera del kernel, está todo el software que es necesario para lograr hacer último uso del hardware, pero que no son puramente aplicaciones de usuario.
Ejemplo: shell, librerías de sistema, lo que sea que es systemd.

* Kernel: Programa que forma parte del OS, corre con un *privilegio* superior a los demás y toma las responsabilidades descriptas en el punto anterior.

# Kernel y procesos

* Programa: Conjunto de instrucciones de máquina y datos con los que trabajan esas instrucciones

* Proceso: Instancia de un programa en ejecución, al tomar acciones es más como que _tiene vida_, mientras que un programa es simplemente un conjunto de datos en un medio de almacenamiento.

### Virtualización de proceso: 
abstracción de un programa en ejecución, en la cual se ve a si mísmo como el único programa en memoria que puede hacer uso de todos los recursos de hardware.
Para lograr la virtualización de proceso se debe tener soporte de hardware para:
    * Interrupciones por timer: Para que el kernel gane control y haga _scheduling_.
    * Protección de memoria: Debe ser implementada por hardware para ser rápida.
    * Instrucciones privilegiadas: Solo pueden ser ejecutadas por el kernel.
    Si un proceso de usuario intenta ejecutarlas, genera una excepción a nivel de hardware, permitiéndole al kernel ganar control.

#### Paso de user mode a kernel mode:
    * Interrupción (asincrónica)
    * Excepción (sincrónica)
    * System call
#### Paso de kernel mode a user mode:
    * Nuevo proceso
    * Volver de una interrupción, excepción o syscall
    * Cambio entre procesos (caso particular de la anterior, con excepción de timer)

### Requisitos en el kernel

* Proveer un address space
* Guardar el estado de sus registros cuando se lo desaloja
* Guardar su metadata

#### API de procesos
* *Creacion*
* *Destrucción*
* *Espera*: es usual que un proceso deba esperar a que otro termine o le comunique algo para continuar su operación
* *Estado*
* *Otras operaciones*: Por ejemplo, _signaling_ entre procesos

#### Cargado y ejecución
1. Carga
1. Creación de stack
1. Creación de heap
1. Creación de descriptores de archivos y otra I/O
1. Seteo de entry point y comienzo de ejecución

#### Estados

### Syscalls relacionadas a procesos

#### fork

#### exec
Ejecuta el programa pasado con sus argumentos, solo retorna si hubo un error al intentar ejecutar el archivo (ejemplo: el archivo no tiene permisos de ejecución o )

# Concurrencia

## Locks
Deben proveer:
* Exclusión mutua: Solo un thread posee el lock a la vez.
* Progress: Si nadie tiene el lock y alguien lo quiere, debe poder obtenerlo.
* Bounded waiting: El acceso a un lock es 'justo'

## Monitors
Permiten a un thread esperar por otros threads, para evitar polling sobre un lock (spin wait)
API:
* wait
* signal
* broadcast
