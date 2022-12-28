use ejercicio12




--1. p_EliminaSinstock(): Realizar un procedimiento que elimine los productos que no poseen stock.

create proc p_EliminaSinStock
as
begin
	delete from Producto
	where StockActual=0
end

--2. p_ActualizaStock(): Para los casos que se presenten inconvenientes en los
--datos, se necesita realizar un procedimiento que permita actualizar todos los
--Stock_Actual de los productos, tomando los datos de la entidad Stock. Para ello,
--se utilizará como stock válido la última fecha en la cual se haya cargado el stock.


create function f_StockProdUltFecha()
returns table
as
	return(
	select s.CodProd,Cantidad
	from Stock s
	join
	(select CodProd,max(Fecha) ultFech
	from Stock
	group by CodProd)x on(s.CodProd=x.CodProd and s.Fecha=x.ultFech)
	)

create proc p_ActualizarStock_2
as
begin
	update Producto
	set Producto.StockActual=a.Cantidad
	from Producto p 
	join f_StockProdUltFecha()a
	on(p.CodProd=a.CodProd)
end


--3. p_DepuraProveedor(): Realizar un procedimiento que permita depurar todos los
--proveedores de los cuales no se posea stock de ningún producto provisto desde
--hace más de 1 año.



create view v_ProvFech_UltFechaEnProveer as(
	select p.CodProv,MAX(Fecha)UltFech
	from Stock s
	join Producto p on(s.CodProd=p.CodProd)
	group by p.CodProv
)

create proc p_DepuraProveedor
as
begin
	declare @fechActual date
	set @fechActual = GETDATE()

	delete 
	from Proveedor
	where CodProv in(
		select p.CodProv
		from Proveedor p
		left join v_ProvFech_UltFechaEnProveer v on(p.CodProv=v.CodProv)
		where v.UltFech is null
		or datediff(year,v.UltFech,@fechActual)>2
	)
end


--4. p_InsertStock(nro,fecha,prod,cantidad): Realizar un procedimiento que permita
--agregar stocks de productos. Al realizar la inserción se deberá validar que:
--a. El producto debe ser un producto existente
--b. La cantidad de stock del producto debe ser cualquier número entero
--mayor a cero.
--c. El número de stock será un valor correlativo que se irá agregando por
--cada nuevo stock de producto.

declare @num int
set @num = (
	select distinct MAX(nro)
	from Stock
)

declare @fechaActual date
set @fechaActual = GETDATE()


create proc p_InsertStock(@nro int out,@fecha date,@prod int,@cantidad int)
as
begin
	if (exists(select * from Producto where CodProd=@prod) and @cantidad>0)
	begin
		set @nro=@nro+1
		insert into Stock values(@nro,@fecha,@prod,@cantidad)
	end
end

--5. tg_CrearStock: Realizar un trigger que permita automáticamente agregar un
--registro en la entidad Stock, cada vez que se inserte un nuevo producto. El stock
--inicial a tomar, será el valor del campo Stock_Actual.

create trigger tg_CrearStock
on Producto for insert
as
begin
	declare @nro int
	set @nro = (
		select MAX(Nro)+1
		from Stock
	)
	declare @codProd int
	set @codProd = (
		select inserted.CodProd
		from inserted
	)
	declare @stockActual int
	set @stockActual = (
		select inserted.StockActual
		from inserted
	)
	insert into Stock values(@nro,GETDATE(),@codProd,@stockActual)
end

--6. p_ListaSinStock(): Crear un procedimiento que permita listar los productos que
--no posean stock en este momento y que no haya ingresado ninguno en este
--último mes. De estos productos, listar el código y nombre del producto, razón
--social del proveedor y stock que se tenía al mes anterior.

create proc p_ListaSinStock
as
begin
	declare @fechActual date
	set @fechActual = GETDATE()
	
	select p.CodProd,p.Descripcion,pr.RazonSocial,isnull(stockMesAnterior.Cantidad,0)cant_mes_anterior
	from Producto p
	join Stock s on(p.CodProd=s.CodProd)
	join Proveedor pr on(pr.CodProv=p.CodProv)
	left join (
		select CodProd,Cantidad
		from Stock
		where Fecha = DATEADD(MONTH,-1,@fechActual)
	)stockMesAnterior on (stockMesAnterior.CodProd=p.CodProd)
	where p.StockActual = 0
end

--p_ListaStock(): Realizar un procedimiento que permita generar el siguiente
--reporte:
--En este listado se observa que se contará la cantidad de productos que posean a una
--determinada fecha más de 1000 unidades, menos de 1000 unidades o que no
--existan unidades de ese producto.
--Según el ejemplo, el 01/08/2009 existen 100 productos que poseen más de 1000
--unidades, en cambio el 03/08/2009 sólo hubo 53 productos con más de 1000
--unidades.

drop view CantidadProdEnStockMenorIgual1000AgrupadoPorFecha as(
	select Fecha,0 c1,count(distinct CodProd)c2,0 c3
	from Stock
	where Cantidad between 1 and 1000
	group by Fecha
)

drop view cantProdEnStockMayor1000AgrupadosPorFecha as(
	select Fecha,COUNT(distinct CodProd)c1,0 c2,0 c3
	from Stock
	where Cantidad > 1000
	group by Fecha
)

drop view cantDeProdEnStockIgualCeroAgrupadosPorFecha as(
	select Fecha,0 c1,0 c2,count(distinct CodProd)c3
	from Stock
	where Cantidad=0
	group by Fecha
)


create proc p_listaStock
as
begin
	select Fecha,sum(c1)mayor_a_mil,SUM(c2)menor_a_1000,SUM(c3)iguan_a_cero
	from
		(select Fecha,COUNT(distinct CodProd)c1,0 c2,0 c3
		from Stock mayor_a_mil
		where Cantidad > 1000
		group by Fecha
		union
		select Fecha,0 c1,count(distinct CodProd)c2,0 c3
		from Stock menor_a_mil
		where Cantidad between 1 and 1000
		group by Fecha
		union
		select Fecha,0 c1,0 c2,count(distinct CodProd)c3
		from Stock igual_a_cero
		where Cantidad=0
		group by Fecha
	)x
	group by Fecha

end

exec p_listaStock

--El siguiente requerimiento consiste en actualizar el campo stock actual de la
--entidad producto, cada vez que se altere una cantidad (positiva o negativa) de ese
--producto. El stock actual reflejará el stock que exista del producto, sabiendo que
--en la entidad Stock se almacenará la cantidad que ingrese o egrese. Además, se
--debe impedir que el campo “Stock actual” pueda ser actualizado manualmente. Si
--esto sucede, se deberá dar marcha atrás a la operación indicando que no está
--permitido.

create trigger tg_actualizarStockActual on Stock for insert as
begin
	declare @valor int
	set @valor = (
		select inserted.Cantidad
		from inserted
	)

	declare @codProd int
	set @codProd = (
		select inserted.CodProd
		from inserted
	)
	
	update Producto
	set StockActual= (StockActual+@valor)
	where CodProd=@codProd
end

