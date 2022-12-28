use ejercicio5
go

create table Rubro(
	CodRubro int,
	NombRubro varchar(50),
	constraint pk_rubro primary key(CodRubro),
)


create table Pelicula(
	CodPel int,
	titulo varchar(50),
	duracion time,
	año int,
	CodRubro int,
	constraint pk_codpel primary key(CodPel),
	constraint fk_pelicula_rubro foreign key(CodRubro) references Rubro(CodRubro)
)

create table Ejemplar(
	CodEj int,
	CodPel int,
	Estado varchar(50),
	Ubicacion int,
	constraint pk_ejemplar primary key(CodEj,CodPel),
	constraint fk_ejemplar_pelicula foreign key(CodPel) references Pelicula(CodPel)
)

create table Cliente (
	Cod_Cli int,
	Nombre varchar(50),
	Apellido varchar(50),
	Direccion varchar(50),
	Tel varchar(50),
	Email varchar(50),
	constraint pk_cliente primary key(Cod_Cli),
)

create table Prestamo(
	CodPrest int,
	CodEj int,
	CodPel int,
	CodCli int,
	FechaPrest date,
	FechaDev date,
	constraint pk_prestamo primary key(CodPrest),
	constraint fk_prestamo_ejemplar foreign key(CodEj,CodPel) references Ejemplar(CodEj,CodPel),
	constraint fk_prestamo_cliente foreign key(CodCli) references Cliente(Cod_Cli)
)

