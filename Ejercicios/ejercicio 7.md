# Incrementa el salario a todos los empleados del departamento de INVESTIGACIÓN un 10% la media de sus salarios.

   for $emple in EMPLEADOS/EMP_ROW [DEPT_NO = departamentos/DEP_ROW[DNOMBRE ='INVESTIGACION' ]/DEPT_NO]
   let $salarioBase := $emple/SALARIO
   let $mediaSalarioInvestig :=
   return update value
   $emple/SALARIO 
   whith $salarioBase+$mediaSalarioInvestig
   ??¿