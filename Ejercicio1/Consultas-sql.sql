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