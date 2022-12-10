--1. Hallar el código (nroProv) de los proveedores que proveen el artículo 1.

select distinct NroProv
from Pedido
where NroArt = 1

--2. Hallar los clientes (nomCli) que solicitan artículos provistos por el proveedor nro 3.

select distinct NroCli
from Pedido
where NroProv = 3

--3. Hallar los clientes que solicitan algún item provisto por proveedores con categoría mayor que 4.
select distinct a.NroCli
from Pedido a
join Proveedor b on(a.NroProv=b.NroProv)
where b.Categoria>4

--4. Hallar los pedidos en los que un cliente de Merlo solicita artículos producidos en la ciudad de Merlo
select *
from Pedido pe
join Articulo ar on(ar.NroArt=pe.NroArt)
join Cliente cl on(cl.NroCli=pe.NroCli)
where cl.CiudadCli like '%Merlo%'
and ar.CiudadArt like '%Merlo%'


--5. Hallar los pedidos en los que el cliente 1 solicita artículos solicitados por el cliente 2.
select *
from Pedido p
where p.NroCli=1 
and p.NroArt in(
	select p2.NroArt
	from Pedido p2
	where p2.NroCli =2
)

--6. Hallar los proveedores que suministran todos los artículos cuyo precio es superior al precio promedio de los artículos que se producen en Merlo.
create view nroProvYArtPrecioMayorAlPromDeMerlo as(
select p.NroProv,a.NroArt
from Pedido p 
join Articulo a on(p.NroArt=a.NroArt)
where a.Precio > all(
	select AVG(a.Precio)
	from Articulo a
	where CiudadArt like '%Merlo%'
)
group by p.NroProv,a.NroArt
)

select NroProv
from nroProvYArtPrecioMayorAlPromDeMerlo
group by NroProv
having COUNT(NroArt) in(
	select  COUNT(*)
	from Articulo a2
	where a2.Precio > all(
		select AVG(a.Precio)
		from Articulo a
		where CiudadArt like '%Merlo%'
	)
)

--7. Hallar la cantidad de artículos diferentes provistos por cada proveedor que provee a todos los clientes de Merlo.
create view proveedoresQueProveenATodosLosClientesDeMerlo as(
select *
from Proveedor p
where not exists(
	select 1
	from Cliente c
	where c.CiudadCli like '%merlo%'
	and not exists(
		select 1
		from Pedido pe
		where pe.NroProv=p.NroProv
		and c.NroCli=pe.NroCli
	)
)
)

select count(distinct pe.NroArt)
from proveedoresQueProveenATodosLosClientesDeMerlo pr
join Pedido pe on(pr.NroProv=pe.NroProv)

--8. Hallar los nombres de los proveedores cuya categoría sea mayor o igual que la de todos los proveedores que proveen el artículo “Articulo 1”.

select *
from Proveedor prov
where prov.Categoria>=all(
	select pr.Categoria
	from Pedido P
	join Articulo a on(p.NroArt=a.NroArt)
	join Proveedor pr on(pr.NroProv=p.NroProv)
	where a.Descripcion like '_Articulo 1_'
)

--9. Hallar los proveedores que han provisto más de 100 unidades entre los artículos  1 y 2.

select p.NroProv,sum(p.Cantidad) cant
from Pedido p
where p.NroArt=1 or p.NroArt=2
group by p.NroProv
having sum(p.Cantidad)>100

--10. Listar la cantidad y el precio total de cada artículo que han pedido los Clientes a
--sus proveedores entre las fechas 01-11-2022 y 31-12-2022 (se requiere visualizar
--Cliente, Articulo, Proveedor, Cantidad y Precio).

create view comprasClienteACadaProvDesde1NovHasta31dic as(
select p.NroCli,p.NroArt,p.NroProv,p.Cantidad
from Pedido p
where p.FechaPedido between '2022-11-1' and '2022-12-31'
group by p.NroCli,p.NroArt,p.NroProv,p.Cantidad
 )

 select c.NroArt,c.NroArt,c.NroProv,c.Cantidad,(c.Cantidad*a.Precio)precioTotal
 from comprasClienteACadaProvDesde1NovHasta31dic c
 join Articulo a on(a.NroArt=c.NroArt)

-- 11. Idem anterior y que además la Cantidad sea mayor o igual a 20 o el Precio sea
--mayor a $ 1000.

select c.NroArt,c.NroArt,c.NroProv,c.Cantidad,(c.Cantidad*a.Precio)precioTotal
 from comprasClienteACadaProvDesde1NovHasta31dic c
 join Articulo a on(a.NroArt=c.NroArt)
 where c.Cantidad>20 and (c.Cantidad*a.Precio)>1000

 --12. Listar la descripción de los artículos en donde se hayan pedido en el día más del
-- stock existente para ese mismo día.

select p.NroArt,a.Descripcion,p.FechaPedido,SUM(p.Cantidad)cantPed,s.cantidad cantStock
from Pedido p
join  Stock s on(s.NroArt=p.NroArt and s.Fecha=p.FechaPedido)
join Articulo a on(a.NroArt=p.NroArt)
group by p.NroArt,p.FechaPedido,s.cantidad,a.Descripcion
having SUM(p.Cantidad)>s.cantidad

--13. Listar los datos de los proveedores que hayan pedido de todos los artículos en un
--mismo día. Verificar sólo en el último mes de pedidos.

create view g_provArtFech_Pedido as(
select distinct pe.NroProv,pe.NroArt,pe.FechaPedido
from Pedido pe
group by pe.NroProv,pe.NroArt,pe.FechaPedido
)

select NroProv,FechaPedido,count(NroArt) cantidadDeArticulos
from g_provArtFech_Pedido
group by NroProv,FechaPedido
having count(NroArt) in (
	select COUNT(*)
	from Articulo
)

--14. Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el
--último mes, pero sí se les haya pedido en el mismo mes del año anterior.

(select NroProv
from Pedido
except
select NroProv
from Pedido
where FechaPedido in(
	select MAX(p.FechaPedido)
	from Pedido p
))
intersect 
select NroProv
from Pedido
where FechaPedido in (
	select MAX(DATEADD(YEAR,-1,p.FechaPedido))
	from Pedido p
)

--15. Listar los nombres de los clientes que hayan solicitado más de un artículo diferente cuyo
--precio sea superior a $50 y que correspondan a proveedores de Suiza.
--Por ejemplo, se considerará si se ha solicitado el artículo a2 y a3, pero no si
--solicitaron 5 unidades del articulo a2.

select cl.NomCli,COUNT(distinct ar.NroArt) cant_articulos
from Pedido pe
join Proveedor pr on(pr.NroProv=pe.NroProv)
join Articulo ar on(ar.NroArt=pe.NroArt)
join Cliente cl on(cl.NroCli=pe.NroCli)
where ar.Precio>50
and pr.CiudadProv like '%Suiza%'
group by cl.NroCli,cl.NomCli
having COUNT(distinct ar.NroArt)>=2

