use Ejercicio6
go



create table Vuelo(
	NroVuelo int,
	Desde varchar(50),
	Hasta varchar(50),
	Fecha date,
	constraint pk_vuelo primary key(NroVuelo)
)


create table Avion_utilizado(
	NroVuelo int,
	TipoAvion varchar(50),
	NroAvion int,
	constraint pk_avion_utilizado primary key(NroVuelo),
	constraint fk_avion_utilizado_vuelo foreign key(nrovuelo) references vuelo(nrovuelo) on delete cascade
)


create table Info_pasajeros(
	NroVuelo int,
	Documento int,
	Nombre varchar(50),
	Origen varchar(50),
	Destino varchar(50)
	constraint pk_info_pasajeros primary key(NroVuelo,Documento),
	constraint fk_into_pasajeros_vuelo foreign key(NroVuelo) references vuelo(NroVuelo) on delete cascade
)