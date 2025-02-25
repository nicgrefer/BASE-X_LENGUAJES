# Por recortes en la empresa y tras una serie de despidos queremos eliminar de empleados.xml, todos aquellos empleados que cobran por encima de la media de su departamento.

````
for $departamento in distinct-values(/EMPLEADOS/EMP_ROW/DEPT_NO)
let $mediaDepart := avg(/EMPLEADOS/EMP_ROW[DEPT_NO = $departamento]/SALARIO)
for $emple in /EMPLEADOS/EMP_ROW[DEPT_NO = $departamento]
where $emple/SALARIO > $mediaDepart
return update delete $emple
````

# Elimina la etiqueta EMP_NO, convirtiéndola a atributo de la etiqueta EMP_ROW

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

````
for $EMPLE in /EMPLEADOS/EMP_ROW[OFICIO != "VENDEDOR"]
for $depart in /DEPARTAMENTOS/DEP_ROW
where ($depart/LOC = "BILBAO" or $depart/LOC = "BARCELONA")
and $EMPLE/DEPT_NO = $depart/DEPT_NO
return update value $EMPLE/SALARIO 
with 9999999999
````

# Listado por cada oficio de las personas que más cobran

````
for $empleOfice in distinct-values (/EMPLEADOS/EMP_ROW/OFICIO)
let $maxSal := max(/EMPLEADOS/EMP_ROW[OFICIO=$empleOfice]/SALARIO)
return
<emple>
	<oficio>{$empleOfice}</oficio>
	<salarioMax>{$maxSal}</salarioMax>
</emple>
````

# Cambiar la etiqueta SALARIO por SUELDO

````
for $salario in /EMPLEADOS/EMP_ROW/SALARIO
return update replace $salario with <SUELDO>{$salario/text()}</SUELDO>
````

# Aquellos que son de un departamento de Valladolid o Barcelona o Madrid se les incrementa el sueldo un 10% menos a los DIRECTOR









