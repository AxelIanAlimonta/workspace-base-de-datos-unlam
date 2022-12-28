use Ejercicio7

--1. Indique cuales son los autos con mayor cantidad de kilómetros realizados en el último mes.

declare @ultMes date
set @ultMes = (
	select max(FechaHoraInicio)
	from viaje
)

declare @maxKMrealizUltMes float
set @maxKMrealizUltMes =(
select MAX(k)
from(
	select auto,SUM(kmTotales)k
	from viaje
	where convert(date,FechaHoraFin)=@ultMes
	group by auto
	)x
)


select auto,SUM(kmTotales)k
from viaje
where convert(date,FechaHoraFin)=@ultMes
group by auto
having SUM(kmTotales)=@maxKMrealizUltMes

--2. Indique los clientes que más viajes hayan realizado con el mismo chofer.

declare @maxCantViajCliMismChof int
set @maxCantViajCliMismChof = (
	select MAX(cant)
	from
		(select chofer,cliente,count(chofer)cant
		from viaje
		group by chofer,cliente)x
)

select chofer,cliente,count(chofer)cant
from viaje
group by chofer,cliente
having COUNT(chofer)=@maxCantViajCliMismChof

--3. Indique el o los clientes con mayor cantidad de viajes en este año.

declare @maxCantViajCli int
set @maxCantViajCli =(
	select MAX(cant)
	from(
		select COUNT(*)cant
		from viaje
		group by cliente
	)x
)

select cliente,count(*)cant_viajes
from viaje
group by cliente
having count(*)=@maxCantViajCli

--4. Obtenga nombre y apellido de los choferes que no manejaron todos los vehículos que disponemos.

declare @cantVehiculos int
set @cantVehiculos =(
	select COUNT(*)
	from auto
)

select nroLicencia,nombre,apellido,COUNT(distinct auto) cant_manejada
from chofer c
join viaje v on(c.nroLicencia=v.chofer)
group by nroLicencia,nombre,apellido
having COUNT(distinct auto)<>@cantVehiculos

--5. Obtenga el nombre y apellido de los clientes que hayan viajado en todos nuestros autos.

select *
from Cliente c
where  not exists (
	select 1
	from auto a
	where not exists(
		select 1
		from viaje v
		where c.nroCliente=v.cliente
		and v.auto=a.matricula
	)
)

--6. Queremos conocer el tiempo de espera promedio de los viajes de los últimos 2 meses
declare @fUltViaje date
set @fUltViaje = (
	select MAX(FechaHoraInicio)
	from viaje
)
declare @fUltViajeMenosUnMes date
set @fUltViajeMenosUnMes = DATEADD(MONTH,-1,@fUltViaje)

select cast(cast(avg(cast(CAST(esperaTotal as datetime) as float)) as datetime) as time)
from viaje
where (MONTH(FechaHoraInicio)=MONTH(@fUltViaje) and YEAR(FechaHoraInicio)=YEAR(@fUltViaje))
or (MONTH(FechaHoraInicio)=MONTH(@fUltViajeMenosUnMes) and YEAR(FechaHoraInicio)=YEAR(@fUltViajeMenosUnMes))

--7. Indique los kilómetros realizados en viajes por cada auto.

select auto,SUM(kmTotales)km_realizados
from viaje
group by auto

--8. Indique el costo promedio de los viajes realizados por cada auto.

select auto,AVG(costoKms)costo_prom
from viaje
group by auto


--9. Indique el costo total de los viajes realizados por cada chofer en el último mes.
declare @fUltViaje date
set @fUltViaje = (
	select MAX(FechaHoraInicio)
	from viaje
)
select auto,sum(costoKms)costo_total_ult_mes
from viaje
where MONTH(FechaHoraInicio)=MONTH(@fUltViaje)and year(FechaHoraInicio)=YEAR(@fUltViaje)
group by auto

--10. Indique la fecha inicial, el chofer y el cliente que hayan realizado el viaje más largo de este año.

declare @añoActual int
set @añoActual = year(GETDATE())

select FechaHoraInicio,chofer,cliente,kmTotales
from viaje
where kmTotales =(
	select MAX(kmTotales)
	from viaje
	where year(FechaHoraInicio)=@añoActual
)
and YEAR(FechaHoraInicio)=@añoActual
