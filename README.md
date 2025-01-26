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
> Para añadir un archibo **XML** --> Crear nueva coleccion (aagregar nombre) --> Almacenar uno o mas ficheros (estando dentro de le coleccion) --> Usar los prismaticos para hacer consultas   

---

# XQuery

Para hacer consultas de estilo *FLWOR* (LEIDO COMO FLOWER). A diferencia del XPad en este se puede manipilar, transformar y editar


    for <variable> in <expresión XPath> 
    let <variables vinculadas> 
    where <condición XPath>
    order by <expresión>
    return <expresión de salida>

>[!NOTE]
>**FOR** -> Dara tantas bueltas como recoje el XPath.
>
>Por cada buelta en **LET** podemos definir nuevas bariables que nos interesen.
>
>La clausura **WHERE** tiene la funcion de filtrar como en *SQL*.
>
>El **ORDEN BY** para colpocar cual es el orden de la salida de los datos.
>
>En **RETURN** expresamos que es lo que se va a mostrar .

| Cláusula     | Función                                      |
| ------------ | -------------------------------------------- |
| **FOR**      | Recorre los elementos de la consulta XPath   |
| **LET**      | Define variables auxiliares dentro del ciclo |
| **WHERE**    | Filtra los resultados según una condición    |
| **ORDER BY** | Ordena los resultados                        |
| **RETURN**   | Define la estructura de salida               |


ejemplo :
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
    for $empleado in //EMP_ROW
    let $nombre_completo:=concat($empleado/APELLIDO, '-', $empleado/EMP_NO)
    where $empleado/SALARIO = max(//SALARIO) or $empleado/SALARIO = min(//SALARIO)
    return $empleado
----
    for $oficios in distinct-values(//OFICIO)
    let $num_emple:=count(//EMP_ROW[OFICIO=$oficios])
    return concat($oficios,'-',$num_emple)


## Formatear salida de pantalla


Podemos *formatear* la salida como en el siguiente ejemplo:

    for $emp in /EMPLEADOS/EMP_ROW
    let $nom:=$emp/APELLIDO, $ofi:=$emp/OFICIO
    return <APEOFI>{concat($nom,' ',$ofi)}</APEOFI>

Se emplea el `APEOFI` y es importante poner entre las `{}` lo que quieras que se *lea* o *use* para representar la consulta



## Para filtrar por atributo...

En el `where` ponemos **`@xxxx=xx`** para poder buscar 

    for $dep in /universidad/departamento
    where $dep[@tipo='A']
    return $dep

### if-then-else
Tambie se puede hacer poner  condiciones como `if` `them` o `else` para hacer las condiciones 
 
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





