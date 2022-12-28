use ejercicio12

drop table if exists Stock
drop table if exists Producto
drop table if exists Proveedor

create table Proveedor(
	CodProv int,
	RazonSocial nvarchar(50),
	FechaInicio date,
	constraint pk_proveedor primary key(CodProv)
)


create table Producto(
	CodProd int,
	Descripcion nvarchar(50),
	CodProv int,
	StockActual int,
	constraint pk_producto primary key(codprod),
	constraint fk_producto_proveedor foreign key(CodProv) references Proveedor(CodProv)
)


create table Stock(
	Nro int,
	Fecha date,
	CodProd int,
	Cantidad int,
	constraint pk_stock primary key(Nro,fecha,CodProd),
	constraint fk_stock_producto foreign key(Codprod) references Producto(CodProd)
)

