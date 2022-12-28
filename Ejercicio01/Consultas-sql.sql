use Ejercicio1


--1. Listar los nombres de los proveedores de la ciudad de La Plata.
select Nombre
from Proveedor
where Ciudad like 'La Plata'

--2. Listar los n�meros de art�culos cuyo precio sea inferior a $10.

select distinct Descripci�n
from Articulo
where Precio < 10

--3. Listar los responsables de los almacenes.

select Responsable
from Almacen

--4. Listar los c�digos de los materiales que provea el proveedor 10 y no los provea el proveedor 15.
select CodMat
from Provisto_por
where CodProv = 10
except
select CodMat
from Provisto_por
where CodProv=15

--5. Listar los n�meros de almacenes que almacenan el art�culo 1.
select Nro
from Tiene
where CodArt=1

--6. Listar los proveedores de La Plata que se llamen 'Proveedor 01'.
select *
from Proveedor
where Ciudad like 'La Plata' and Nombre like 'Proveedor 01'

--7. Listar los almacenes que contienen los art�culos 2 y los art�culos 14 (ambos).
select Nro
from Tiene
where CodArt = 2
intersect
select Nro
from Tiene
where CodArt = 14

--8. Listar los art�culos que cuesten m�s de $20 o que est�n compuestos por el material 1.
select *
from Articulo a
join Compuesto_por c on(a.CodArt=c.CodArt)
where a.Precio>20 and c.CodMat=1

--9. Listar los materiales, c�digo y descripci�n, provistos por proveedores de la ciudad de 'Merlo'.
select distinct m.CodMat,m.Descripcion
from Material m
join Provisto_por pp on(m.CodMat=pp.CodMat)
join Proveedor p on(p.CodProv=pp.CodProv)
where p.Ciudad like 'merlo'

--10. Listar el c�digo, descripci�n y precio de los art�culos que se almacenan en el almacen nro 1.
select a.Descripci�n,a.Precio
from Tiene t
join Articulo a on(a.CodArt=t.CodArt)
where t.Nro = 1


--11. Listar la descripci�n de los materiales que componen el art�culo 4.
select m.Descripcion
from Articulo a
join Compuesto_por cp on(a.CodArt=cp.CodArt)
join Material m on(m.CodMat=cp.CodMat)
where a.CodArt=4

--12. Listar los nombres de los proveedores que proveen los materiales al almac�n que 'Responsable 01' tiene a su cargo.
select distinct pr.Nombre
from Almacen al
join Tiene ti on(al.Nro=ti.Nro)
join Material ma on(ma.CodMat=ti.CodArt)
join Provisto_por pp on(pp.CodMat=ma.CodMat)
join Proveedor pr on(pp.CodProv=pr.CodProv)
where al.Responsable like 'Responsable 01'


--13. Listar c�digos y descripciones de los art�culos compuestos por al menos un material provisto por 'Proveedor 04'.
select distinct ar.CodArt,ar.Descripci�n
from Articulo ar
join Compuesto_por cp on(ar.CodArt=cp.CodArt)
join Provisto_por pp on(pp.CodMat=cp.CodMat)
join Proveedor pr on(pr.CodProv=pp.CodProv)
where pr.Nombre like'Proveedor 04'

--14. Hallar los c�digos y nombres de los proveedores que proveen al menos un material que se usa en alg�n art�culo cuyo precio es mayor a $30.
select distinct pr.CodProv,pr.Nombre
from Proveedor pr
join Provisto_por pp on(pp.CodProv=pr.CodProv)
join Compuesto_por cp on(cp.CodMat=pp.CodMat)
join Articulo ar on(ar.CodArt=cp.CodMat)
where ar.Precio>30

--15. Listar los n�meros de almacenes que tienen todos los art�culos que incluyen el material con c�digo 3.
select ti.Nro
from Tiene ti
join Articulo ar on(ar.CodArt=ti.CodArt)
join Compuesto_por cp on(cp.CodArt=ar.CodArt)
where cp.CodMat = 2
group by ti.Nro
having count(CodMat) in
(
	select COUNT(CodArt)
	from Compuesto_por
	where CodMat=2
)

--16. Listar los proveedores que sean �nicos proveedores de alg�n material.

select *
from Provisto_por a
where a.CodMat <> all(
	select b.CodMat
	from Provisto_por b
	where b.CodProv<>a.CodProv
)

--17. Listar el/los art�culo/s de mayor precio
select *
from Articulo a
where a.Precio in(
	select max(b.Precio)
	from Articulo b
)

--18. Listar el/los art�culo/s de menor precio
select *
from Articulo a
where a.Precio in(
	select MIN(b.Precio)
	from Articulo b
)

--19. Listar el promedio de precios de los art�culos en cada almac�n.
select ti.Nro,ROUND(SUM(ar.Precio)/COUNT(ar.Precio),2) prom
from Articulo ar
join Tiene ti on(ar.CodArt=ti.CodArt)
group by ti.Nro

--20. Listar los almacenes que almacenan la mayor cantidad de art�culos.
create view cantidadArtPorAlmacen as(
	select Nro,COUNT(CodArt) cant
	from Tiene
	group by Nro
)

select nro
from cantidadArtPorAlmacen a
where cant in (
	select MAX(b.cant)
	from cantidadArtPorAlmacen b
)

--21. Listar los art�culos compuestos por al menos 5 materiales.
select CodArt,COUNT(CodArt)cant
from Compuesto_por
group by CodArt
having COUNT(CodArt)>=5

--22. Listar los art�culos compuestos por exactamente 5 materiales.
select CodArt,COUNT(CodMat)cant
from Compuesto_por
group by CodArt
having COUNT(CodMat)=5

--23. Listar los art�culos que est�n compuestos con hasta 2 materiales.
select CodArt,COUNT(CodMat)cant
from Compuesto_por
group by CodArt
having COUNT(CodMat)<=2

--24. Listar los art�culos compuestos por todos los materiales.
select CodArt,COUNT(CodMat)cant
from Compuesto_por
group by CodArt
having COUNT(CodMat) in (
	select COUNT(*)
	from Material
)


--25. Listar las ciudades donde existan proveedores que provean todos los materiales.
select pr.Ciudad
from Provisto_por pp
join Proveedor pr on(pr.CodProv=pp.CodProv)
group by pr.CodProv,pr.Ciudad
having COUNT(pp.CodMat)in(
	select COUNT(*)
	from Material
)

