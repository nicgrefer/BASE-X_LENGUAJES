# BASE-X_LENGUAJES
Se emplea el lenguaje XML 

>[!NOTE]
>Tadas las consultas se basan en el script que hay en el [GitHub](https://github.com/nicgrefer/BASE-X_LENGUAJES/tree/main/FicherosXML)

> [!TIP]
> Todas las funciones que se ve acontinuación sirve para los 2 *merados* que aparece en el `readme`

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
### Number
Para pasar de un elemento plano de estilo texto a numero (de String -> int)


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



----

> [!NOTE] 
>Este es otra aplicación para poder hacer las consultas

[[https://github.com/eXist-db/exist/releases]]

1. Descargamos el .jar
2. Open java admin....

>[!TIP]
> Para añadir un archibo **XML** --> Crear nueva coleccion (agregar nombre) --> Almacenar uno o mas ficheros (estando dentro de le coleccion) --> Usar los prismaticos para hacer consultas   

---

# XQuery

Para hacer consultas de estilo *FLWOR* (LEIDO COMO FLOWER). A diferencia del XPad en este se puede manipilar, transformar y editar


    for <variable> in <expresión XPath> 
    let <variables vinculadas> 
    where <condición XPath>
    order by <expresión>
    return <expresión de salida>

## Funciones:

| Cláusula     | Función                                      |
| ------------ | -------------------------------------------- |
| **FOR**      | Recorre los elementos de la consulta XPath   |
| **LET**      | Define variables auxiliares dentro del ciclo |
| **WHERE**    | Filtra los resultados según una condición    |
| **ORDER BY** | Ordena los resultados                        |
| **RETURN**   | Define la estructura de salida               |


## Estructura:

Para *crear* variables se usa el simbolo del `$` como por ejemplo `$empleado` de esta forma todo lo que se ponga detras del nombre podra ser usado llamandolo con la *referencia* creada.
En el caso del **`FOR`** despues de crear la variable, se tiene que poner `in` como se ve en el siguiente ejemplo:

     for $empleado in //EMP_ROW

Tambien otra cosa muy importante de su estructura es que a la hora de poner un **`LET`** y crear la variable se emplee la siguiente combinación de simbolos `:=` ej:

    let $nombre_completo:=concat($empleado/APELLIDO, '-', $empleado/EMP_NO)


>[!NOTE]
>Todas las funciones mencionadas anteriormente se siguen utilizando aquí también ya que tienen la misma vase

ejemplos de consultas :
Mostrar nombre y Nº empleado de los distintos departamentos

    for $empleado in //EMP_ROW
    let $nombre_completo:=concat($empleado/APELLIDO, '-', $empleado/EMP_NO)
    where $empleado/EMP_NO
    return $nombre_completo

Mostrar el empleado que mas cobra:

    for $empleado in //EMP_ROW
    let $nombre_completo:=concat($empleado/APELLIDO, '-', $empleado/EMP_NO)
    where $empleado/SALARIO = max(//SALARIO)
    return $empleado
----
Mostrar el empleado que mas cobra y el que menos:

    for $empleado in //EMP_ROW
    let $nombre_completo:=concat($empleado/APELLIDO, '-', $empleado/EMP_NO)
    where $empleado/SALARIO = max(//SALARIO) or $empleado/SALARIO = min(//SALARIO)
    return $empleado
----
Mostrar cuantos empleados hay en cada oficio:

>[!TIP]
>Al poner **`distinct-values`** lo que conseguimos es obtener una lista de valores únicos del conjunto de nodos seleccionados, es decir que no se repitan ya que `distinct-values` traducido literalmente es `distintos valores`

    for $oficios in distinct-values(//OFICIO)
    let $num_emple:=count(//EMP_ROW[OFICIO=$oficios])
    return concat($oficios,'-',$num_emple)


## Formatear salida de pantalla

Igual que en cualquier lenguaje de consultas se puede formatear el estilo de salida.


Podemos *formatear* la salida como en el siguiente ejemplo:


    for $emp in /EMPLEADOS/EMP_ROW
    let $nom:=$emp/APELLIDO, $ofi:=$emp/OFICIO
    return <APEOFI>{concat($nom,' ',$ofi)}</APEOFI>

Lo que se pone entre `< >` no es nada mas que el *nombre* que le damos a la etiqueta (del lenguage XML) que al egecutar la consulta aparecerá agrupando *la información*.

Despues tenemos que usar los `{ }` que engloban las etiquetas y ya ponemos el **`concat`** que ya hemos estado usando anterior mente para poder mostrar alternando los datos con texto introducido para hacer la consulta seperandolo entre `,` y usando `" "` para poner lo que se va a mostrar textualmente

A la hora de egecutar el script del ejemplo se ve de la siguiente forma: 


    <APEOFI>SANCHEZ EMPLEADO</APEOFI>
    <APEOFI>ARROYO VENDEDOR</APEOFI>
    <APEOFI>SALA VENDEDOR</APEOFI>
    .
    .
    .


## Para filtrar por atributo...

### **Tipo 1**

Aveces el la base de datos dentro de una etiqueta tenemos atributos como en el siguiente ejemplo:

    <universidad>
      <departamento telefono="112233" tipo="A">
      <codigo>IFC1</codigo>
       <nombre>Informática</nombre>
       <empleado salario="2000">
          <puesto>Asociado</puesto>
          <nombre>Juan Parra</nombre>
       </empleado>
       <empleado salario="2300">
          <puesto>Profesor</puesto>
          <nombre>Alicia Martín</nombre>
       </empleado>
      </departamento>
    </universidad>


Por lo tanto en el  el `where` ponemos **`@xxxx=xx`** para poder buscar 

    for $dep in /universidad/departamento
    where $dep[@tipo='A']
    return $dep

### **Tipo 2** if-then-else
Tambie se puede hacer poner  condiciones como `if` `them` o `else` para hacer las condiciones pero estos se situan en la parte del `return`
 
    for $dep in /universidad/departamento
    return if( $dep[@tipo='A'])
      then $dep/nombre
    else ()

Por lo tanto, tambie se puede anidar `il-else` como se puede ver en este ejemplo:

    for $dep in /universidad/departamento
    return if ($dep/@tipo='A' )
    	then <tipoA>{data($dep/nombre)}</tipoA>
    	else if ($dep/@tipo='B')
    	then <tipoB>{data($dep/nombre)}</tipoB>
    	else ()


if...then --> si... entonces 


