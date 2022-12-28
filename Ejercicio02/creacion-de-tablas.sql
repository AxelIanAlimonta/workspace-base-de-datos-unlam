use Ejercicio2

create table Proveedor(
	NroProv int not null,
	NomProv varchar(50),
	Categoria int,
	CiudadProv varchar(50)
	constraint pk_proveedor primary key(NroProv)
)

create table Articulo(
	NroArt int not null,
	Descripcion varchar(50),
	CiudadArt varchar(50),
	Precio money,
	constraint pk_articulo primary key(NroArt)
)

create table Cliente(
	NroCli int not null,
	NomCli varchar(50),
	CiudadCli varchar(50),
	constraint pk_cliente primary key(NroCli)
)

create table Pedido(
	NroPed int not null,
	NroArt int not null,
	NroCli int not null,
	NroProv int not null,
	FechaPedido date,
	Cantidad int,
	constraint pk_pedido primary key(NroPed),
	constraint fk_pedido_nroart foreign key (NroArt) references Articulo(NroArt),
	constraint fk_pedido_nrocli foreign key (NroCli) references Cliente(NroCli),
	constraint fk_pedido_nroprov foreign key (NroProv) references Proveedor(NroProv)
	)

create table Stock(
	NroArt int not null,
	Fecha date not null,
	cantidad int,
	constraint fk_stock_nroart foreign key(NroArt) references Articulo(NroArt),
	constraint pk_stock primary key(NroArt,Fecha)
)