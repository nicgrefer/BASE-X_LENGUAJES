> [!NOTE]
> Parte 1 del ejercicio -> Productos.xml

>1
>Obtén por cada zona el número de productos que tiene.

	for $cod in distinct-values(//cod_zona)
	let $num:= sum(//produc[cod_zona=$cod]/stock_actual)
	return concat ($cod, " - ",$num)

>2
>Obtén la denominación de los productos entres las etiquetas <zona10></zona10> si son del código de zona 10, <zona20></zona20> si son de la zona 20, <zona30></zona30> si son de la 30 y <zona40></zona40> si son de la 40.

	for $sucursal in /sucursales/sucursal
	let $director := $sucursal/director
	let $poblacion := $sucursal/poblacion
	let $debe := $sucursal/cuenta/saldodebe
	let $totalDebe := sum($debe)
	let $hay := $sucursal/cuenta/saldohaber
	let $totalHay := sum($hay)
	return concat("Sucursal con director ", $director," y codigo ",$sucursal/@codigo, "en población ", $poblacion, " y un total de saldo debe de ", $totalDebe, " y tiene un saldo total de ", $totalHay)

>3
>Obtén por cada zona la denominación del o de los productos más caros.

	for $zona in distinct-values(/productos/produc/cod_zona)
	let $productosEnZona := /productos/produc[cod_zona = $zona]
	let $precioMax := max($productosEnZona/precio)
	return  <producto>{concat('Zona ',$zona,'--',
	 	<productosMasCaros>
		        {
		            for $producto in $productosEnZona
		            where $producto/precio = $precioMax
		            return <producto>
		            <denominacion>{ 
		                $producto/denominacion }
		            </denominacion>
		            <precio>{
		                 concat(' Precio -- ', $producto/precio ,'€' )}</precio>
		            </producto>
		        }
		    	</productosMasCaros>)}
	        </producto>


> 4
>Obtén la denominación de los productos contenida entre las etiquetas <placa></placa> para los productos en cuya denominación aparece la palabra Placa Base, <memoria></memoria> para los que contienen a la palabra Memoria <micro></micro>, para los que contienen la palabra Micro y <otros></otros> para el resto de productos

	for $denominacion in distinct-values(/productos/produc/denominacion)
	return
		if (contains($denominacion, 'Placa Base'))
   			then <placa>{('Denominación ', $denominacion, ' ')}</placa>
		else if (contains($denominacion, 'Memoria'))
		         then <memoria>{('Denominación ', $denominacion, ' ')}</memoria>
		else if (contains($denominacion, 'Micro')) 
		        then <micro>{('Denominación ', $denominacion, ' ')}</micro>
		else
		        <otros>{('Denominación ', $denominacion, ' ')}</otros>

>[!NOTE]
> Parte 2 del ejercicio ->Sucursales.xml

>1
>Devuelve el código de sucursal y el número de cuentas que tiene de tipo AHORRO y de tipo PENSIONES

	for $sucursal in /sucursales/sucursal
	let $cuentaAhorro := count($sucursal/cuenta[ @tipo='AHORRO'])
	let $cuentasPension := count($sucursal/cuenta[@tipo='PENSIONES'])
	return concat("Sucursal ", $sucursal/@codigo , " tiene ", $cuentaAhorro, " cuentas de ahorro y ", $cuentasPension, " cuentas de pensiones")

 >2
>Devuelve por cada sucursal el código de sucursal, el director, la población, la suma del total debe y la suma del total haber de sus cuentas.

	for $sucursal in /sucursales/sucursal
	let $director := $sucursal/director
	let $poblacion := $sucursal/poblacion
	let $debe := $sucursal/cuenta/saldodebe
	let $totalDebe := sum($debe)
	let $hay := $sucursal/cuenta/saldohaber
	let $totalHay := sum($hay)
	return concat("Sucursal con director ", $director," y codigo ",$sucursal/@codigo, " tiene una población de ", $poblacion, " y un total de saldo debe de ", $totalDebe, " y tiene un saldo total de ", $totalHay)

 >3
>Devuelve el nombre de los directores, el código de sucursal y la población de las sucursales con más de 3 cuentas.
	
	for $sucursal in /sucursales/sucursal
	let $cuenta := count($sucursal/cuenta)
	let $poblacion := $sucursal/poblacion
	  where $cuenta>3
	return concat("Sucursal ", $sucursal/@codigo ," de la poblacion ",$poblacion ," tiene ", $cuenta, " cuentas" )

>4
> Devuelve por cada sucursal, el código de sucursal y los datos de las cuentas con más saldo debe.

	for $sucursal in /sucursales/sucursal
	let $debe := max ($sucursal/cuenta/saldodebe)
	return concat("En la sucursal con codigo ", $sucursal/@codigo," con saldo mayor de 'debe' es ", $debe)

 >5
> Devuelve la cuenta del tipo PENSIONES que ha hecho más aportación

	for $sucursal in /sucursales/sucursal
	let $aport := max ($sucursal/cuenta[@tipo='PENSIONES']/aportacion )
	return concat("En la sucursal con codigo ", $sucursal/@codigo," con aportación mayor  es ", $aport)
 
