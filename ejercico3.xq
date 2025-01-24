
>1
for $zona in distinct-values(/productos/produc/cod_zona)
let $numProductos := count(/productos/produc[cod_zona = $zona])
return ('Zona ',$zona,'Num productos',$numProductos,' ')

>2 inicio

for $denominacion in distinct-values(/productos/produc/denominacion)
let $zona := count(/productos/cod_zona[denominacion = $denominacion])
return if ($zona='10')
then <tipoA>{data($dep/nombre)}</tipoA>
 ('Zona ',$zona,'Num productos',$numProductos,' ')


