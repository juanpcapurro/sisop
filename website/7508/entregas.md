# Instrucciones de entrega

## En papel
{: #papel}

Las entregas en papel deben seguir los siguientes lineamientos:

  - todas las líneas de código deben imprimirse, siempre, en tipografía de paso fijo `(monoespaciada)`.

  - bien visible en la primera hoja (sea carátula o no): su nombre y número de legajo, nombre de la entrega y fecha en que fue entregada.

  - todas las hojas abrochadas juntas y sin folio.[^1]

[^1]: Habrá en el aula una abrochadora a disposición de los alumnos que la necesiten.

Cuando la entrega incluya preguntas a responder **en prosa, se pide respuestas concisas** de dos o tres oraciones simples por párrafo. Ejemplo:

> _¿Qué hace la BIOS una vez verificado el hardware? ¿Qué debe ocurrir a continuación?_
>
> Tras la inicialización del hardware, la BIOS determina el dispositivo de arranque y copia su primer sector (512 bytes) en la dirección de memoria física `0x7c00`. A continuación, la ejecución salta a esa posición.
>
> Estos 512 bytes de código, denominados el “boot loader” del kernel, deben ocuparse de inicializar la CPU al estado deseado, y cargar en memoria el resto de instrucciones del kernel.
>
> La incialización de la CPU consiste, normalmente, en el paso de modo real (16-bit) a modo protegido (32-bit). La carga del kernel se suele realizar desde disco.
>
> La última instrucción del boot loader consiste en saltar al punto de entrada del kernel cargado, que toma así el control de la máquina.

{% include footnotes.html %}
