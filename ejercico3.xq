
>1
for $zona in distinct-values(/productos/produc/cod_zona)
let $numProductos := count(/productos/produc[cod_zona = $zona])
return ('Zona ',$zona,'Num productos',$numProductos,' ')

>2 

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



