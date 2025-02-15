# Añade un empleado al departamento que ocupa la posición 2. Los datos son el salario 2340, el puesto Técnico, y nombre Pedro Fraile.

    let $nuevoEmple := 
        <EMP_ROW>
            <EMP_NO>0002</EMP_NO>
            <NOMBRE>Pedro</NOMBRE>
            <APELLIDO>Fraile</APELLIDO>
            <OFICIO>Técnico</OFICIO>
            <DIR>7566</DIR>
            <FECHA_ALT>2013-05-23</FECHA_ALT>
            <SALARIO>2340</SALARIO>
            <DEPT_NO>30</DEPT_NO>
        </EMP_ROW>
    
    return update insert $nuevoEmple into doc("empleados.xml")/EMPLEADOS
