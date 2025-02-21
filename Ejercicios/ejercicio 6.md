# 1.Añade un empleado al departamento que ocupa la posición 2. Los datos son el salario 2340, el puesto Técnico, y nombre Pedro Fraile.

    update insert
    <EMP_ROW>
    <SALARIO>2340</SALARIO>
    <OFICIO>TÉCNICO</OFICIO>
    <APELLIDO>FRAILE</APELLIDO>
    {//DEP_ROW[2]/DEPT_NO}
    </EMP_ROW> into //EMPLEADOS

# 2.El empleado 7902 ha causado baja en la empresa, sustitúyelo por el siguiente
    for $emp in //EMPLEADOS/EMP_ROW[EMP_NO=7902]
    return update replace 
    $emp
    with 
    <EMP_ROW>
     <EMP_NO>8043</EMP_NO>
     <APELLIDO>González</APELLIDO>
     <OFICIO>Programador</OFICIO>
     <DIR>7566</DIR>
     <FECHA_ALT>2013-05-23</FECHA_ALT>
     <SALARIO>2800</SALARIO>
     <DEPT_NO>60</DEPT_NO>
    </EMP_ROW> 
# 3.Añade el departamento 60 , que es de informática y está en Valladolid
     update insert
    <DEP_ROW>
    <DEPT_NO>60</DEPT_NO>
    <NOMBRE>INFORMÁTICA</NOMBRE>
    <LOC>VALLADOLID</LOC> 
    </DEP_ROW>
    into //departamentos

# 4.Actualiza el salario de los empleados del departamento con código de departamento 20. Suma al salario 100.
    
    for $salario in //EMPLEADOS/EMP_ROW[DEPT_NO=20]/SALARIO
    let $nuevoSalario := $salario + 100
    return update value $salario with $nuevoSalario
    ------
    for $dep in //EMP_ROW[DEPT_NO='20']
    return 
    update value $dep/SALARIO
    with $dep/SALARIO + 100
    --------
    for $dep in //EMP_ROW[DEPT_NO='20']
    return 
    update replace $dep/SALARIO
    with <SALARIO>{$dep/SALARIO + 100}</SALARIO>


# 5.Renombra el nodo DEP_ROW del documento departamentos.xml por filadepar 

    update rename /departamentos/DEP_ROW as 'filadepar'

# 6.Borra todos los empleados que trabajen en Valladolid

   update delete 
   //EMP_ROW[DEPT_NO=//DEP_ROW[LOC='VALLADOLID']/DEPT_NO]

otra opción

   for $dep in distinct-values(/EMPLEADOS/EMP_ROW/DEPT_NO)
   for $depd in (/departamentos/DEP_ROW[LOC='VALLADOLID']/DEPT_NO)
   return if($dep=$depd) then update delete /EMPLEADOS/EMP_ROW[DEPT_NO=$depd]
   else()

opción

   for $emple in //departamentos/filadep[LOC='VALLADOLID']
   let $dep:=$emple/DEPT_NO
   return update delete /EMPLEADOS/fila_emple[DEPT_NO=$dep]


# 7.Añade en departamentos un nuevo campo que muestre la media del salario de sus empleados en su departamento. (no funciona)


   for $dep in distinct-values(/departamentos/DEP_ROW/DEPT_NO)
   let $media:=avg(/EMPLEADOS/EMP_ROW[DEPT_NO=$dep]/SALARIO)
   return update insert <media>{$media}</media> into /departamentos/DEP_ROW[DEPT_NO=$dep]

o

   for $dep in /departamentos/DEP_ROW
   let $numdep:=data($dep/DEPT_NO), $sal:=avg(/EMPLEADOS/EMP_ROW[DEPT_NO=$numdep]/SALARIO)
   return update insert <media> {$sal} </media> into $dep

o

   for $dep in /departamentos/DEP_ROW
   let $depno:= data($dep/DEPT_NO)
   let $media:= avg(//EMP_ROW[DEPT_NO=$depno]/SALARIO)
   return update insert <mediasalario>{$media}</mediasalario> into //$dep[DEPT_NO=$depno]












