# BASE-X_LENGUAJES
Se emplea el lenguaje XML

## Comandos

|Simbolo|Función|ejemplo|
|-------|-------|----|
| / | fefinir un nivel del nodo|/USO_GIMNASIO/fila_uso|
|// | busqueda recursiva|// DEP_ROW|
| .. | retroceder a nodo padre|/USO_GIMNASIO/fila_uso/.. --> /USO_GIMNASIO|
| . | seleccionar nodo actual|/USO_GIMNASIO/fila_uso/. -->/USO_GIMNASIO/fila_uso|
| [] | filtro para hacer búsquedas -> SE USA =/</>/!=/and/or|// DEP_ROW [LOC="SEVILLA"]|
| (: texto :) | comentarios||

## Funciones

### Substring

Permite crear una subcadenas como por ejemplo:

    //EMP_ROW/substring (OFICIO,3,5)

En este ejemplo sacas del oficio del caracter 3 al 5

#### Upper-case(substring)

Poner en mayuscula

#### Lower-case(substring)

Poner en minuscula

### Concat

ej: Cual es el apellido del empleado 7902

    //EMP_ROW[DIR=7902]/concat("El apeyido del empleado 7902 es ",APELLIDO )
    (: o tabmuien se puede escribir así ya que solo es un parametro :)
    concat("El apeyido del empleado 7902 es ",//EMP_ROW[DIR=7902]/APELLIDO )

Puedes poner todo lo que quieras separandolo con comas "," y wn tre comollas dobles el texto ""

### Contains

Para "verificar si contiene algo " ej:

Mostrar los números de los empleados cullos apellidos tengan una "s"
   
    //EMP_ROW [contains (APELLIDO,'S')]/EMP_NO

### Starts-with

Que empiece por...

    //EMP_ROW [starts-with(APELLIDO,'S')]/EMP_NO

## Funciones de Agrupación

Debuelbe barios nodos

### Count

Contar cuantos empleados hay en el departamento 10

    count(//EMP_ROW[DEPT_NO=10])

### AVG

Hacer la media de 
media del salario del departamento 10

    avg (//EMP_ROW[DEPT_NO=10]/SALARIO)

### Sum

Suma total

    sum (//EMP_ROW[DEPT_NO=10]/SALARIO)

### Max

Maximo

### Min

minimo

### Distinct-values
Muestra los distintos datos que tiene una bariable ej:


        distinct-values(//OFICIO)










