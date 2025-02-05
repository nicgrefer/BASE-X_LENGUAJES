# Ejemplos de for

    for $dep in /universidad/departamento 
    for $pue in distinct-values($dep/empleado/puesto)
    let $cu:=count($dep/empleado[puesto=$pue])
    return <departamentos><depart>{data($dep/nombre)}</depart><puesto>{data($pue)}</puesto></departamentos>

  ----
  Tambien se puede crear a partir de la consulta archibos `HTML` como en el siguiente egemplo:
    
    <HTML>
    <BODY>
    <table>
    {
    for $dept in (//DEP_ROW)
    let $nodept:=$dept/DEPT_NO , $nomdep:=$dept/DNOMBRE
    for $emple in (//EMP_ROW[DEPT_NO=$nodept])
    let $empleado:=$emple/APELLIDO
    return <tr><td>{data($nodept)}</td><td>{data 
    ($nomdep)}</td><td>{data($empleado)}</td></tr>
    }
    </table>
    </BODY>
    </HTML>
---
    for $dept in (//DEP_ROW)
    let $nodept:= $dept/DEPT_NO
    let $nomdep:= $dept/DNOMBRE
    let $emplecaro:=//EMP_ROW[SALARIO=max(//EMP_ROW[DEPT_NO=$nodept]/SALARIO) and DEPT_NO=$nodept]/APELLIDO
    return 
    <res>
    <dept>{data($nomdep)}</dept>
    <nodept>{data($nodept)}</nodept>
    <empleados>
    {for $apellido in $emplecaro
    return concat($apellido,' , ')
    }
    </empleados>
    </res>
