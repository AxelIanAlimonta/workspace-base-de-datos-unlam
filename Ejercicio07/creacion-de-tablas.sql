use Ejercicio7
go

create table auto(
	matricula varchar(50),
	modelo varchar(50),
	año int,
	constraint pk_auto primary key(matricula)
)

create table chofer(
	nroLicencia int,
	nombre varchar(50),
	apellido varchar(50),
	fecha_ingreso date,
	telefono varchar(50),
	constraint pk_chofer primary key(nrolicencia)
)

create table viaje(
	FechaHoraInicio datetime,
	FechaHoraFin datetime,
	chofer int,
	cliente int,
	auto varchar(50),
	kmTotales float,
	esperaTotal time,
	costoEspera money,
	costoKms money,
	constraint pk_viaje primary key(FechaHoraInicio,chofer),
	constraint fk_viaje_chofer foreign key(chofer) references chofer(nroLicencia),
	constraint fk_viaje_cliente foreign key(cliente) references Cliente(nroCliente),
	constraint fk_viaje_auto foreign key(auto) references auto(matricula)
)

create table Cliente(
	nroCliente int,
	calle varchar(50),
	nro int,
	localidad varchar(50),
	constraint pk_cliente primary key(nrocliente)
)