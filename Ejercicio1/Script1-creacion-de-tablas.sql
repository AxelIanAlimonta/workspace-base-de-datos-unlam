use Ejercicio1

create table Almacen(
	Nro int not null,
	Responsable varchar(30),
	constraint pk_almacen primary key(nro)
)

create table Articulo(
	CodArt int not null,
	Descripción varchar(30) not null,
	Precio money,
	constraint pk_articulo primary key(CodArt)
)

create table Material(
	CodMat int not null,
	Descripcion varchar(30),
	constraint pk_material primary key(CodMat)
)


create table Proveedor (
	CodProv int not null,
	Nombre varchar(30),
	Domicilio varchar(30),
	Ciudad varchar(30),
	constraint pk_proveedor primary key(CodProv)
)

create table Tiene(
	Nro int not null,
	CodArt int not null,
	constraint pk_tiene primary key(Nro,CodArt),
	constraint fk_tiene_almacen foreign key(Nro) references Almacen(Nro),
	constraint fk_tiene_articulo foreign key(CodArt) references Articulo(CodArt)
)


create table Compuesto_por(
	CodArt int not null,
	CodMat int not null,
	constraint pk_compuesto_por primary key(CodArt,CodMat),
	constraint fk_compuesto_articulo foreign key(CodArt) references Articulo(CodArt),
	constraint fk_compuesto_material foreign key(CodMat) references Material(CodMat)
)

create table Provisto_por(
	CodMat int not null,
	CodProv int not null,
	constraint pk_provisto_por primary key(CodMat,CodProv),
	constraint fk_provisto_material foreign key(CodMat) references Material(CodMat),
	constraint fk_provisto_proveedor foreign key(CodProv) references Proveedor(CodProv),
)

