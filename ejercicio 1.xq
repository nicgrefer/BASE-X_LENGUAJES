(:Obtén los nodos denominación y precio de todos los productos.:)
(://produc/concat("Denominacion: ", denominacion, " Precio ",precio) :)

(:2. Obtén los nodos de los productos que sean placas base.:)
(://produc [starts-with(denominacion,'Placa Base')]:)

(:3. Obtén los nodos de los productos con precio mayor de 60 € y de la zona 20.:)
//produc [precio>60 and cod_zona=20]

(:4. Obtén el número de productos que sean memorias y de la zona 10 .:)
//produc [starts-with(denominacion, 'Memoria')and cod_zona=10] /cod_prod 

(:5. Obtén la media de precio de los micros.:)
avg(//produc[contains(denominacion, 'Micro')]/precio)

(:6. Obtén los datos de los productos cuyo stock mínimo sea mayor que su stock actual.:)
//produc[stock_minimo<stock_actual]/concat("El producto", denominacion," tiene un stok de ",stock_actual)

(:7. Obtén el nombre de producto y el precio de aquellos cuyo stock mínimo sea mayor que su stock actual y sean de la zona 40:)
//produc[stock_actual < stock_minimo and cod_zona=40]/concat("El producto", denominacion," tiene un precio de ",precio," y esta en la zona ", cod_zona)

(:8. Obtén el producto más caro .:)
//produc [precio = max(//produc/precio)]/concat("El producto mas caro es ",denominacion, " con un precio de ", precio) 

(:9. Obtén el producto más barato de la zona 20:)
//produc [precio = min(//produc[cod_zona=20]/precio)]/concat("El producto mas varato es ",denominacion, " con un precio de ", precio, " de la zona ", cod_zona) 

(:10. Obtén el producto más caro de la zona 10:)
//produc [precio = max(//produc[cod_zona=10]/precio)]/concat("El producto mas caro de la zona ", cod_zona, " es el ", denominacion, " con un precio de ", precio)
