# 1)Listado de nombre de paciente y nombre de vacuna suministrada
````
for $paciente in //paciente
let $vacunasum := //vacuna[@id = $paciente/vacuna]/nombre
return 
<paciente> 
	<nombre>{data($paciente/nombre)}</nombre>
	<vacuna>{data($vacunasum)}</vacuna>
</paciente>
````
# 2)Listado de nombre de paciente y nombre de vacuna suministrada
````
for $ciudad in  distinct-values(//ciudad)
let $numerovacs := count(//paciente[ciudad = $ciudad])
return
<resultado>
	<ciudad>{$ciudad}</ciudad>
	<numerovacunas>{$numerovacs}</numerovacunas>
</resultado>
````
# 3)Cuál es el precio medio de todos los tipos de dosis de vacuna existente, es decir, precio 
medio de las vacunas de dosis Simple y precio medio de las vacunas de dosis Doble. Pero 
no des por sabido que hay Simple y Doble, podría haber Triple, Cuádruple
````
for $tipodosis in distinct-values(data(//precio/@dosis))
let $preciomedio := avg(//precio[@dosis = $tipodosis])
return 
<resultado>
	<tipodosis>{$tipodosis}</tipodosis>
	<preciomedio>{$preciomedio}</preciomedio>
</resultado>
````


# 4)Inserta en cada nodo de vacuna cuál es la media de edad de los paciente vacunados con la misma
````
for $vacuna in /vacunacion/vacuna
let $media := avg(/pacientes/paciente[vacuna = $vacuna/@id]/edad)
return 
update insert  <edadmedia>{$media}</edadmedia> into $vacuna
````
# 5)Elimina todas las vacunas cuya fecha de fin llega al año 2022
````
for $vacuna in /vacunacion/vacuna
let $ano := substring($vacuna/fin, 1,4)
return
if (number($ano) = 2022) then
	update delete $vacuna
else
	"Vacuna apta"
````
# 6)Listado de ciudad y todas los nombres de vacunas suministradas en esa ciudad
````
for $ciudad in distinct-values(//ciudad)
return <resultado>{$ciudad}
{
for $vacuna in distinct-values(//paciente[ciudad = $ciudad]/vacuna)
let $nombrevac := /vacunacion/vacuna[@id = $vacuna]/nombre
return data($nombrevac)
}
</resultado>
````

# 7)Listado en formato HTML con identificador de paciente, nombre, y responsable vacuna inyectada
````
<HTML>
	<BODY>
		<table border = "1">
			<tr><td>Paciente</td><td>Nombre</td><td>Responsable</td></tr>
			{
			for $paciente in //paciente
			let $identificadorpac := data($paciente/@id)
			let $nombre := $paciente/nombre
			let $responsable := /vacunacion/vacuna[@id = $paciente/vacuna]/responsable
			return
			<tr><td>{$identificadorpac}</td><td>{$nombre}</td><td>{$responsable}</td></tr>
			}			
		</table>
	</BODY>
</HTML>	
````