# Solucionador de Matrices

Alan Badillo Salas | [@badillosoft](https://twitter.com/badillosoft) | [badillo.soft@hotmail.com](mailto:badillo.soft@hotmail.com)

## Introducción

Los siguientes códigos resulven trabajan con matrices de *nxm*
dadas por el usuario desde la entrada estándar y permiten realizar
diversas operaciones entre matrices y escalares.

Este proyecto pertenece al proyecto [Code-For-Day](https://github.com/badillosoft/code-for-day) disponible en __Github__.

## Resolver un sistema de ecuaciones

Podemos resolver un sistema de ecuaciones mediante el programa __*cramer.rb*__.

> Definimos la matriz en un archivo de texto plano
>
> * La primer línea representa la dimensión de la matriz,
> podemos escribir __*n*__ lo cual crea una matriz de __*nxn*__
> o __*n m*__ que crea una matriz de __*nxm*__
>  
> * Las siguientes dos filas representan cada uno de las filas de matriz
> 
> * El último renglón representa el vector solución de la matriz

**data.mat**

~~~
2
1 2
3 4
4 10
~~~

> Ejecutamos el programa cramer.rb

~~~bash
$ ruby cramer.rb < data
~~~

> El resultado del comando anterior es:

~~~
n :> 0 :> 1 :> sol :> 
Matriz General
|1.0	2.0	|
|3.0	4.0	|

Determinante General: 
1.0 * 4.0 - 3.0 * 2.0
D = -2.0

========================================

Matriz X1
|4.0	2.0	|
|10.0	4.0	|

Determinante 1: 
4.0 * 4.0 - 10.0 * 2.0
D1 = -4.0

| X1 = 2.0 |

========================================

Matriz X2
|1.0	4.0	|
|3.0	10.0	|

Determinante 2: 
1.0 * 10.0 - 3.0 * 4.0
D2 = -2.0

| X2 = 1.0 |

========================================
~~~

> Podemos ingresar los datos manualmente simplemente ingresando el comando:

~~~
$ ruby cramer.rb
n :> 2
0 :> 1 2
1 :> 3 4
sol :> 4 10
~~~

## Leer una matriz desde la entrada estándar

Existen varias formas de leer una matriz desde la entrada estándar.

> Leer las dimensiones de la matriz

~~~rb
n, m = get_dim
~~~

> Leer una matriz de __*nxm*__ (como arreglo) desde la entrada estándar

~~~rb
mat = get_mat(n, m)
~~~

> Leer un vector de tamaño __*n*__ (como arreglo) desde la entrada estándar

~~~rb
vec = get_vec(n)
~~~

> Leer una matriz (de la clase __*Matrix*__) desde la entrada estándar
> leyendo la dimensión y luego cada una de las posiciones

~~~rb
mat = Matrix.read
~~~

> Leer una matriz (de la clase __*Matrix*__) desde la entrada estándar
> leyendo el número de filas y luego cada una de las columnas

~~~rb
mat = Matrix.read_vec_mode
~~~

## Crear una matriz

Podemos crear una matriz con valores por defecto o a partir de un arreglo
de arreglos.

> Crear una matriz de dimensión dada

~~~rb
mat1 = Matrix.make 2			# => Matriz de 2x2 inicializada en 0's
mat2 = Matrix.make 3, 4			# => Matriz de 3x4 inicializada en 0's
mat3 = Matrix.make 5, 6, 1		# => Matriz de 5x6 inicializada en 1's
~~~

> Crear una matriz a partir de un arreglo de arreglos

~~~rb
mat = Matriz.new [[1, 2], [3, 4]]
~~~

## Clonar una matriz

Podemos crear una copia de los valores de la matriz en una nueva instancia

> Clonar una matriz en una nueva instancia independiente

~~~rb
other = mat.clone
~~~

## Iterar una matriz

Existen varias formas de iterar una matriz.

> Iterar una matriz fila a fila

~~~rb
mat.each do |vec|
	...
end
~~~

> Iterar una matriz posición a posición

~~~rb
mat.iterate do |x, i, j|
	...
end
~~~

> Iterar una matriz a través de su arreglo de datos

~~~rb
mat.raw.each do |vec|
end
~~~

## Obtener datos de la matriz

Podemos obtener datos de la matriz como sus dimensiones, una posición
específica, etc.

> Dimensiones de la matriz

~~~rb
mat.n	# => Número de filas
mat.m	# => Número de columnas
~~~

> Posición específica

~~~rb
mat[i, j]			# => Valor de la matriz en la posición i, j
mat[i, j] = 1		# => Modifica la matriz en la posición i, j
~~~

> Obtener la matriz como cadena

~~~rb
txt_mat = mat.to_s

puts mat
~~~

## Reemplazar filas y columnas

Podemos reemplazar una fila o una columna de la matriz devolviendo
una nueva matriz, o modificando la original poniendo ! despúes del método dado.

> Reemplazar una columna

~~~rb
# Reemplaza la columna 1 en una nueva matriz
mat_mod = mat.replace_col 1, [1, 2, 3]

# Reemplaza la columna 2 modificando la matriz
mat.replace_col! 2, [4, 5, 6]
~~~


> Reemplazar una fila

~~~rb
# Reemplaza la columna 3 en una nueva matriz
mat_mod = mat.replace_row 3, [1, 2, 3]

# Reemplaza la columna 4 modificando la matriz
mat.replace_row! 4, [4, 5, 6]
~~~

## Obtener la matriz menor

Podemos obtener la *matriz menor* en una posición dada.

> Matriz menor

~~~rb
# mat <= [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
mat_min = mat.minor 1, 1
# mat_min <= [[1, 3], [7, 9]]
~~~

## Signo de una posición

Podemos obtener el signo de una posición dada, el cual es útil para
el cálculo de determinantes.

~~~rb
# mat <= [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
s1 = mat.sign 0, 1 # => -1
s2 = mat.sign 1, 1 # => 1
s3 = mat.sign 1, 2 # => -1
s4 = mat.sign 2, 2 # => 1
~~~

## Determinantes

Podemos calcular el determinante de la matriz (si es de cuadrada).
También podemos calcular la expresión numérica del determinante.

> Determinante numérico

~~~rb
d = mat.determinant
~~~

> Expresión numérica del determinante

~~~rb
# mat <= [[1, 2], [3, 4]]
e = mat.pdeterminant # => 1 * 4 - 2 * 3

# mat <= [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
e = mat.pdeterminant 
# e => 1 * (5 * 9 - 8 * 6) -2 * (4.0 * 9.0 - 7.0 * 6.0) 3 * (4.0 * 8.0 - 7.0 * 5.0)
~~~

Alternativamente podemos invocar a *rdetermiant* que funciona similar a
*pdetermiant* pero muestra la matriz menor su determinante con expresión.

## Operaciones

En contrucción

> Multiplicación Matriz - Escalar -> Matriz

~~~rb
# mat <= [[1, 2], [3, 4]]
mat_r = mat * -1 # => [[-1, -2], [-3, -4]]
~~~




