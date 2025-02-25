# Por recortes en la empresa y tras una serie de despidos queremos eliminar de empleados.xml, todos aquellos empleados que cobran por encima de la media de su departamento.

> Opcion profesor
````
for $dept in //DEP_ROW/DEPT_NO
let $sal:=avg(//EMP_ROW[DEPT_NO=$dept]/SALARIO)
return update delete //EMP_ROW[DEPT_NO=$dept and SALARIO>$sal]
````

> Mi opción
````
for $departamento in distinct-values(/EMPLEADOS/EMP_ROW/DEPT_NO)
let $mediaDepart := avg(/EMPLEADOS/EMP_ROW[DEPT_NO = $departamento]/SALARIO)
for $emple in /EMPLEADOS/EMP_ROW[DEPT_NO = $departamento]
where $emple/SALARIO > $mediaDepart
return update delete $emple
````


# Elimina la etiqueta EMP_NO, convirtiéndola a atributo de la etiqueta EMP_ROW
> Mi opcció (con `replace`)
````
for $departamento in /EMPLEADOS/EMP_ROW
let $emp_no := $departamento/EMP_NO
return update replace $departamento
with  <EMP_ROW emp_no= '{$emp_no}' >
    	{$departamento/APELLIDO}
	{$departamento/OFICIO}
	{$departamento/DIR}
	{$departamento/FECHA_ALT}
	{$departamento/SALARIO}
	{$departamento/DEPT_NO}
  </EMP_ROW>
````
> Version profe 1 (con `rename`)
````
for $emp in //EMP_ROW
let $cod:=$emp/EMP_NO
let $cadena:=concat('EMP_ROW EMP_NO="',$cod,'"')
return (update rename //EMP_ROW[EMP_NO=$emp/EMP_NO] as $cadena , update delete $cod)
````
> Version profe 2
````
for $emple in /EMPLEADOS/EMP_ROW
return (update insert attribute EMP_NO {$emple/EMP_NO} into $emple , update delete $emple/EMP_NO)
````


# Queremos listar en una tabla HTML el número de empleado, nombre de su departamento, y lo que cobra (teniendo en cuenta el total de SALARIO+COMISION

````
<html>
	<body>
		<table>
		 {
			for $emple in /EMPLEADOS/EMP_ROW
			let $salario := $emple/SALARIO 
			let $comision := $emple/COMISION
			let $salariofin := 
					if ($comision) then $salario + $comision
					else $salario
			
			return 
			
				<tr>
					<td>N emple {$emple/EMP_NO}</td>
					<td>N depar {$emple/DEPT_NO}</td> 
					<td>cobra {$salariofin}</td> 
				</tr>
		}</table>
	</body>
</html>


````

# Incrementa el salario de los empleados que no son vendedores de Bilbao o Barcelona
> v1
````
for $EMPLE in //EMP_ROW[OFICIO != "VENDEDOR"]
for $depart in //DEP_ROW
where ($depart/LOC != "BILBAO" or $depart/LOC != "BARCELONA")
and $EMPLE/DEPT_NO = $depart/DEPT_NO
return update value $EMPLE/SALARIO 
with 9999999999
````
> v2
````
for $depart in //DEP_ROW[LOC != 'BARCELONA' and LOC != 'BILBAO']/DEPT_NO
for $emple in //EMP_ROW[DEPT_NO = $depart and OFICIO != "VENDEDOR"]
let $sal:= $emple/SALARIO
return update value $emple/SALARIO with $sal+150

````


# Listado por cada oficio de las personas que más cobran

````
for $empleOfice in distinct-values (//OFICIO)
let $maxSal := max(//EMP_ROW[OFICIO=$empleOfice]/SALARIO)
return
<emple>
	<oficio>{$empleOfice}</oficio>
	{//EMP_ROW[SALARIO =$maxSal ]/APELLIDO}
	<salarioMax>{$maxSal}</salarioMax>
</emple>
````

# Cambiar la etiqueta SALARIO por SUELDO

````
for $salario in /EMPLEADOS/EMP_ROW/SALARIO
return update replace $salario with <SUELDO>{$salario/text()}</SUELDO>
````

# Aquellos que son de un departamento de Valladolid o Barcelona o Madrid se les incrementa el sueldo un 10% menos a los DIRECTOR

````
for $emp in /EMPLEADOS/EMP_ROW
let $va := /departamentos/DEP_ROW[LOC='VALLADOLID']/DEPT_NO
let $ba := /departamentos/DEP_ROW[LOC='BARCELONA']/DEPT_NO
let $ma := /departamentos/DEP_ROW[LOC='MADRID']/DEPT_NO
return if (($emp/DEPT_NO=$va or $emp/DEPT_NO=$ba or $emp/DEPT_NO=$ma) and $emp/OFICIO!='DIRECTOR') 
	then update value $emp/SALARIO with $emp/SALARIO*1.10
else ()
````







