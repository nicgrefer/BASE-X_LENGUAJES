# 1.Incrementa el salario a todos los empleados del departamento de INVESTIGACIÓN un 10% la media de sus salarios.

   for $dep in /departamentos/DEP_ROW[DNOMBRE="INVESTIGACION"]/DEPT_NO
	for $media in avg(/EMPLEADOS/EMP_ROW[DEPT_NO=$dep]/SALARIO)
	for $sal in /EMPLEADOS/EMP_ROW[DEPT_NO=$dep]/SALARIO
	let $nuevoSal:=data($sal) + data($media)*0.10
	return update value $sal with $nuevoSal

   for $dept in //filadepar[DNOMBRE='INVESTIGACION']
   let $emple:= //EMP_ROW[DEPT_NO=$dept/DEPT_NO]
   let $mediaSal:=round(avg($emple/SALARIO))
   for $emp in $emple
   return update value $emp/SALARIO with $emp/SALARIO+0.1*$mediaSal

# 2.Queremos cambiar la etiqueta OFICIO por puesto

	update rename /EMPLEADOS/EMP_ROW/OFICIO as 'puesto'

# 3.Añadir a departamento una nueva etiqueta con el número de empleados que tiene cada departamento. <NUMEMPLE>x</NUMEMPLE>

for $dep in distinct-values(/departamentos/DEP_ROW/DEPT_NO)
let $media := avg(/EMPLEADOS/EMP_ROW[DEPT_NO=$dep]/SALARIO)
return update insert <NUMEMPLE>{$media}</NUMEMPLE> into /departamentos/DEP_ROW[DEPT_NO=$dep]

# 4.Borrar al empleado que más cobra de cada departamento. 



# 5.Modificar la denominación de VENDEDOR por COMERCIAL



> Comprender correccion

4.-
for $dep in /departamentos/DEP_ROW/DEPT_NO
for $maxSal in max(/EMPLEADOS/EMP_ROW[DEPT_NO=$dep]/SALARIO)
return update delete /EMPLEADOS/EMP_ROW[SALARIO=$maxSal and DEPT_NO=$dep]

for $dep in /departamentos/DEP_ROW/DEPT_NO
let $maxSal:=max(/EMPLEADOS/EMP_ROW[DEPT_NO=$dep]/SALARIO)
return update delete /EMPLEADOS/EMP_ROW[SALARIO=$maxSal and DEPT_NO=$dep]



5.-
for $emp in /EMPLEADOS/EMP_ROW[OFICIO="VENDEDOR"]/OFICIO
return update value $emp with 'COMERCIAL'

o 
/EMPLEADOS/EMP_ROW[OFICIO="VENDEDOR"]/OFICIO

O

update value //EMP_ROW[OFICIO="VENDEDOR"]/OFICIO with 'COMERCIAL'