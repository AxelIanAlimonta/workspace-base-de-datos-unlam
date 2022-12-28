use Ejercicio5

--1. Listar los clientes que no hayan reportado préstamos del rubro “Terror”.
select Cod_Cli
from Cliente
except
select pr.CodCli
from Prestamo pr
join Pelicula pe on(pe.CodPel=pr.CodPel)
join Rubro r on(pe.CodRubro=r.CodRubro)
where r.NombRubro like '%Terror%'


--2. Listar las películas de mayor duración que alguna vez fueron prestadas.

declare @maxDur time
set @maxDur = (
	select max(duracion)
	from Pelicula
)

select *
from Prestamo pr
join Pelicula pe on(pr.CodPel=pe.CodPel)
where pe.duracion = @maxDur

--3. Listar los clientes que tienen más de un préstamo sobre la misma película (listar
--Cliente, Película y cantidad de préstamos).

select c.Cod_Cli,p.CodPel,COUNT(*)cantidad_de_prestamos
from Cliente c
join Prestamo p on(p.CodCli=c.Cod_Cli)
group by c.Cod_Cli,p.CodPel
having COUNT(*)>1

--4. Listar los clientes que han realizado préstamos del título “Robocop” y “Terminator” (Ambos).

select pr.CodCli
from Prestamo pr
join Pelicula pe on(pe.CodPel=pr.CodPel)
where pe.titulo like 'robocop'
intersect
select pr.CodCli
from Prestamo pr
join Pelicula pe on(pe.CodPel=pr.CodPel)
where pe.titulo like 'Terminator'

--5. Listar las películas más vistas en cada mes (Mes, Película, Cantidad de Alquileres).
select MONTH(pr.FechaPrest)mes,pe.CodPel,pe.titulo,count(*)cantidad
from Prestamo pr
join Pelicula pe on(pe.CodPel=pr.CodPel)
group by MONTH(pr.FechaPrest),pe.CodPel,pe.titulo

--6. Listar los clientes que hayan alquilado todas las películas del video.

select *
from Cliente cl
where not exists(
	select 1
	from Pelicula pe
	where not exists(
		select 1
		from Prestamo pr
		where pr.CodCli=cl.Cod_Cli and pr.CodPel=pe.CodPel
	)
)

--7. Listar las películas que no han registrado ningún préstamo a la fecha.

select p.CodPel
from Pelicula p
except 
select pr.CodPel
from Prestamo pr

--8. Listar los clientes que no han efectuado la devolución de ejemplares.

	select pr.CodCli,pr.CodEj,max(pr.FechaDev)fecha_de_devolucion
	from Prestamo pr
	join Ejemplar ej on(ej.CodEj=pr.CodEj)
	join(
		select pr.CodEj,max(pr.FechaDev)fecha_de_devolucion
		from Prestamo pr
		join Ejemplar ej on(ej.CodEj=pr.CodEj)
		where ej.Estado like 'ocupado'
		group by pr.CodEj
	)x on(x.CodEj=pr.CodEj and x.fecha_de_devolucion=pr.FechaDev)
	where ej.Estado like 'ocupado'
	group by CodCli,pr.CodEj

	

--9. Listar los títulos de las películas que tienen la mayor cantidad de préstamos.
declare @cantMaxPrest int
set @cantMaxPrest = (
	select MAX(a)
	from(
		select COUNT(*)a
		from Prestamo
		group by CodPel
		)x
)

select pe.CodPel,pe.titulo,count(pe.CodPel)cantPrestamos
from Prestamo pr
join Pelicula pe on(pe.CodPel=pr.CodPel)
group by pe.CodPel,pe.titulo
having COUNT(pe.CodPel) = @cantMaxPrest

--10. Listar las películas que tienen todos los ejemplares prestados.

select CodPel,COUNT(CodPel)cant_ejemplares_prestados
from Ejemplar
where Estado like 'ocupado'
group by CodPel
intersect 
select CodPel,COUNT(CodPel)
from Ejemplar
group by CodPel