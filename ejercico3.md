
>1
>Obtén por cada zona el número de productos que tiene.

		for $zona in distinct-values(/productos/produc/cod_zona)
		let $numProductos := count(/productos/produc[cod_zona = $zona])
		return ('Zona ',$zona,'Num productos',$numProductos,' ')

>2
>Obtén la denominación de los productos entres las etiquetas <zona10></zona10> si son del código de zona 10, <zona20></zona20> si son de la zona 20, <zona30></zona30> si son de la 30 y <zona40></zona40> si son de la 40.

	for $zona in distinct-values(/productos/produc/cod_zona)
	let $numProductos := count(/productos/produc[cod_zona = $zona])
	return if ($zona = '10')
		then <zona10>{('Zona ', $zona, 'Num productos ', $numProductos, ' ')}</zona10>
		else if ($zona = '20')
		then <zona20>{('Zona ', $zona, 'Num productos ', $numProductos, ' ')}</zona20>
		else if ($zona = '30')
		then <zona30>{('Zona ', $zona, 'Num productos ', $numProductos, ' ')}</zona30>
		else if ($zona = '40')
		then <zona40>{('Zona ', $zona, 'Num productos ', $numProductos, ' ')}</zona40>
		else()

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
	                        <denominacion>{ $producto/denominacion }</denominacion>
	
	                        <precio>{concat(' Precio -- ',  $producto/precio ,'€' )}</precio>
	                   </producto>
	        }
		      	</productosMasCaros>)}
	        </producto>


> 4
>Obtén la denominación de los productos contenida entre las etiquetas <placa></placa> para los productos en cuya denominación aparece la palabra Placa Base, <memoria></memoria> para los que contienen a la palabra Memoria <micro></micro>, para los que contienen la palabra Micro y <otros></otros> para el resto de productos

	for $denominacion in distinct-values(/productos/produc/denominacion)
	return
		 if (contains($denominacion, 'Placa Base')) then
		        <placa>{('Denominación ', $denominacion, ' ')}</placa>
		    else if (contains($denominacion, 'Memoria')) then
		        <memoria>{('Denominación ', $denominacion, ' ')}</memoria>
		    else if (contains($denominacion, 'Micro')) then
		        <micro>{('Denominación ', $denominacion, ' ')}</micro>
		    else
		        <otros>{('Denominación ', $denominacion, ' ')}</otros>
