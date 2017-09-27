
# Lab kern2

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
