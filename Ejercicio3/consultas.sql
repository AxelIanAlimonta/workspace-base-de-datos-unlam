use Ejercicio3

--1. Indique la cantidad de productos que tiene la empresa
select count(*)cant_prod
from Producto

--2. Indique la cantidad de productos en estado 'en stock' que tiene la empresa.
select count(*)cant_prod
from Producto
where Estado like 'stock'

--3. Indique los productos que nunca fueron vendidos
select Id_producto
from Producto
except
select Id_producto
from Detalle_venta

--4. Indique la cantidad de unidades que fueron vendidas de cada producto.
select Id_producto,SUM(Cantidad)cant_vendida
from Detalle_venta
group by Id_producto

--5. Indique cual es la cantidad promedio de unidades vendidas de cada producto
select Id_producto,AVG(Cantidad)
from Detalle_venta
group by Id_producto

--6. Indique quien es el vendedor con mas ventas realizadas
select Id_vendedor,COUNT(Nro_factura)cant_de_ventas
from Venta
group by Id_vendedor

--7. Indique todos los productos de lo que se hayan vendido más de 15 unidades y menos de 55.
select Id_producto,SUM(Cantidad)cantidad_vendida
from Detalle_venta
group by Id_producto
having sum(Cantidad) between 15 and 55

--8. Indique quien es el vendedor con mayor volumen de ventas.
declare @maximo int
select @maximo = max(cantTotal)
from(
	select SUM(dv.Cantidad)cantTotal
	from Detalle_venta dv
	join Venta v on(v.Nro_factura=dv.Nro_factura)
	group by v.Id_vendedor
)x


select ve.Id_vendedor,SUM(dv.Cantidad)
from Detalle_venta dv
join Venta v on(v.Nro_factura=dv.Nro_factura)
join Vendedor ve on(ve.Id_vendedor=v.Id_vendedor)
group by ve.Id_vendedor
having SUM(dv.Cantidad) = @maximo
