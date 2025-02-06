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

	for $productos in /productos
	for $produc in $productos/produc
	let $nombre := $produc/denominacion
	let $zona := $produc/cod_zona
	return concat("Producto ", $nombre," esta en la zona ",$zona)

# 4 Visualiza los nombres de productos con stockminimo > 5. su código de zona, su nombre y el director de esa zona. Utiliza dos for en la consulta

	for $produc in /productos/produc
	for $zona in /zonas/zona
	where $produc/cod_zona = $zona/cod_zona and $produc/stock_actual > 5
	let $nombre := $produc/denominacion
	let $cod_zona := $produc/cod_zona
	let $director := $zona/director
	return concat("Producto ", $nombre, " está en la zona ", $cod_zona, " cuyo director es ", $director)

# 5 Mostrar el nombre de la zona, y la denominación de los productos cuyos precios superar la media de los productos de esa zona.

	for $zona in /zonas/zona
	let $productosZona := /productos/produc[cod_zona = $zona/cod_zona]
	let $precioMedio := avg($productosZona/precio)
	for $produc in $productosZona
	where $produc/precio > $precioMedio
	let $nombre := $produc/denominacion
	let $nombreZona := $zona/nombre
	return concat("Producto ", $nombre, " está en la zona ", $nombreZona)
