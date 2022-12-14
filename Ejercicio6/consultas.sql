use Ejercicio6

--1. Hallar los números de vuelo desde el origen A hasta el destino B.
select *
from Vuelo
where Desde like 'a' and Hasta like'b'

--2. Hallar los tipos de avión que no son utilizados en ningún vuelo que pase por B.
select a.TipoAvion
from Vuelo v
join Avion_utilizado a on(a.NroVuelo=v.NroVuelo)
where Desde not like 'b' and Hasta not like 'b'

--3. Hallar los pasajeros y números de vuelo para aquellos pasajeros que viajan desde D a F pasando por E.

select *
from Vuelo a
join Vuelo b on(a.Hasta=b.Desde)
where a.Desde like 'd'
and a.Hasta like 'e'
and b.Hasta like 'f'

--4. Hallar los tipos de avión que pasan por A.

select distinct a.TipoAvion
from Avion_utilizado a
join Vuelo v on(v.NroVuelo=a.NroVuelo)
where v.Desde like 'a'
or v.Hasta like 'a'

--5. Hallar por cada Avión la cantidad de vuelos distintos en que se encuentra registrado.

select NroAvion,COUNT(NroAvion)cantVuelos
from Vuelo v
join Avion_utilizado a on(a.NroVuelo=v.NroVuelo)
group by NroAvion

--6. Listar los distintos tipo y nro. de avión que tienen a c como destino.

select a.TipoAvion,a.NroAvion
from Vuelo v
join Avion_utilizado a on(a.NroVuelo=v.NroVuelo)
where v.Hasta like 'c'

--7. Hallar los pasajeros que han volado más frecuentemente en el último año.
declare @ultAnio int
set @ultAnio = (
	select MAX(YEAR(Fecha))
	from Vuelo
)

select i.Documento,COUNT(i.Documento)cantVuelos
from Vuelo v
join Info_pasajeros i on(i.NroVuelo=v.NroVuelo)
where YEAR(Fecha)=@ultAnio
group by i.Documento

--8. Hallar los pasajeros que han volado la mayor cantidad de veces posible en un B-777.

select *
from Info_pasajeros i
where not exists(
	select 1
	from Avion_utilizado a
	where a.TipoAvion like 'b-777'
	and not exists(
		select 1
		from Vuelo v
		where v.NroVuelo=i.NroVuelo
		and v.NroVuelo=a.NroVuelo
	)
)

--9. Hallar los aviones que han transportado más veces al pasajero más antiguo.

declare @fechMasAntigua date
set @fechMasAntigua = (
	select MIN(Fecha)
	from Vuelo
)

select Documento,NroAvion,COUNT(v.NroVuelo)cantidad_de_viajes
from info_pasajeros p
join Avion_utilizado a on(a.NroVuelo=p.NroVuelo)
join Vuelo v on(v.NroVuelo=p.NroVuelo)
where Fecha=@fechMasAntigua
group by Documento,NroAvion
having COUNT(v.NroVuelo) =(
	select MAX(x.a)
	from(
	select COUNT(NroAvion)a
	from info_pasajeros p
	join Avion_utilizado a on(a.NroVuelo=p.NroVuelo)
	join Vuelo v on(v.NroVuelo=p.NroVuelo)
	where Fecha=@fechMasAntigua
	group by Documento,NroAvion
	)x
)


--10. Listar la cantidad promedio de pasajeros transportados por los aviones de la compañía, por tipo de avión.

select x.TipoAvion,AVG(cast(cant as float)) prom
from(
	select TipoAvion,a.NroVuelo,count(Documento)cant
	from Info_pasajeros p
	join Avion_utilizado a on(a.NroVuelo=p.NroVuelo)
	group by TipoAvion,a.NroVuelo
)x
group by x.TipoAvion

--11. Hallar los pasajeros que han realizado una cantidad de vuelos dentro del 10% en más o en menos del promedio de vuelos de todos los pasajeros de la compañía.

declare @promVuelPas float
set @promVuelPas=(
	select AVG(x.cant)
	from(
		select p.Documento,COUNT(p.NroVuelo)cant
		from Vuelo v
		join Info_pasajeros p on(v.NroVuelo=p.NroVuelo)
		group by p.Documento
	)x
)

select p.Documento,COUNT(p.NroVuelo)cant
from Vuelo v
join Info_pasajeros p on(v.NroVuelo=p.NroVuelo)
group by p.Documento
having count(p.NroVuelo) between @promVuelPas*0.9 and @promVuelPas*1.1