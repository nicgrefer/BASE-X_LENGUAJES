# 1.Obtén por cada sucursal el mayor saldo haber y el nombre de la cuenta que tiene ese saldo.
    
    for $suc in //sucursal
    for $cta in $suc/cuenta
    let $maxSal := max($suc/cuenta/saldohaber)
    return if($cta/saldohaber = $maxSal)
    	then <saldoMax>{$suc/@codigo}<sal>{$maxSal}</sal>{$cta/nombre}</saldoMax>
    else ()

---
    for $sucur in /sucursales/sucursal/@codigo
    for $cuenta in /sucursales/sucursal[@codigo=$sucur]/cuenta
    let $valmax:=max(/sucursales/sucursal[@codigo=$sucur]/cuenta/saldohaber)
    return if ($cuenta/saldohaber=$valmax) then
    concat('Nombre Cuenta', $cuenta/nombre, 'Saldo Haber Maximo',$valmax) 
    else ()
---

    for $Surcur in distinct-values(//sucursal/@codigo)
    let $maxSaldo := max(//sucursal[@codigo = $Surcur]/cuenta/saldohaber)
    return <cuenta>{$maxSaldo}
    {for $nombre in //sucursal[@codigo = $Surcur]/cuenta[saldohaber = $maxSaldo]
    /nombre
    return concat(' ',$nombre)}</cuenta>

# 2 Obtén por cada sucursal el nombre de la cuenta del tipo AHORRO cuyo saldo debe sea el máxima 

    for $suc in //sucursal
    for $cuenta in $suc/cuenta[@tipo = 'AHORRO']
    return concat("Nombre: ", $cuenta/nombre)


# 3 Visualiza los nombres de productos con su nombre de zona. Utiliza dos for en la consulta.

# 4 

# 5
