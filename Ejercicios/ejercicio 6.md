# Añade un empleado al departamento que ocupa la posición 2. Los datos son el salario 2340, el puesto Técnico, y nombre Pedro Fraile.

    update insert
    <EMP_ROW>
    <SALARIO>2340</SALARIO>
    <OFICIO>TÉCNICO</OFICIO>
    <APELLIDO>FRAILE</APELLIDO>
    {//DEP_ROW[2]/DEPT_NO}
    </EMP_ROW> into //EMPLEADOS

# El empleado 7902 ha causado baja en la empresa, sustitúyelo por el siguiente
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
# Añade el departamento 60 , que es de informática y está en Valladolid
     update insert
    <DEP_ROW>
    <DEPT_NO>60</DEPT_NO>
    <NOMBRE>INFORMÁTICA</NOMBRE>
    <LOC>VALLADOLID</LOC> 
    </DEP_ROW>
    into //departamentos

# Actualiza el salario de los empleados del departamento con código de departamento 20. Suma al salario 100.
    
    for $salario in //EMPLEADOS/EMP_ROW[DEPT_NO=20]/SALARIO
    let $nuevoSalario := $salario + 100
    return update value $salario with $nuevoSalario
    ------
    for $dep in //EMP_ROW[DEPT_NO='20']
    return 
    update value $dep/SALARIO
    with $dep/SALARIO + 100


# Renombra el nodo DEP_ROW del documento departamentos.xml por filadepar

