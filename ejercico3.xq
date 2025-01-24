
>1
for $zona in distinct-values(/productos/produc/cod_zona)
let $numProductos := count(/productos/produc[cod_zona = $zona])
return ('Zona ',$zona,'Num productos',$numProductos,' ')

